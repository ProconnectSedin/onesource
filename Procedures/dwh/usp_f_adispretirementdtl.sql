-- PROCEDURE: dwh.usp_f_adispretirementdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adispretirementdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adispretirementdtl(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.Stg_adisp_retirement_dtl;

    UPDATE dwh.F_adispretirementdtl t
    SET
		adispretirementdtl_lockey= coalesce(l.loc_key,-1),
		adispretirementdtl_currkey=coalesce(c.curr_key,-1),
        asset_number             = s.asset_number,
        tag_number               = s.tag_number,
        ou_id                    = s.ou_id,
        retirement_number        = s.retirement_number,
        asset_location           = s.asset_location,
        asset_class              = s.asset_class,
        cost_center              = s.cost_center,
        asset_cost               = s.asset_cost,
        cum_depr_amount          = s.cum_depr_amount,
        asset_book_value         = s.asset_book_value,
        retirement_mode          = s.retirement_mode,
        retirement_date          = s.retirement_date,
        customer                 = s.customer,
        claim_insurance          = s.claim_insurance,
        sale_value               = s.sale_value,
        gain_loss                = s.gain_loss,
        remarks                  = s.remarks,
        tag_status               = s.tag_status,
        reversal_number          = s.reversal_number,
        reverse_remarks          = s.reverse_remarks,
        invoice_number           = s.invoice_number,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        inv_currency             = s.inv_currency,
        exchange_rate            = s.exchange_rate,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.Stg_adisp_retirement_dtl s
	left join dwh.d_location l
	on l.loc_code	= s.asset_location
	and l.loc_ou		=s.ou_id
	left join dwh.d_currency c
	on c.iso_curr_code=s.inv_currency
    WHERE t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.ou_id = s.ou_id
    AND t.retirement_number = s.retirement_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_adispretirementdtl
    (
      adispretirementdtl_lockey, adispretirementdtl_currkey, asset_number, tag_number, ou_id, retirement_number, asset_location, asset_class, cost_center, asset_cost, cum_depr_amount, asset_book_value, retirement_mode, retirement_date, customer, claim_insurance, sale_value, gain_loss, remarks, tag_status, reversal_number, reverse_remarks, invoice_number, createdby, createddate, modifiedby, modifieddate, inv_currency, exchange_rate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     coalesce(l.loc_key,-1),coalesce(c.curr_key,-1),   s.asset_number, s.tag_number, s.ou_id, s.retirement_number, s.asset_location, s.asset_class, s.cost_center, s.asset_cost, s.cum_depr_amount, s.asset_book_value, s.retirement_mode, s.retirement_date, s.customer, s.claim_insurance, s.sale_value, s.gain_loss, s.remarks, s.tag_status, s.reversal_number, s.reverse_remarks, s.invoice_number, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.inv_currency, s.exchange_rate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_adisp_retirement_dtl s
	left join  dwh.d_location l
	on l.loc_code	= s.asset_location
	and l.loc_ou		=s.ou_id
	left join dwh.d_currency c
	on c.iso_curr_code=s.inv_currency	
    LEFT JOIN dwh.F_adispretirementdtl t
    ON s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.ou_id = t.ou_id
    AND s.retirement_number = t.retirement_number
    WHERE t.asset_number IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adisp_retirement_dtl
    (
        asset_number, tag_number, ou_id, retirement_number, timestamp, asset_location, asset_class, cost_center, asset_cost, cum_depr_amount, asset_book_value, retirement_mode, retirement_date, customer, claim_insurance, sale_value, gain_loss, remarks, tag_status, reversal_number, reverse_remarks, invoice_number, createdby, createddate, modifiedby, modifieddate, cum_imp_loss, inv_currency, exchange_rate, etlcreateddatetime
    )
    SELECT
        asset_number, tag_number, ou_id, retirement_number, timestamp, asset_location, asset_class, cost_center, asset_cost, cum_depr_amount, asset_book_value, retirement_mode, retirement_date, customer, claim_insurance, sale_value, gain_loss, remarks, tag_status, reversal_number, reverse_remarks, invoice_number, createdby, createddate, modifiedby, modifieddate, cum_imp_loss, inv_currency, exchange_rate, etlcreateddatetime
    FROM stg.Stg_adisp_retirement_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_adispretirementdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
