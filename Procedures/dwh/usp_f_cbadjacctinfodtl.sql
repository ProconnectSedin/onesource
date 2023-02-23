-- PROCEDURE: dwh.usp_f_cbadjacctinfodtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cbadjacctinfodtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cbadjacctinfodtl(
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
    FROM stg.Stg_cbadj_acct_info_dtl;

    UPDATE dwh.F_cbadjacctinfodtl t
    SET
		company_key				= COALESCE(co.company_key,-1),
		account_key				= COALESCE(op.opcoa_key,-1),
		currency_key			= COALESCE(cur.curr_key,-1),
		cust_key				= COALESCE(cu.customer_key,-1),
        ou_id                   = s.ou_id,
        tran_no                 = s.tran_no,
        tran_type               = s.tran_type,
        account_code            = s.account_code,
        drcr_flag               = s.drcr_flag,
        line_no                 = s.line_no,
        company_code            = s.company_code,
        fb_id                   = s.fb_id,
        fin_post_date           = s.fin_post_date,
        currency_code           = s.currency_code,
        cost_center             = s.cost_center,
        tran_amount             = s.tran_amount,
        basecur_erate           = s.basecur_erate,
        base_amount             = s.base_amount,
        pbcur_erate             = s.pbcur_erate,
        par_base_amt            = s.par_base_amt,
        fin_post_status         = s.fin_post_status,
        transaction_date        = s.transaction_date,
        account_type            = s.account_type,
        guid                    = s.guid,
        bu_id                   = s.bu_id,
        ref_doc_no              = s.ref_doc_no,
        ref_doc_ou              = s.ref_doc_ou,
        ref_doc_type            = s.ref_doc_type,
        ref_doc_term            = s.ref_doc_term,
        cust_code               = s.cust_code,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_cbadj_acct_info_dtl s
	LEFT JOIN dwh.d_customer cu
	ON cu.customer_id = s.cust_code
	AND cu.customer_ou = s.ou_id
	LEFT JOIN dwh.d_currency cur
	ON cur.iso_curr_code = s.currency_code
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.account_code
	LEFT JOIN dwh.d_company co
	ON co.company_code = s.company_code
    WHERE t.ou_id = s.ou_id
    AND t.tran_no = s.tran_no
    AND t.tran_type = s.tran_type
    AND t.account_code = s.account_code
    AND t.drcr_flag = s.drcr_flag
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cbadjacctinfodtl
    (
		company_key, account_key, currency_key, cust_key,  
		ou_id, tran_no, tran_type, account_code, drcr_flag, line_no, company_code, fb_id, fin_post_date, currency_code, cost_center, tran_amount, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, transaction_date, account_type, guid, bu_id, ref_doc_no, ref_doc_ou, ref_doc_type, ref_doc_term, cust_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(co.company_key,-1), COALESCE(op.opcoa_key,-1), COALESCE(cur.curr_key,-1), COALESCE(cu.customer_key,-1),
        s.ou_id, s.tran_no, s.tran_type, s.account_code, s.drcr_flag, s.line_no, s.company_code, s.fb_id, s.fin_post_date, s.currency_code, s.cost_center, s.tran_amount, s.basecur_erate, s.base_amount, s.pbcur_erate, s.par_base_amt, s.fin_post_status, s.transaction_date, s.account_type, s.guid, s.bu_id, s.ref_doc_no, s.ref_doc_ou, s.ref_doc_type, s.ref_doc_term, s.cust_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_cbadj_acct_info_dtl s
	LEFT JOIN dwh.d_customer cu
	ON cu.customer_id = s.cust_code
	AND cu.customer_ou = s.ou_id
	LEFT JOIN dwh.d_currency cur
	ON cur.iso_curr_code = s.currency_code
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.account_code
	LEFT JOIN dwh.d_company co
	ON co.company_code = s.company_code
    LEFT JOIN dwh.F_cbadjacctinfodtl t
    ON s.ou_id = t.ou_id
    AND s.tran_no = t.tran_no
    AND s.tran_type = t.tran_type
    AND s.account_code = t.account_code
    AND s.drcr_flag = t.drcr_flag
    AND s.line_no = t.line_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cbadj_acct_info_dtl
    (
        ou_id, tran_no, tran_type, account_code, drcr_flag, line_no, company_code, fb_id, fin_post_date, currency_code, cost_center, tran_amount, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, transaction_date, account_type, guid, bu_id, ref_doc_no, source_comp, component_name, ref_doc_ou, ref_doc_type, ref_doc_term, narration, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, cust_code, address_id, pdc_flag, etlcreateddatetime
    )
    SELECT
        ou_id, tran_no, tran_type, account_code, drcr_flag, line_no, company_code, fb_id, fin_post_date, currency_code, cost_center, tran_amount, analysis_code, subanalysis_code, basecur_erate, base_amount, pbcur_erate, par_base_amt, fin_post_status, transaction_date, account_type, guid, bu_id, ref_doc_no, source_comp, component_name, ref_doc_ou, ref_doc_type, ref_doc_term, narration, project_ou, Project_code, afe_number, job_number, refcostcenter_hdr, cust_code, address_id, pdc_flag, etlcreateddatetime
    FROM stg.Stg_cbadj_acct_info_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_cbadjacctinfodtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
