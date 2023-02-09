-- PROCEDURE: dwh.usp_f_tcaltaxpsotings(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tcaltaxpsotings(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tcaltaxpsotings(
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
    FROM stg.stg_tcal_tax_postings;

    UPDATE dwh.f_tcaltaxpsotings t
    SET
        acct_type                    = s.acct_type,
        acct_subtype                 = s.acct_subtype,
        acct_code                    = s.acct_code,
        contra_acct_type             = s.contra_acct_type,
        dr_cr_flag                   = s.dr_cr_flag,
        original_comp_tax_amt        = s.original_comp_tax_amt,
        comp_tax_amt                 = s.comp_tax_amt,
        corr_tax_amt                 = s.corr_tax_amt,
        comp_tax_amt_bascurr         = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr         = s.corr_tax_amt_bascurr,
        comp_tax_amt_pbascurr        = s.comp_tax_amt_pbascurr,
        corr_tax_amt_pbascurr        = s.corr_tax_amt_pbascurr,
        cost_center                  = s.cost_center,
        analysis_code                = s.analysis_code,
        subanalysis_code             = s.subanalysis_code,
        posting_curr                 = s.posting_curr,
        comp_posting_amt             = s.comp_posting_amt,
        corr_posting_amt             = s.corr_posting_amt,
        created_by                   = s.created_by,
        created_date                 = s.created_date,
        modified_by                  = s.modified_by,
        modified_date                = s.modified_date,
        pbas_exch_rate               = s.pbas_exch_rate,
        sub_account_code             = s.sub_account_code,
        bas_exch_rate                = s.bas_exch_rate,
        tax_code                     = s.tax_code,
        posting_flag                 = s.posting_flag,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_tcal_tax_postings s
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_line_no = s.tran_line_no
    AND t.acct_line_no = s.acct_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tcaltaxpsotings
    (
        tran_no					, tax_type				, tran_type				, tran_ou			, tran_line_no, 
		acct_line_no			, acct_type				, acct_subtype			, acct_code			, contra_acct_type, 
		dr_cr_flag				, original_comp_tax_amt	, comp_tax_amt			, corr_tax_amt		, comp_tax_amt_bascurr, 
		corr_tax_amt_bascurr	, comp_tax_amt_pbascurr	, corr_tax_amt_pbascurr	, cost_center		, analysis_code, 
		subanalysis_code		, posting_curr			, comp_posting_amt		, corr_posting_amt	, created_by, 
		created_date			, modified_by			, modified_date			, pbas_exch_rate	, sub_account_code, 
		bas_exch_rate			, tax_code				, posting_flag			, 
		etlactiveind			, etljobname			, envsourcecd			, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.tran_no				, s.tax_type				, s.tran_type				, s.tran_ou				, s.tran_line_no, 
		s.acct_line_no			, s.acct_type				, s.acct_subtype			, s.acct_code			, s.contra_acct_type, 
		s.dr_cr_flag			, s.original_comp_tax_amt	, s.comp_tax_amt			, s.corr_tax_amt		, s.comp_tax_amt_bascurr, 
		s.corr_tax_amt_bascurr	, s.comp_tax_amt_pbascurr	, s.corr_tax_amt_pbascurr	, s.cost_center			, s.analysis_code,
		s.subanalysis_code		, s.posting_curr			, s.comp_posting_amt		, s.corr_posting_amt	, s.created_by,
		s.created_date			, s.modified_by				, s.modified_date			, s.pbas_exch_rate		, s.sub_account_code,
		s.bas_exch_rate			, s.tax_code				, s.posting_flag			,
					1			, p_etljobname				, p_envsourcecd				, p_datasourcecd		, NOW()
    FROM stg.stg_tcal_tax_postings s
    LEFT JOIN dwh.f_tcaltaxpsotings t
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

    INSERT INTO raw.raw_tcal_tax_postings
    (
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, 
		acct_line_no, acct_type, acct_subtype, acct_code, contra_acct_type, 
		dr_cr_flag, original_comp_tax_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, 
		corr_tax_amt_bascurr, comp_tax_amt_pbascurr, corr_tax_amt_pbascurr, cost_center, analysis_code, 
		subanalysis_code, posting_curr, comp_posting_amt, corr_posting_amt, addnl_param1,
		addnl_param2, addnl_param3, addnl_param4, created_by, created_date, 
		modified_by, modified_date, pbas_exch_rate, sub_acct_type, sub_account_code,
		sub_cost_center, anal_code_sub, sub_anal_code_sub, sub_acct_sub_type, bas_exch_rate, 
		tax_code, ref_doc_no, ref_doc_ou, ref_doc_type, cr_doc_term, 
		ttran_taxable_amt, ttran_tax_amt, ttran_tax_code, posting_flag, ref_doc_line_no,
		etlcreatedatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tran_line_no,
		acct_line_no, acct_type, acct_subtype, acct_code, contra_acct_type,
		dr_cr_flag, original_comp_tax_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr,
		corr_tax_amt_bascurr, comp_tax_amt_pbascurr, corr_tax_amt_pbascurr, cost_center, analysis_code, 
		subanalysis_code, posting_curr, comp_posting_amt, corr_posting_amt, addnl_param1,
		addnl_param2, addnl_param3, addnl_param4, created_by, created_date, 
		modified_by, modified_date, pbas_exch_rate, sub_acct_type, sub_account_code, 
		sub_cost_center, anal_code_sub, sub_anal_code_sub, sub_acct_sub_type, bas_exch_rate,
		tax_code, ref_doc_no, ref_doc_ou, ref_doc_type, cr_doc_term,
		ttran_taxable_amt, ttran_tax_amt, ttran_tax_code, posting_flag, ref_doc_line_no,
		etlcreatedatetime
    FROM stg.stg_tcal_tax_postings;
    
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
ALTER PROCEDURE dwh.usp_f_tcaltaxpsotings(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
