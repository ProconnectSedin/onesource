-- PROCEDURE: dwh.usp_f_tstltranhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tstltranhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tstltranhdr(
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
   FROM stg.stg_tstl_tran_hdr;

    UPDATE dwh.F_tstltranhdr t
    SET
		company_key					= COALESCE(co.company_key,-1),
        tran_no                     = s.tran_no,
        tax_type                    = s.tax_type,
        tran_type                   = s.tran_type,
        tran_ou                     = s.tran_ou,
        tax_community               = s.tax_community,
        tran_date                   = s.tran_date,
        applicable_flag             = s.applicable_flag,
        company_code                = s.company_code,
        buid                        = s.buid,
        fbid                        = s.fbid,
        tran_curr                   = s.tran_curr,
        incl_option                 = s.incl_option,
        tax_excl_amt                = s.tax_excl_amt,
        tax_incl_amt                = s.tax_incl_amt,
        comp_tax_amt                = s.comp_tax_amt,
        corr_tax_amt                = s.corr_tax_amt,
        party_type                  = s.party_type,
        supp_cust_code              = s.supp_cust_code,
        assessee_type               = s.assessee_type,
        cap_deduct_charge           = s.cap_deduct_charge,
        bas_exch_rate               = s.bas_exch_rate,
        pbas_exch_rate              = s.pbas_exch_rate,
        comp_tax_amt_bascurr        = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr        = s.corr_tax_amt_bascurr,
        nontax_tc_amt               = s.nontax_tc_amt,
        nontax_disc_amt             = s.nontax_disc_amt,
        component_name              = s.component_name,
        original_tran_no            = s.original_tran_no,
        doc_status                  = s.doc_status,
        tax_status                  = s.tax_status,
        cert_recd_status            = s.cert_recd_status,
        dr_cr_flag                  = s.dr_cr_flag,
        usage_id                    = s.usage_id,
        tax_excl_amt_bascurr        = s.tax_excl_amt_bascurr,
        tax_incl_amt_bascurr        = s.tax_incl_amt_bascurr,
        weightage_factor            = s.weightage_factor,
        tax_rate                    = s.tax_rate,
        timestamp                   = s.timestamp,
        created_at                  = s.created_at,
        created_by                  = s.created_by,
        created_date                = s.created_date,
        modified_by                 = s.modified_by,
        modified_date               = s.modified_date,
        post_date                   = s.post_date,
        rev_doc_date                = s.rev_doc_date,
        rev_decl_year               = s.rev_decl_year,
        revdecl_period              = s.revdecl_period,
        tranamt                     = s.tranamt,
        rev_tran_no                 = s.rev_tran_no,
        tradetype                   = s.tradetype,
        rec_type                    = s.rec_type,
        threshld_flag               = s.threshld_flag,
        cap_flag                    = s.cap_flag,
        supp_cust_name              = s.supp_cust_name,
        supp_inv_no                 = s.supp_inv_no,
        supp_inv_date               = s.supp_inv_date,
        supp_inv_amount             = s.supp_inv_amount,
        recon_flag                  = s.recon_flag,
        nature_of_reason            = s.nature_of_reason,
        report_flag                 = s.report_flag,
        Aadhaar_No                  = s.Aadhaar_No,
        pan_no                      = s.pan_no,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_tstl_tran_hdr s
	LEFT JOIN dwh.d_company co
	ON co.company_code 	= s.company_code
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
	AND t.component_name = s.component_name;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tstltranhdr
    (
		company_key			,
        tran_no				, tax_type			, tran_type				, tran_ou				, tax_community, 
		tran_date			, applicable_flag	, company_code			, buid					, fbid, 
		tran_curr			, incl_option		, tax_excl_amt			, tax_incl_amt			, comp_tax_amt, 
		corr_tax_amt		, party_type		, supp_cust_code		, assessee_type			, cap_deduct_charge,
		bas_exch_rate		, pbas_exch_rate	, comp_tax_amt_bascurr	, corr_tax_amt_bascurr	, nontax_tc_amt,
		nontax_disc_amt		, component_name	, original_tran_no		, doc_status			, tax_status, 
		cert_recd_status	, dr_cr_flag		, usage_id				, tax_excl_amt_bascurr	, tax_incl_amt_bascurr, 
		weightage_factor	, tax_rate			, timestamp				, created_at			, created_by,
		created_date		, modified_by		, modified_date			, post_date				, rev_doc_date, 
		rev_decl_year		, revdecl_period	, tranamt				, rev_tran_no			, tradetype, 
		rec_type			, threshld_flag		, cap_flag				, supp_cust_name		, supp_inv_no,
		supp_inv_date		, supp_inv_amount	, recon_flag			, nature_of_reason		, report_flag, 
		Aadhaar_No			, pan_no			, 
		etlactiveind		, etljobname		, envsourcecd			, datasourcecd			, etlcreatedatetime
    )

    SELECT
		COALESCE(co.company_key,-1),
        s.tran_no			, s.tax_type		, s.tran_type			, s.tran_ou				, s.tax_community, 
		s.tran_date			, s.applicable_flag	, s.company_code		, s.buid				, s.fbid,
		s.tran_curr			, s.incl_option		, s.tax_excl_amt		, s.tax_incl_amt		, s.comp_tax_amt, 
		s.corr_tax_amt		, s.party_type		, s.supp_cust_code		, s.assessee_type		, s.cap_deduct_charge,
		s.bas_exch_rate		, s.pbas_exch_rate	, s.comp_tax_amt_bascurr, s.corr_tax_amt_bascurr, s.nontax_tc_amt, 
		s.nontax_disc_amt	, s.component_name	, s.original_tran_no	, s.doc_status			, s.tax_status,
		s.cert_recd_status	, s.dr_cr_flag		, s.usage_id			, s.tax_excl_amt_bascurr, s.tax_incl_amt_bascurr,
		s.weightage_factor	, s.tax_rate		, s.timestamp			, s.created_at			, s.created_by, 
		s.created_date		, s.modified_by		, s.modified_date		, s.post_date			, s.rev_doc_date,
		s.rev_decl_year		, s.revdecl_period	, s.tranamt				, s.rev_tran_no			, s.tradetype,
		s.rec_type			, s.threshld_flag	, s.cap_flag			, s.supp_cust_name		, s.supp_inv_no, 
		s.supp_inv_date		, s.supp_inv_amount	, s.recon_flag			, s.nature_of_reason	, s.report_flag, 
		s.Aadhaar_No		, s.pan_no			,
				1			, p_etljobname		, p_envsourcecd			, p_datasourcecd		, NOW()
    FROM stg.stg_tstl_tran_hdr s
	LEFT JOIN dwh.d_company co
	ON co.company_code 	= s.company_code
    LEFT JOIN dwh.F_tstltranhdr t
    ON s.tran_no = t.tran_no
    AND s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
	AND t.component_name = s.component_name
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tstl_tran_hdr
    (
        tran_no, tax_type, tran_type, tran_ou, tax_community, tran_date, applicable_flag, company_code, buid, fbid, tran_curr, incl_option, tax_excl_amt, tax_incl_amt, comp_tax_amt, corr_tax_amt, party_type, supp_cust_code, assessee_type, cap_deduct_charge, bas_exch_rate, pbas_exch_rate, comp_tax_amt_bascurr, corr_tax_amt_bascurr, nontax_tc_amt, nontax_disc_amt, component_name, original_tran_no, doc_status, tax_status, tax_adj_status, cert_recd_status, dr_cr_flag, usage_id, tax_excl_amt_bascurr, tax_incl_amt_bascurr, weightage_factor, tax_rate, addnl_param1, addnl_param2, addnl_param3, addnl_param4, timestamp, created_at, created_by, created_date, modified_by, modified_date, post_date, rev_doc_date, rev_decl_year, revdecl_period, tranamt, rev_tran_no, tradetype, taxon, rec_type, tax_amt_inv, threshld_flag, cap_flag, ttrantaxable_amt, ttrantax_amt, tcalpdc_flag, propwht_amt, appwht_amt, supp_cust_name, ack_no, supp_inv_no, supp_inv_date, supp_inv_amount, recon_flag, tax_adj_vouch_no, nature_of_reason, gsp_ret_status, sec_heading, sub_heading, report_flag, gst3b_ack_no, eway_bill_no, valid_upto, eway_bill_date, original_supp_inv_no, upload_date, upload_dec_year, upload_dec_period, gstr2a_classification, Aadhaar_No, pan_no, etlcreateddatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tax_community, tran_date, applicable_flag, company_code, buid, fbid, tran_curr, incl_option, tax_excl_amt, tax_incl_amt, comp_tax_amt, corr_tax_amt, party_type, supp_cust_code, assessee_type, cap_deduct_charge, bas_exch_rate, pbas_exch_rate, comp_tax_amt_bascurr, corr_tax_amt_bascurr, nontax_tc_amt, nontax_disc_amt, component_name, original_tran_no, doc_status, tax_status, tax_adj_status, cert_recd_status, dr_cr_flag, usage_id, tax_excl_amt_bascurr, tax_incl_amt_bascurr, weightage_factor, tax_rate, addnl_param1, addnl_param2, addnl_param3, addnl_param4, timestamp, created_at, created_by, created_date, modified_by, modified_date, post_date, rev_doc_date, rev_decl_year, revdecl_period, tranamt, rev_tran_no, tradetype, taxon, rec_type, tax_amt_inv, threshld_flag, cap_flag, ttrantaxable_amt, ttrantax_amt, tcalpdc_flag, propwht_amt, appwht_amt, supp_cust_name, ack_no, supp_inv_no, supp_inv_date, supp_inv_amount, recon_flag, tax_adj_vouch_no, nature_of_reason, gsp_ret_status, sec_heading, sub_heading, report_flag, gst3b_ack_no, eway_bill_no, valid_upto, eway_bill_date, original_supp_inv_no, upload_date, upload_dec_year, upload_dec_period, gstr2a_classification, Aadhaar_No, pan_no, etlcreateddatetime
    FROM stg.stg_tstl_tran_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_tstltranhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
