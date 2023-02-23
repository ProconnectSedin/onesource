-- PROCEDURE: dwh.usp_f_sracctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sracctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sracctinfodtl(
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
    FROM stg.stg_sr_acctinfo_dtl;

    UPDATE dwh.F_sracctinfodtl t
    SET
	
		account_code_key  			= COALESCE(acc.opcoa_key, -1),
		currency_key				= COALESCE(cr.curr_key, -1),
        ou_id                      = s.ou_id,
        tran_no                    = s.tran_no,
        tran_type                  = s.tran_type,
        acct_lineno                = s.acct_lineno,
        fb_id                      = s.fb_id,
        acc_code                   = s.acc_code,
        drcr_flag                  = s.drcr_flag,
        timestamp                  = s.timestamp,
        acct_type                  = s.acct_type,
        fin_post_date              = s.fin_post_date,
        currency                   = s.currency,
        cost_center                = s.cost_center,
        tran_amt                   = s.tran_amt,
        business_unit              = s.business_unit,
        analysis_code              = s.analysis_code,
        sub_analysis_code          = s.sub_analysis_code,
        base_cur_exrate            = s.base_cur_exrate,
        base_amt                   = s.base_amt,
        par_base_cur_exrate        = s.par_base_cur_exrate,
        par_base_amt               = s.par_base_amt,
        status                     = s.status,
        batch_id                   = s.batch_id,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        modifiedby                 = s.modifiedby,
        modifieddate               = s.modifieddate,
        hdrremarks                 = s.hdrremarks,
        project_ou                 = s.project_ou,
        Project_code               = s.Project_code,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_sr_acctinfo_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.acc_code
  LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    WHERE t.ou_id = s.ou_id
    AND t.tran_no = s.tran_no
    AND t.tran_type = s.tran_type
    AND t.acct_lineno = s.acct_lineno
    AND t.fb_id = s.fb_id
    AND t.acc_code = s.acc_code
    AND t.drcr_flag = s.drcr_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sracctinfodtl
    (
       account_code_key,currency_key, ou_id, tran_no, tran_type, acct_lineno, fb_id, acc_code, drcr_flag, timestamp, acct_type, fin_post_date, currency, cost_center, tran_amt, business_unit, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, modifiedby, modifieddate, hdrremarks, project_ou, Project_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),
COALESCE(cr.curr_key, -1), s.ou_id, s.tran_no, s.tran_type, s.acct_lineno, s.fb_id, s.acc_code, s.drcr_flag, s.timestamp, s.acct_type, s.fin_post_date, s.currency, s.cost_center, s.tran_amt, s.business_unit, s.analysis_code, s.sub_analysis_code, s.base_cur_exrate, s.base_amt, s.par_base_cur_exrate, s.par_base_amt, s.status, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.hdrremarks, s.project_ou, s.Project_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sr_acctinfo_dtl s
		LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.acc_code
  LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    LEFT JOIN dwh.F_sracctinfodtl t
    ON s.ou_id = t.ou_id
    AND s.tran_no = t.tran_no
    AND s.tran_type = t.tran_type
    AND s.acct_lineno = t.acct_lineno
    AND s.fb_id = t.fb_id
    AND s.acc_code = t.acc_code
    AND s.drcr_flag = t.drcr_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sr_acctinfo_dtl
    (
        ou_id, tran_no, tran_type, acct_lineno, fb_id, acc_code, drcr_flag, timestamp, acct_type, fin_post_date, currency, cost_center, tran_amt, business_unit, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, modifiedby, modifieddate, hdrremarks, project_ou, Project_code, etlcreateddatetime
    )
    SELECT
        ou_id, tran_no, tran_type, acct_lineno, fb_id, acc_code, drcr_flag, timestamp, acct_type, fin_post_date, currency, cost_center, tran_amt, business_unit, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, modifiedby, modifieddate, hdrremarks, project_ou, Project_code, etlcreateddatetime
    FROM stg.stg_sr_acctinfo_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_sracctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
