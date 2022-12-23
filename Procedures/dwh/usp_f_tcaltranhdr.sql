CREATE PROCEDURE dwh.usp_f_tcaltranhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    FROM stg.stg_tcal_tran_hdr;

    UPDATE dwh.F_tcaltranhdr t
    SET
		company_key					  = c.company_key,
        tax_community                 = s.tax_community,
        tran_date                     = s.tran_date,
        applicable_flag               = s.applicable_flag,
        company_code                  = s.company_code,
        buid                          = s.buid,
        fbid                          = s.fbid,
        tran_curr                     = s.tran_curr,
        incl_option                   = s.incl_option,
        tax_excl_amt                  = s.tax_excl_amt,
        tax_incl_amt                  = s.tax_incl_amt,
        tran_amt                      = s.tran_amt,
        comp_tax_amt                  = s.comp_tax_amt,
        corr_tax_amt                  = s.corr_tax_amt,
        party_type                    = s.party_type,
        supp_cust_code                = s.supp_cust_code,
        assessee_type                 = s.assessee_type,
        cap_deduct_charge             = s.cap_deduct_charge,
        bas_exch_rate                 = s.bas_exch_rate,
        pbas_exch_rate                = s.pbas_exch_rate,
        comp_tax_amt_bascurr          = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr          = s.corr_tax_amt_bascurr,
        nontax_tc_amt                 = s.nontax_tc_amt,
        nontax_disc_amt               = s.nontax_disc_amt,
        component_name                = s.component_name,
        original_tran_no              = s.original_tran_no,
        reversed_tran_no              = s.reversed_tran_no,
        doc_status                    = s.doc_status,
        tax_status                    = s.tax_status,
        cert_recd_status              = s.cert_recd_status,
        dr_cr_flag                    = s.dr_cr_flag,
        usage_id                      = s.usage_id,
        trade_type                    = s.trade_type,
        created_at                    = s.created_at,
        created_by                    = s.created_by,
        created_date                  = s.created_date,
        modified_by                   = s.modified_by,
        modified_date                 = s.modified_date,
        s_timestamp                     = s.timestamp,
        receipt_type                  = s.receipt_type,
        threshold_flag                = s.threshold_flag,
        capital_flag                  = s.capital_flag,
        post_date                     = s.post_date,
        tcal_pdc_flag                 = s.tcal_pdc_flag,
        supp_inv_no                   = s.supp_inv_no,
        supp_inv_date                 = s.supp_inv_date,
        supp_inv_amount               = s.supp_inv_amount,
        nature_of_reason              = s.nature_of_reason,
        recon_sup_tax_inv_flag        = s.recon_sup_tax_inv_flag,
        Aadhaar_No                    = s.Aadhaar_No,
        pan_no                        = s.pan_no,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_tcal_tran_hdr s
	LEFT JOIN dwh.d_company c
	on s.company_code = c.company_code
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tcaltranhdr
    (	company_key,
        tran_no, tax_type, tran_type, tran_ou, tax_community, 
		tran_date, applicable_flag, company_code, buid, fbid, 
		tran_curr, incl_option, tax_excl_amt, tax_incl_amt, tran_amt, 
		comp_tax_amt, corr_tax_amt, party_type, supp_cust_code, assessee_type, 
		cap_deduct_charge, bas_exch_rate, pbas_exch_rate, comp_tax_amt_bascurr, corr_tax_amt_bascurr, 
		nontax_tc_amt, nontax_disc_amt, component_name, original_tran_no, reversed_tran_no, 
		doc_status, tax_status, cert_recd_status, dr_cr_flag, usage_id, 
		trade_type, created_at, created_by, created_date, modified_by, 
		modified_date, s_timestamp, receipt_type, threshold_flag, capital_flag, 
		post_date, tcal_pdc_flag, supp_inv_no, supp_inv_date, supp_inv_amount, 
		nature_of_reason, recon_sup_tax_inv_flag, Aadhaar_No, pan_no, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		c.company_key,
        s.tran_no, s.tax_type, s.tran_type, s.tran_ou, s.tax_community, 
		s.tran_date, s.applicable_flag, s.company_code, s.buid, s.fbid, 
		s.tran_curr, s.incl_option, s.tax_excl_amt, s.tax_incl_amt, s.tran_amt, 
		s.comp_tax_amt, s.corr_tax_amt, s.party_type, s.supp_cust_code, s.assessee_type, 
		s.cap_deduct_charge, s.bas_exch_rate, s.pbas_exch_rate, s.comp_tax_amt_bascurr, s.corr_tax_amt_bascurr, 
		s.nontax_tc_amt, s.nontax_disc_amt, s.component_name, s.original_tran_no, s.reversed_tran_no, 
		s.doc_status, s.tax_status, s.cert_recd_status, s.dr_cr_flag, s.usage_id, 
		s.trade_type, s.created_at, s.created_by, s.created_date, s.modified_by, 
		s.modified_date, s.timestamp, s.receipt_type, s.threshold_flag, s.capital_flag, 
		s.post_date, s.tcal_pdc_flag, s.supp_inv_no, s.supp_inv_date, s.supp_inv_amount, 
		s.nature_of_reason, s.recon_sup_tax_inv_flag, s.Aadhaar_No, s.pan_no, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tcal_tran_hdr s
	LEFT JOIN dwh.d_company c
	on s.company_code = c.company_code
    LEFT JOIN dwh.F_tcaltranhdr t
    ON s.tran_no = t.tran_no
    AND s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tcal_tran_hdr
    (
        tran_no, tax_type, tran_type, tran_ou, tax_community, tran_date, applicable_flag, company_code, buid, fbid, tran_curr, incl_option, tax_excl_amt, tax_incl_amt, tran_amt, comp_tax_amt, corr_tax_amt, party_type, supp_cust_code, assessee_type, cap_deduct_charge, bas_exch_rate, pbas_exch_rate, comp_tax_amt_bascurr, corr_tax_amt_bascurr, nontax_tc_amt, nontax_disc_amt, component_name, original_tran_no, reversed_tran_no, doc_status, tax_status, tax_adj_status, cert_recd_status, dr_cr_flag, usage_id, trade_type, tax_on, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_at, created_by, created_date, modified_by, modified_date, timestamp, receipt_type, tax_amt_invoiced, threshold_flag, capital_flag, ttran_taxable_amt, ttran_tax_amt, post_date, tcal_pdc_flag, prop_wht_amt, app_wht_amt, supp_inv_no, supp_inv_date, supp_inv_amount, ack_no, nature_of_reason, sec_heading, sub_heading, eway_bill_no, valid_upto, eway_bill_date, original_supp_inv_no, recon_sup_tax_inv_flag, gstr2a_classification, Aadhaar_No, pan_no, einv_Qrcode, InvRefNum, etlcreateddatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tax_community, tran_date, applicable_flag, company_code, buid, fbid, tran_curr, incl_option, tax_excl_amt, tax_incl_amt, tran_amt, comp_tax_amt, corr_tax_amt, party_type, supp_cust_code, assessee_type, cap_deduct_charge, bas_exch_rate, pbas_exch_rate, comp_tax_amt_bascurr, corr_tax_amt_bascurr, nontax_tc_amt, nontax_disc_amt, component_name, original_tran_no, reversed_tran_no, doc_status, tax_status, tax_adj_status, cert_recd_status, dr_cr_flag, usage_id, trade_type, tax_on, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_at, created_by, created_date, modified_by, modified_date, timestamp, receipt_type, tax_amt_invoiced, threshold_flag, capital_flag, ttran_taxable_amt, ttran_tax_amt, post_date, tcal_pdc_flag, prop_wht_amt, app_wht_amt, supp_inv_no, supp_inv_date, supp_inv_amount, ack_no, nature_of_reason, sec_heading, sub_heading, eway_bill_no, valid_upto, eway_bill_date, original_supp_inv_no, recon_sup_tax_inv_flag, gstr2a_classification, Aadhaar_No, pan_no, einv_Qrcode, InvRefNum, etlcreateddatetime
    FROM stg.stg_tcal_tran_hdr;
    
    END IF;
	
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;