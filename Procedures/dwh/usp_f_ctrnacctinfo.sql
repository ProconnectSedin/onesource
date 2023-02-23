-- PROCEDURE: dwh.usp_f_ctrnacctinfo(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ctrnacctinfo(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ctrnacctinfo(
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
    FROM stg.stg_ctrn_acct_info;

    UPDATE dwh.F_ctrnacctinfo t
    SET
		account_code_key          =COALESCE(acc.opcoa_key, -1),
		ctrnacctinfo_customer_key  = COALESCE(cu.customer_key, -1),
		ctrnacctinfo_currency_key  =COALESCE(cr.curr_key, -1),
        ou_id                      = s.ou_id,
        tran_type                  = s.tran_type,
        tran_no                    = s.tran_no,
        transfer_doc_no            = s.transfer_doc_no,
        acc_code                   = s.acc_code,
        drcr_flag                  = s.drcr_flag,
        acc_type                   = s.acc_type,
        timestamp                  = s.timestamp,
        fb_id                      = s.fb_id,
        fin_post_date              = s.fin_post_date,
        currency                   = s.currency,
        customer_code              = s.customer_code,
        tran_amt                   = s.tran_amt,
        base_cur_exrate            = s.base_cur_exrate,
        base_amt                   = s.base_amt,
        par_base_cur_exrate        = s.par_base_cur_exrate,
        par_base_amt               = s.par_base_amt,
        status                     = s.status,
        batch_id                   = s.batch_id,
        createdby                  = s.createdby,
        createddate                = s.createddate,
        hdrremarks                 = s.hdrremarks,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_ctrn_acct_info s
	
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.acc_code
		LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.customer_code
        AND cu.customer_ou              = s.ou_id
      
 	 	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    WHERE t.ou_id = s.ou_id
    AND t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.transfer_doc_no = s.transfer_doc_no
    AND t.acc_code = s.acc_code
    AND t.drcr_flag = s.drcr_flag
    AND t.acc_type = s.acc_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ctrnacctinfo
    (
      account_code_key,ctrnacctinfo_customer_key, ctrnacctinfo_currency_key , ou_id, tran_type, tran_no, transfer_doc_no, acc_code, drcr_flag, acc_type, timestamp, fb_id, fin_post_date, currency, customer_code, tran_amt, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, hdrremarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),COALESCE(cu.customer_key, -1),COALESCE(cr.curr_key, -1), s.ou_id, s.tran_type, s.tran_no, s.transfer_doc_no, s.acc_code, s.drcr_flag, s.acc_type, s.timestamp, s.fb_id, s.fin_post_date, s.currency, s.customer_code, s.tran_amt, s.base_cur_exrate, s.base_amt, s.par_base_cur_exrate, s.par_base_amt, s.status, s.batch_id, s.createdby, s.createddate, s.hdrremarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ctrn_acct_info s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.acc_code
		LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.customer_code
        AND cu.customer_ou              = s.ou_id
      
 	 	LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency
    LEFT JOIN dwh.F_ctrnacctinfo t
    ON s.ou_id = t.ou_id
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.transfer_doc_no = t.transfer_doc_no
    AND s.acc_code = t.acc_code
    AND s.drcr_flag = t.drcr_flag
    AND s.acc_type = t.acc_type
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ctrn_acct_info
    (
        ou_id, tran_type, tran_no, transfer_doc_no, acc_code, drcr_flag, acc_type, timestamp, fb_id, fin_post_date, currency, customer_code, cost_center, tran_amt, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, modifiedby, modifieddate, hdrremarks, company_code, project_ou, Project_code, address_id, etlcreateddatetime
    )
    SELECT
        ou_id, tran_type, tran_no, transfer_doc_no, acc_code, drcr_flag, acc_type, timestamp, fb_id, fin_post_date, currency, customer_code, cost_center, tran_amt, analysis_code, sub_analysis_code, base_cur_exrate, base_amt, par_base_cur_exrate, par_base_amt, status, batch_id, createdby, createddate, modifiedby, modifieddate, hdrremarks, company_code, project_ou, Project_code, address_id, etlcreateddatetime
    FROM stg.stg_ctrn_acct_info;
    
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
ALTER PROCEDURE dwh.usp_f_ctrnacctinfo(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
