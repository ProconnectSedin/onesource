CREATE PROCEDURE dwh.usp_f_sdininvoicehdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sdin_invoice_hdr;

    UPDATE dwh.F_sdininvoicehdr t
    SET
        tran_status                  = s.tran_status,
        tran_date                    = s.tran_date,
        anchor_date                  = s.anchor_date,
        fb_id                        = s.fb_id,
        auto_adjust                  = s.auto_adjust,
        tran_currency                = s.tran_currency,
        exchange_rate                = s.exchange_rate,
        pay_term                     = s.pay_term,
        payterm_version              = s.payterm_version,
        elec_pay                     = s.elec_pay,
        pay_method                   = s.pay_method,
        pay_to_supp                  = s.pay_to_supp,
        pay_mode                     = s.pay_mode,
        pay_priority                 = s.pay_priority,
        payment_ou                   = s.payment_ou,
        supp_code                    = s.supp_code,
        supp_invoice_no              = s.supp_invoice_no,
        supp_invoice_date            = s.supp_invoice_date,
        supp_invoice_amount          = s.supp_invoice_amount,
        supp_ou                      = s.supp_ou,
        comments                     = s.comments,
        tran_amount                  = s.tran_amount,
        par_exchange_rate            = s.par_exchange_rate,
        item_amount                  = s.item_amount,
        base_amount                  = s.base_amount,
        par_base_amount              = s.par_base_amount,
        rev_doc_no                   = s.rev_doc_no,
        rev_doc_ou                   = s.rev_doc_ou,
        rev_date                     = s.rev_date,
        ref_doc_no                   = s.ref_doc_no,
        ref_doc_ou                   = s.ref_doc_ou,
        rev_reason_code              = s.rev_reason_code,
        rev_remarks                  = s.rev_remarks,
        hld_reason_code              = s.hld_reason_code,
        hld_remarks                  = s.hld_remarks,
        auth_date                    = s.auth_date,
        disc_comp_basis              = s.disc_comp_basis,
        discount_proportional        = s.discount_proportional,
        cap_non_ded_charge           = s.cap_non_ded_charge,
        pre_round_off_amount         = s.pre_round_off_amount,
        rounded_off_amount           = s.rounded_off_amount,
        batch_id                     = s.batch_id,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        tcal_status                  = s.tcal_status,
        total_tcal_amount            = s.total_tcal_amount,
        tcal_exclusive_amt           = s.tcal_exclusive_amt,
        account_code                 = s.account_code,
        ibe_flag                     = s.ibe_flag,
        autogen_flag                 = s.autogen_flag,
        autogen_comp_id              = s.autogen_comp_id,
        prev_trnamt                  = s.prev_trnamt,
        afe_number                   = s.afe_number,
        cash_code                    = s.cash_code,
        Corr_roff                    = s.Corr_roff,
        Dervied_roff                 = s.Dervied_roff,
        num_series                   = s.num_series,
        supplierAddress              = s.supplierAddress,
        trnsfr_bill_date             = s.trnsfr_bill_date,
        rcti_flag                    = s.rcti_flag,
        own_taxregion                = s.own_taxregion,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_sdin_invoice_hdr s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.s_timestamp = s.timestamp
    AND t.payment_type = s.payment_type
    AND t.ict_flag = s.ict_flag
    AND t.Ales_Flag = s.Ales_Flag
    AND t.lgt_invoice = s.lgt_invoice
    AND t.MAIL_SENT = s.MAIL_SENT
    AND t.allow_auto_cap = s.allow_auto_cap;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sdininvoicehdr
    (
        tran_type, tran_ou, tran_no, s_timestamp, tran_status, 
		tran_date, anchor_date, fb_id, auto_adjust, tran_currency, 
		exchange_rate, pay_term, payterm_version, elec_pay, pay_method, 
		pay_to_supp, pay_mode, pay_priority, payment_ou, supp_code, 
		supp_invoice_no, supp_invoice_date, supp_invoice_amount, supp_ou, comments, 
		tran_amount, par_exchange_rate, item_amount, base_amount, par_base_amount, 
		rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, 
		rev_reason_code, rev_remarks, hld_reason_code, hld_remarks, auth_date, 
		disc_comp_basis, discount_proportional, cap_non_ded_charge, pre_round_off_amount, rounded_off_amount, 
		batch_id, createdby, createddate, modifiedby, modifieddate, 
		tcal_status, total_tcal_amount, tcal_exclusive_amt, account_code, ibe_flag, 
		autogen_flag, autogen_comp_id, prev_trnamt, afe_number, cash_code, 
		payment_type, Corr_roff, Dervied_roff, ict_flag, num_series, 
		Ales_Flag, supplierAddress, lgt_invoice, trnsfr_bill_date, rcti_flag, 
		MAIL_SENT, own_taxregion, allow_auto_cap, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.timestamp, s.tran_status, 
		s.tran_date, s.anchor_date, s.fb_id, s.auto_adjust, s.tran_currency, 
		s.exchange_rate, s.pay_term, s.payterm_version, s.elec_pay, s.pay_method, 
		s.pay_to_supp, s.pay_mode, s.pay_priority, s.payment_ou, s.supp_code, 
		s.supp_invoice_no, s.supp_invoice_date, s.supp_invoice_amount, s.supp_ou, s.comments, 
		s.tran_amount, s.par_exchange_rate, s.item_amount, s.base_amount, s.par_base_amount, 
		s.rev_doc_no, s.rev_doc_ou, s.rev_date, s.ref_doc_no, s.ref_doc_ou, 
		s.rev_reason_code, s.rev_remarks, s.hld_reason_code, s.hld_remarks, s.auth_date, 
		s.disc_comp_basis, s.discount_proportional, s.cap_non_ded_charge, s.pre_round_off_amount, s.rounded_off_amount, 
		s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 
		s.tcal_status, s.total_tcal_amount, s.tcal_exclusive_amt, s.account_code, s.ibe_flag, 
		s.autogen_flag, s.autogen_comp_id, s.prev_trnamt, s.afe_number, s.cash_code, 
		s.payment_type, s.Corr_roff, s.Dervied_roff, s.ict_flag, s.num_series, 
		s.Ales_Flag, s.supplierAddress, s.lgt_invoice, s.trnsfr_bill_date, s.rcti_flag, 
		s.MAIL_SENT, s.own_taxregion, s.allow_auto_cap, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sdin_invoice_hdr s
    LEFT JOIN dwh.F_sdininvoicehdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.timestamp = t.s_timestamp
    AND s.payment_type = t.payment_type
    AND s.ict_flag = t.ict_flag
    AND s.Ales_Flag = t.Ales_Flag
    AND s.lgt_invoice = t.lgt_invoice
    AND s.MAIL_SENT = t.MAIL_SENT
    AND s.allow_auto_cap = t.allow_auto_cap
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sdin_invoice_hdr
    (
        tran_type, tran_ou, tran_no, timestamp, tran_status, tran_date, anchor_date, fb_id, auto_adjust, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_method, pay_to_supp, pay_mode, pay_priority, payment_ou, supp_code, supp_invoice_no, supp_invoice_date, supp_invoice_amount, supp_ou, comments, address1, address2, address3, city, state, country, zip, phone, telex, fax, pager, mobile, mailstop, email, url, contact, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, supp_contallowed, supp_contactperson, supp_bankclearno, account_code, proposal_no, ibe_flag, BillOfLadingNo, BookingNo, MasterBillOfLadingNo, autogen_flag, autogen_comp_id, consistency_stamp, workflow_status, prev_trnamt, LC_number, LC_refid, project_ou, Project_code, afe_number, job_number, costcenter_hdr, inter_compflag, invoice_num_IMS, INVOICE_ID_IMS, VENDOR_ID_IMS, VENDOR_SITE_ID_IMS, ACCTS_PAY_CODE_COMBINATION_ID_IMS, DOC_SEQUENCE_ID_IMS, DOC_SEQUENCE_VALUE_IMS, cash_code, payment_type, workflow_error, Corr_roff, Dervied_roff, hold_amt, holdaccount, retaccount, retamount, holdpayterm, retpayterm, template_no, ict_flag, num_series, Ales_Flag, supplierAddress, lgt_invoice, trnsfr_bill_no, trnsfr_bill_date, rcti_flag, trnsfr_bill_ou, MAIL_SENT, own_taxregion, allow_auto_cap, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, timestamp, tran_status, tran_date, anchor_date, fb_id, auto_adjust, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_method, pay_to_supp, pay_mode, pay_priority, payment_ou, supp_code, supp_invoice_no, supp_invoice_date, supp_invoice_amount, supp_ou, comments, address1, address2, address3, city, state, country, zip, phone, telex, fax, pager, mobile, mailstop, email, url, contact, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, supp_contallowed, supp_contactperson, supp_bankclearno, account_code, proposal_no, ibe_flag, BillOfLadingNo, BookingNo, MasterBillOfLadingNo, autogen_flag, autogen_comp_id, consistency_stamp, workflow_status, prev_trnamt, LC_number, LC_refid, project_ou, Project_code, afe_number, job_number, costcenter_hdr, inter_compflag, invoice_num_IMS, INVOICE_ID_IMS, VENDOR_ID_IMS, VENDOR_SITE_ID_IMS, ACCTS_PAY_CODE_COMBINATION_ID_IMS, DOC_SEQUENCE_ID_IMS, DOC_SEQUENCE_VALUE_IMS, cash_code, payment_type, workflow_error, Corr_roff, Dervied_roff, hold_amt, holdaccount, retaccount, retamount, holdpayterm, retpayterm, template_no, ict_flag, num_series, Ales_Flag, supplierAddress, lgt_invoice, trnsfr_bill_no, trnsfr_bill_date, rcti_flag, trnsfr_bill_ou, MAIL_SENT, own_taxregion, allow_auto_cap, etlcreateddatetime
    FROM stg.stg_sdin_invoice_hdr;
    
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