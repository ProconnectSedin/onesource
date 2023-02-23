-- PROCEDURE: dwh.usp_f_jvbkpostingsdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_jvbkpostingsdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_jvbkpostingsdtl(
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
    FROM stg.stg_jv_bk_postings_dtl;

    UPDATE dwh.F_jvbkpostingsdtl t
    SET
		jvbkpostingsdtl_cmpkey	 = coalesce(c.company_key,-1),
		jvbkpostingsdtl_datekey  = coalesce(d.datekey,-1),
		jvbkpostingsdtl_currkey  = coalesce(cu.curr_key,-1),
		jvbkpostingsdtl_opcoakey = coalesce(ac.opcoa_key,-1),
        tran_type                = s.tran_type,
        tran_ou                  = s.tran_ou,
        tran_no                  = s.tran_no,
        posting_line_no          = s.posting_line_no,
        timestamp                = s.timestamp,
        line_no                  = s.line_no,
        company_code             = s.company_code,
        posting_date             = s.posting_date,
        fb_id                    = s.fb_id,
        tran_date                = s.tran_date,
        account_code             = s.account_code,
        drcr_id                  = s.drcr_id,
        tran_currency            = s.tran_currency,
        tran_amount              = s.tran_amount,
        exchange_rate            = s.exchange_rate,
        base_amount              = s.base_amount,
        par_exchange_rate        = s.par_exchange_rate,
        par_base_amount          = s.par_base_amount,
        cost_center              = s.cost_center,
        analysis_code            = s.analysis_code,
        subanalysis_code         = s.subanalysis_code,
        guid                     = s.guid,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        source_comp              = s.source_comp,
        hdrremarks               = s.hdrremarks,
        mlremarks                = s.mlremarks,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_jv_bk_postings_dtl s
	left join dwh.d_company c
	on c.company_code =s.company_code
	left join dwh.d_date d
	on d.dateactual=s.posting_date::date
	left join dwh.d_currency cu
	ON cu.iso_curr_code  =s.tran_currency
	left join dwh.d_operationalaccountdetail ac
	ON ac.account_Code	=s.account_code
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.posting_line_no = s.posting_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_jvbkpostingsdtl
    (
       jvbkpostingsdtl_cmpkey, jvbkpostingsdtl_datekey, jvbkpostingsdtl_currkey, jvbkpostingsdtl_opcoakey, tran_type, tran_ou, tran_no, posting_line_no, timestamp, line_no, company_code, posting_date, fb_id, tran_date, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, createdby, createddate, modifiedby, modifieddate, source_comp, hdrremarks, mlremarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      coalesce(c.company_key,-1), coalesce(d.datekey,-1), coalesce(cu.curr_key,-1),coalesce(ac.opcoa_key,-1),  s.tran_type, s.tran_ou, s.tran_no, s.posting_line_no, s.timestamp, s.line_no, s.company_code, s.posting_date, s.fb_id, s.tran_date, s.account_code, s.drcr_id, s.tran_currency, s.tran_amount, s.exchange_rate, s.base_amount, s.par_exchange_rate, s.par_base_amount, s.cost_center, s.analysis_code, s.subanalysis_code, s.guid, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.source_comp, s.hdrremarks, s.mlremarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_jv_bk_postings_dtl s
	left join dwh.d_company c
	on c.company_code =s.company_code
	left join dwh.d_date d
	on d.dateactual=s.posting_date::date
	left join dwh.d_currency cu
	ON cu.iso_curr_code  =s.tran_currency
	left join dwh.d_operationalaccountdetail ac
	ON ac.account_Code	=s.account_code	
    LEFT JOIN dwh.F_jvbkpostingsdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.posting_line_no = t.posting_line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_jv_bk_postings_dtl
    (
        tran_type, tran_ou, tran_no, posting_line_no, timestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supp_code, uom, org_vat_base_amt, vat_line_no, createdby, createddate, modifiedby, modifieddate, vatusageid, source_comp, hdrremarks, mlremarks, roundoff_flag, item_tcd_type, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, posting_line_no, timestamp, line_no, company_code, posting_status, posting_date, fb_id, tran_date, account_type, account_code, drcr_id, tran_currency, tran_amount, exchange_rate, base_amount, par_exchange_rate, par_base_amount, cost_center, analysis_code, subanalysis_code, guid, entry_date, auth_date, item_code, item_variant, quantity, reftran_fbid, reftran_no, reftran_ou, ref_tran_type, supp_code, uom, org_vat_base_amt, vat_line_no, createdby, createddate, modifiedby, modifieddate, vatusageid, source_comp, hdrremarks, mlremarks, roundoff_flag, item_tcd_type, etlcreateddatetime
    FROM stg.stg_jv_bk_postings_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_jvbkpostingsdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
