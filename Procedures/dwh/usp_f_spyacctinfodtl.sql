-- PROCEDURE: dwh.usp_f_spyacctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_spyacctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_spyacctinfodtl(
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
    FROM stg.stg_spy_acct_info_dtl;

    UPDATE dwh.F_spyacctinfodtl t
    SET
		account_code_key 	   	= COALESCE(acc.opcoa_key, -1),   	
		currency_key 		   	= COALESCE(cr.curr_key, -1),   	
        ou_id                   = s.ou_id,
        posting_line_no         = s.posting_line_no,
        tran_no                 = s.tran_no,
        tran_type               = s.tran_type,
        account_code            = s.account_code,
        drcr_flag               = s.drcr_flag,
        timestamp               = s.timestamp,
        account_type            = s.account_type,
        fin_post_date           = s.fin_post_date,
        currency_code           = s.currency_code,
        cost_center             = s.cost_center,
        tran_amount             = s.tran_amount,
        fb_id                   = s.fb_id,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        basecur_erate           = s.basecur_erate,
        base_amount             = s.base_amount,
        pbcur_erate             = s.pbcur_erate,
        par_base_amt            = s.par_base_amt,
        batch_id                = s.batch_id,
        paybatch_no             = s.paybatch_no,
        bu_id                   = s.bu_id,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        component_name          = s.component_name,
        cr_doc_no               = s.cr_doc_no,
        cr_doc_ou               = s.cr_doc_ou,
        cr_doc_type             = s.cr_doc_type,
        cr_doc_term             = s.cr_doc_term,
        posting_flag            = s.posting_flag,
        fin_post_flag           = s.fin_post_flag,
        hdrremarks              = s.hdrremarks,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_spy_acct_info_dtl s
	
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code

 	 LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
    WHERE t.ou_id = s.ou_id
    AND t.posting_line_no = s.posting_line_no
    AND t.tran_no = s.tran_no
    AND t.tran_type = s.tran_type
    AND t.account_code = s.account_code
    AND t.drcr_flag = s.drcr_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_spyacctinfodtl
    (
      account_code_key,currency_key,ou_id, posting_line_no, tran_no, tran_type, account_code, drcr_flag, timestamp, account_type, fin_post_date, currency_code, cost_center, tran_amount, fb_id, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, batch_id, paybatch_no, bu_id, modifiedby, modifieddate, component_name, cr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_term, posting_flag, fin_post_flag, hdrremarks, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(acc.opcoa_key, -1),COALESCE(cr.curr_key, -1),s.ou_id, s.posting_line_no, s.tran_no, s.tran_type, s.account_code, s.drcr_flag, s.timestamp, s.account_type, s.fin_post_date, s.currency_code, s.cost_center, s.tran_amount, s.fb_id, s.analysis_code, s.subanalysis_code, s.basecur_erate, s.base_amount, s.pbcur_erate, s.par_base_amt, s.batch_id, s.paybatch_no, s.bu_id, s.modifiedby, s.modifieddate, s.component_name, s.cr_doc_no, s.cr_doc_ou, s.cr_doc_type, s.cr_doc_term, s.posting_flag, s.fin_post_flag, s.hdrremarks, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_spy_acct_info_dtl s
	
	LEFT JOIN dwh.d_operationalaccountdetail acc
        ON acc.account_code             = s.account_code

  LEFT JOIN dwh.d_currency cr
        ON cr.iso_curr_code             = s.currency_code
    LEFT JOIN dwh.F_spyacctinfodtl t
    ON s.ou_id = t.ou_id
    AND s.posting_line_no = t.posting_line_no
    AND s.tran_no = t.tran_no
    AND s.tran_type = t.tran_type
    AND s.account_code = t.account_code
    AND s.drcr_flag = t.drcr_flag
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_spy_acct_info_dtl
    (
        ou_id, posting_line_no, tran_no, tran_type, account_code, drcr_flag, timestamp, account_type, fin_post_date, currency_code, cost_center, tran_amount, fb_id, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, batch_id, paybatch_no, bu_id, createdby, createddate, modifiedby, modifieddate, component_name, cr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_term, posting_flag, fin_post_flag, hdrremarks, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, etlcreateddatetime
    )
    SELECT
        ou_id, posting_line_no, tran_no, tran_type, account_code, drcr_flag, timestamp, account_type, fin_post_date, currency_code, cost_center, tran_amount, fb_id, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, batch_id, paybatch_no, bu_id, createdby, createddate, modifiedby, modifieddate, component_name, cr_doc_no, cr_doc_ou, cr_doc_type, cr_doc_term, posting_flag, fin_post_flag, hdrremarks, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, etlcreateddatetime
    FROM stg.stg_spy_acct_info_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_spyacctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
