-- PROCEDURE: dwh.usp_f_tstltaxpostings(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tstltaxpostings(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tstltaxpostings(
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
    FROM stg.stg_tstl_tax_postings;

    UPDATE dwh.F_tstltaxpostings t
    SET
		account_key					 = coalesce(op.opcoa_key, -1),
        tran_no                      = s.tran_no,
        tax_type                     = s.tax_type,
        tran_type                    = s.tran_type,
        tran_ou                      = s.tran_ou,
        tran_line_no                 = s.tran_line_no,
        acct_line_no                 = s.acct_line_no,
        acct_type                    = s.acct_type,
        acct_subtype                 = s.acct_subtype,
        acct_code                    = s.acct_code,
        dr_cr_flag                   = s.dr_cr_flag,
        comp_tax_amt                 = s.comp_tax_amt,
        corr_tax_amt                 = s.corr_tax_amt,
        comp_tax_amt_bascurr         = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr         = s.corr_tax_amt_bascurr,
        comp_tax_amt_pbascurr        = s.comp_tax_amt_pbascurr,
        corr_tax_amt_pbascurr        = s.corr_tax_amt_pbascurr,
        cost_center                  = s.cost_center,
        analysis_code                = s.analysis_code,
        subanalysis_code             = s.subanalysis_code,
        created_by                   = s.created_by,
        created_date                 = s.created_date,
        modified_by                  = s.modified_by,
        modified_date                = s.modified_date,
        tax_code                     = s.tax_code,
        tax_tran_date                = s.tax_tran_date,
        contraacct_type              = s.contraacct_type,
        orig_comp_tax_amt            = s.orig_comp_tax_amt,
        compposting_amt              = s.compposting_amt,
        corrposting_amt              = s.corrposting_amt,
        pbasexch_rate                = s.pbasexch_rate,
        subaccount_code              = s.subaccount_code,
        basexch_rate                 = s.basexch_rate,
        post_flag                    = s.post_flag,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_tstl_tax_postings s
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.acct_code
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_line_no = s.tran_line_no
    AND t.acct_line_no = s.acct_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tstltaxpostings
    (
		account_key				,
        tran_no					, tax_type			, tran_type				, tran_ou				, tran_line_no, 
		acct_line_no			, acct_type			, acct_subtype			, acct_code				, dr_cr_flag,
		comp_tax_amt			, corr_tax_amt		, comp_tax_amt_bascurr	, corr_tax_amt_bascurr	, comp_tax_amt_pbascurr, 
		corr_tax_amt_pbascurr	, cost_center		, analysis_code			, subanalysis_code		, created_by,
		created_date			, modified_by		, modified_date			, tax_code				, tax_tran_date, 
		contraacct_type			, orig_comp_tax_amt	, compposting_amt		, corrposting_amt		, pbasexch_rate, 
		subaccount_code			, basexch_rate		, post_flag				, 
		etlactiveind			, etljobname		, envsourcecd			, datasourcecd			, etlcreatedatetime
    )

    SELECT
		coalesce(op.opcoa_key,-1),
        s.tran_no				, s.tax_type			, s.tran_type				, s.tran_ou					, s.tran_line_no,
		s.acct_line_no			, s.acct_type			, s.acct_subtype			, s.acct_code				, s.dr_cr_flag,
		s.comp_tax_amt			, s.corr_tax_amt		, s.comp_tax_amt_bascurr	, s.corr_tax_amt_bascurr	, s.comp_tax_amt_pbascurr, 
		s.corr_tax_amt_pbascurr	, s.cost_center			, s.analysis_code			, s.subanalysis_code		, s.created_by, 
		s.created_date			, s.modified_by			, s.modified_date			, s.tax_code				, s.tax_tran_date,
		s.contraacct_type		, s.orig_comp_tax_amt	, s.compposting_amt			, s.corrposting_amt			, s.pbasexch_rate, 
		s.subaccount_code		, s.basexch_rate		, s.post_flag				,
					1			, p_etljobname			, p_envsourcecd				, p_datasourcecd			, NOW()
    FROM stg.stg_tstl_tax_postings s
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON op.account_code = s.acct_code
    LEFT JOIN dwh.F_tstltaxpostings t
    ON s.tran_no = t.tran_no
    AND s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_line_no = t.tran_line_no
    AND s.acct_line_no = t.acct_line_no
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tstl_tax_postings
    (
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, acct_line_no, acct_type, acct_subtype, acct_code, dr_cr_flag, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, comp_tax_amt_pbascurr, corr_tax_amt_pbascurr, cost_center, analysis_code, subanalysis_code, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_code, tax_ref_doc_no, tax_ref_doc_ou, tax_ref_doc_type, tax_tran_date, tax_refdoc_line_no, contraacct_type, orig_comp_tax_amt, posting_curr, compposting_amt, corrposting_amt, pbasexch_rate, subacct_type, subaccount_code, subcost_center, analcode_sub, subanal_code_sub, subacct_sub_type, basexch_rate, refdoc_no, refdoc_ou, refdoc_type, crdoc_term, ttrantaxable_amt, ttrantax_amt, ttran_taxcode, post_flag, refdoc_line_no, etlcreateddatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, acct_line_no, acct_type, acct_subtype, acct_code, dr_cr_flag, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, comp_tax_amt_pbascurr, corr_tax_amt_pbascurr, cost_center, analysis_code, subanalysis_code, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_code, tax_ref_doc_no, tax_ref_doc_ou, tax_ref_doc_type, tax_tran_date, tax_refdoc_line_no, contraacct_type, orig_comp_tax_amt, posting_curr, compposting_amt, corrposting_amt, pbasexch_rate, subacct_type, subaccount_code, subcost_center, analcode_sub, subanal_code_sub, subacct_sub_type, basexch_rate, refdoc_no, refdoc_ou, refdoc_type, crdoc_term, ttrantaxable_amt, ttrantax_amt, ttran_taxcode, post_flag, refdoc_line_no, etlcreateddatetime
    FROM stg.stg_tstl_tax_postings;
    
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
ALTER PROCEDURE dwh.usp_f_tstltaxpostings(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
