-- PROCEDURE: dwh.usp_f_cpacctinfo(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cpacctinfo(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cpacctinfo(
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
    FROM stg.stg_cp_acct_info;

    UPDATE dwh.F_cpacctinfo t
    SET
	
		account_code_key            = COALESCE(acc.opcoa_key, -1),
		comp_code_key   			= COALESCE(co.company_key,-1),
		cpacctinfo_currency_key   	= COALESCE(cr.curr_key, -1),
		cpacctinfo_date_key   		= COALESCE(d.datekey,-1),
        ou_id                      = s.ou_id,
        tran_no                    = s.tran_no,
        fb_id                      = s.fb_id,
        acc_code                   = s.acc_code,
        drcr_flag                  = s.drcr_flag,
        tran_type                  = s.tran_type,
        line_no                    = s.line_no,
        timestamp                  = s.timestamp,
        tran_date                  = s.tran_date,
        fin_post_date              = s.fin_post_date,
        currency                   = s.currency,
        tran_amt                   = s.tran_amt,
        business_unit              = s.business_unit,
        base_cur_exrate            = s.base_cur_exrate,
        base_amt                   = s.base_amt,
        par_base_cur_exrate        = s.par_base_cur_exrate,
        par_base_amt               = s.par_base_amt,
        status                     = s.status,
        batch_id                   = s.batch_id,
        company_code               = s.company_code,
        component_name             = s.component_name,
        acct_type                  = s.acct_type,
        bank_cash_code             = s.bank_cash_code,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        modifiedby                 = s.modifiedby,
        modifieddate               = s.modifieddate,
        posting_flag               = s.posting_flag,
        remarks                    = s.remarks,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_cp_acct_info s
	
		 LEFT JOIN dwh.d_operationalaccountdetail acc
        ON s.acc_code            = acc.account_code
	LEFT JOIN dwh.d_company co     
    ON    s.company_code                   = co.company_code 
 	 LEFT JOIN dwh.d_currency cr
        ON s.currency=        cr.iso_curr_code   
	LEFT JOIN dwh.d_date d     
    ON    s.fin_post_date::date     = d.dateactual
    WHERE t.ou_id = s.ou_id
    AND t.tran_no = s.tran_no
    AND t.fb_id = s.fb_id
    AND t.acc_code = s.acc_code
    AND t.drcr_flag = s.drcr_flag
    AND t.tran_type = s.tran_type
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cpacctinfo
    (
       account_code_key,comp_code_key,cpacctinfo_currency_key,cpacctinfo_date_key, ou_id, tran_no, fb_id, acc_code, drcr_flag, tran_type, line_no, timestamp, tran_date, fin_post_date, currency, tran_amt, business_unit, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, company_code, component_name, acct_type, bank_cash_code, createdby, createddate, modifiedby, modifieddate, posting_flag, remarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1), COALESCE(co.company_key,-1), COALESCE(cr.curr_key, -1),COALESCE(d.datekey,-1), s.ou_id, s.tran_no, s.fb_id, s.acc_code, s.drcr_flag, s.tran_type, s.line_no, s.timestamp, s.tran_date, s.fin_post_date, s.currency, s.tran_amt, s.business_unit, s.base_cur_exrate, s.base_amt, s.par_base_cur_exrate, s.par_base_amt, s.status, s.batch_id, s.company_code, s.component_name, s.acct_type, s.bank_cash_code, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.posting_flag, s.remarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cp_acct_info s
	
	 LEFT JOIN dwh.d_operationalaccountdetail acc
        ON s.acc_code            = acc.account_code
	LEFT JOIN dwh.d_company co     
    ON    s.company_code                   = co.company_code 
 	 LEFT JOIN dwh.d_currency cr
        ON s.currency=        cr.iso_curr_code   
	LEFT JOIN dwh.d_date d     
    ON    s.fin_post_date::date     = d.dateactual
    LEFT JOIN dwh.F_cpacctinfo t
    ON s.ou_id = t.ou_id
    AND s.tran_no = t.tran_no
    AND s.fb_id = t.fb_id
    AND s.acc_code = t.acc_code
    AND s.drcr_flag = t.drcr_flag
    AND s.tran_type = t.tran_type
    AND s.line_no = t.line_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cp_acct_info
    (
        ou_id, tran_no, fb_id, acc_code, drcr_flag, tran_type, line_no, timestamp, tran_date, fin_post_date, currency, cost_center, tran_amt, business_unit, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, company_code, component_name, acct_type, bank_cash_code, createdby, createddate, modifiedby, modifieddate, sourcecomp, posting_flag, remarks, etlcreateddatetime
    )
    SELECT
        ou_id, tran_no, fb_id, acc_code, drcr_flag, tran_type, line_no, timestamp, tran_date, fin_post_date, currency, cost_center, tran_amt, business_unit, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, company_code, component_name, acct_type, bank_cash_code, createdby, createddate, modifiedby, modifieddate, sourcecomp, posting_flag, remarks, etlcreateddatetime
    FROM stg.stg_cp_acct_info;
    
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
ALTER PROCEDURE dwh.usp_f_cpacctinfo(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
