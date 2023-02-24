-- PROCEDURE: dwh.usp_F_adeppaccountinginfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_adeppaccountinginfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_adeppaccountinginfodtl(
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
    FROM stg.Stg_adepp_accounting_info_dtl;

    UPDATE dwh.F_adeppaccountinginfodtl t
    SET
		account_code_key = COALESCE(acc.opcoa_key, -1),
		comp_code_key = COALESCE(co.company_key,-1),
		currency_key = COALESCE(cr.curr_key, -1),
        ou_id               = s.ou_id,
        company_code        = s.company_code,
        tran_number         = s.tran_number,
        asset_number        = s.asset_number,
        tag_number          = s.tag_number,
        tran_type           = s.tran_type,
        tran_date           = s.tran_date,
        posting_date        = s.posting_date,
        account_code        = s.account_code,
        drcr_flag           = s.drcr_flag,
        currency            = s.currency,
        tran_amount         = s.tran_amount,
        fb_id               = s.fb_id,
        bu_id               = s.bu_id,
        cost_center         = s.cost_center,
        bc_erate            = s.bc_erate,
        base_amount         = s.base_amount,
        pbase_amount        = s.pbase_amount,
        account_type        = s.account_type,
        fin_period          = s.fin_period,
        createdby           = s.createdby,
        createddate         = s.createddate,
        batch_id            = s.batch_id,
        depr_book           = s.depr_book,
        etlactiveind        = 1,
        etljobname          = p_etljobname,
        envsourcecd         = p_envsourcecd,
        datasourcecd        = p_datasourcecd,
        etlupdatedatetime   = NOW()
    FROM stg.Stg_adepp_accounting_info_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code      = s.account_code
	LEFT JOIN dwh.d_company co     
    	ON    s.company_code      = co.company_code 
  	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code       = s.currency
    WHERE t.ou_id = s.ou_id
    AND t.company_code = s.company_code
    AND t.tran_number = s.tran_number
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.tran_date = s.tran_date
    AND t.account_code = s.account_code
    AND t.drcr_flag = s.drcr_flag
    AND t.fb_id = s.fb_id
    AND t.bu_id = s.bu_id
    AND t.fin_period = s.fin_period;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_adeppaccountinginfodtl
    (
      account_code_key,comp_code_key ,currency_key , ou_id, company_code, tran_number, asset_number, tag_number, tran_type, tran_date, posting_date, account_code, drcr_flag, currency, tran_amount, fb_id, bu_id, cost_center, bc_erate, base_amount, pbase_amount, account_type, fin_period, createdby, createddate, batch_id, depr_book, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),COALESCE(co.company_key,-1),COALESCE(cr.curr_key, -1),  s.ou_id, s.company_code, s.tran_number, s.asset_number, s.tag_number, s.tran_type, s.tran_date, s.posting_date, s.account_code, s.drcr_flag, s.currency, s.tran_amount, s.fb_id, s.bu_id, s.cost_center, s.bc_erate, s.base_amount, s.pbase_amount, s.account_type, s.fin_period, s.createdby, s.createddate, s.batch_id, s.depr_book, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_adepp_accounting_info_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code      = s.account_code
	LEFT JOIN dwh.d_company co     
    	ON    s.company_code      = co.company_code 
  	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code       = s.currency
    LEFT JOIN dwh.F_adeppaccountinginfodtl t
    ON s.ou_id = t.ou_id
    AND s.company_code = t.company_code
    AND s.tran_number = t.tran_number
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.tran_date = t.tran_date
    AND s.account_code = t.account_code
    AND s.drcr_flag = t.drcr_flag
    AND s.fb_id = t.fb_id
    AND s.bu_id = t.bu_id
    AND s.fin_period = t.fin_period
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adepp_accounting_info_dtl
    (
        timestamp, ou_id, company_code, tran_number, asset_number, tag_number, tran_type, tran_date, posting_date, account_code, drcr_flag, currency, tran_amount, fb_id, bu_id, cost_center, analysis_code, sub_analysis_code, bc_erate, base_amount, pbc_erate, pbase_amount, account_type, fin_period, createdby, createddate, modifiedby, modifieddate, batch_id, depr_book, etlcreateddatetime
    )
    SELECT
        timestamp, ou_id, company_code, tran_number, asset_number, tag_number, tran_type, tran_date, posting_date, account_code, drcr_flag, currency, tran_amount, fb_id, bu_id, cost_center, analysis_code, sub_analysis_code, bc_erate, base_amount, pbc_erate, pbase_amount, account_type, fin_period, createdby, createddate, modifiedby, modifieddate, batch_id, depr_book, etlcreateddatetime
    FROM stg.Stg_adepp_accounting_info_dtl;
    
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

ALTER PROCEDURE dwh.usp_F_adeppaccountinginfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
