CREATE OR REPLACE PROCEDURE dwh.usp_f_sininvoicehdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_sin_invoice_hdr;

    UPDATE dwh.f_sininvoicehdr t
    SET
        tran_status                    = s.tran_status,
        invoce_cat                     = s.invoce_cat,
        num_type                       = s.num_type,
        tran_date                      = s.tran_date,
        anchor_date                    = s.anchor_date,
        fb_id                          = s.fb_id,
        auto_adjust                    = s.auto_adjust,
        auto_match                     = s.auto_match,
        tran_currency                  = s.tran_currency,
        exchange_rate                  = s.exchange_rate,
        pay_term                       = s.pay_term,
        elec_pay                       = s.elec_pay,
        pay_method                     = s.pay_method,
        pay_priority                   = s.pay_priority,
        payment_ou                     = s.payment_ou,
        pay_mode                       = s.pay_mode,
        supp_code                      = s.supp_code,
        pay_to_supp                    = s.pay_to_supp,
        supp_invoice_no                = s.supp_invoice_no,
        supp_invoice_date              = s.supp_invoice_date,
        supp_invoice_amount            = s.supp_invoice_amount,
        comments                       = s.comments,
        proposed_amount                = s.proposed_amount,
        tran_amount                    = s.tran_amount,
        item_amount                    = s.item_amount,
        tax_amount                     = s.tax_amount,
        disc_amount                    = s.disc_amount,
        base_amount                    = s.base_amount,
        rev_doc_no                     = s.rev_doc_no,
        rev_doc_ou                     = s.rev_doc_ou,
        rev_date                       = s.rev_date,
        ref_doc_no                     = s.ref_doc_no,
        ref_doc_ou                     = s.ref_doc_ou,
        rev_reason_code                = s.rev_reason_code,
        rev_remarks                    = s.rev_remarks,
        disc_comp_basis                = s.disc_comp_basis,
        discount_proportional          = s.discount_proportional,
        vat_applicable                 = s.vat_applicable,
        pre_round_off_amount           = s.pre_round_off_amount,
        rounded_off_amount             = s.rounded_off_amount,
        utilized_invtol_per            = s.utilized_invtol_per,
        unmatched_per                  = s.unmatched_per,
        forcemth_tolper_applied        = s.forcemth_tolper_applied,
        batch_id                       = s.batch_id,
        createdby                      = s.createdby,
        createddate                    = s.createddate,
        modifiedby                     = s.modifiedby,
        modifieddate                   = s.modifieddate,
        tcal_status                    = s.tcal_status,
        total_tcal_amount              = s.total_tcal_amount,
        tcal_exclusive_amt             = s.tcal_exclusive_amt,
        account_code                   = s.account_code,
        reconcilation_status           = s.reconcilation_status,
        unmatched_amount               = s.unmatched_amount,
        workflow_status                = s.workflow_status,
        prev_trnamt                    = s.prev_trnamt,
        MAIL_SENT                      = s.MAIL_SENT,
        own_taxregion                  = s.own_taxregion,
        autogen_flag                   = s.autogen_flag,
        Variance_Acct                  = s.Variance_Acct,
        hold_inv_pay                   = s.hold_inv_pay,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_sin_invoice_hdr s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.timestamp = s.timestamp
    AND t.tms_flag = s.tms_flag
    AND t.gen_from_MntFrght = s.gen_from_MntFrght;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sininvoicehdr
    (
        tran_type, tran_ou, tran_no, timestamp, tran_status, invoce_cat, num_type, tran_date, anchor_date, fb_id, auto_adjust, auto_match, tran_currency, exchange_rate, pay_term, elec_pay, pay_method, pay_priority, payment_ou, pay_mode, supp_code, pay_to_supp, supp_invoice_no, supp_invoice_date, supp_invoice_amount, comments, proposed_amount, tran_amount, item_amount, tax_amount, disc_amount, base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, disc_comp_basis, discount_proportional, vat_applicable, pre_round_off_amount, rounded_off_amount, utilized_invtol_per, unmatched_per, forcemth_tolper_applied, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, account_code, reconcilation_status, unmatched_amount, workflow_status, prev_trnamt, tms_flag, MAIL_SENT, own_taxregion, autogen_flag, gen_from_MntFrght, Variance_Acct, hold_inv_pay, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.timestamp, s.tran_status, s.invoce_cat, s.num_type, s.tran_date, s.anchor_date, s.fb_id, s.auto_adjust, s.auto_match, s.tran_currency, s.exchange_rate, s.pay_term, s.elec_pay, s.pay_method, s.pay_priority, s.payment_ou, s.pay_mode, s.supp_code, s.pay_to_supp, s.supp_invoice_no, s.supp_invoice_date, s.supp_invoice_amount, s.comments, s.proposed_amount, s.tran_amount, s.item_amount, s.tax_amount, s.disc_amount, s.base_amount, s.rev_doc_no, s.rev_doc_ou, s.rev_date, s.ref_doc_no, s.ref_doc_ou, s.rev_reason_code, s.rev_remarks, s.disc_comp_basis, s.discount_proportional, s.vat_applicable, s.pre_round_off_amount, s.rounded_off_amount, s.utilized_invtol_per, s.unmatched_per, s.forcemth_tolper_applied, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.total_tcal_amount, s.tcal_exclusive_amt, s.account_code, s.reconcilation_status, s.unmatched_amount, s.workflow_status, s.prev_trnamt, s.tms_flag, s.MAIL_SENT, s.own_taxregion, s.autogen_flag, s.gen_from_MntFrght, s.Variance_Acct, s.hold_inv_pay, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sin_invoice_hdr s
    LEFT JOIN dwh.f_sininvoicehdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.timestamp = t.timestamp
    AND s.tms_flag = t.tms_flag
    AND s.gen_from_MntFrght = t.gen_from_MntFrght
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_invoice_hdr
    (
        tran_type, tran_ou, tran_no, timestamp, tran_status, invoce_cat, num_type, tran_date, anchor_date, fb_id, auto_adjust, auto_match, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_method, pay_priority, payment_ou, pay_mode, supp_code, pay_to_supp, supp_invoice_no, supp_invoice_date, supp_invoice_amount, comments, proposed_amount, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, utilized_invtol_per, unmatched_per, forcemth_tolper_applied, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, supp_contallowed, supp_contactperson, supp_bankclearno, supp_reftype, account_code, reconcilation_status, consistency_stamp, unmatched_amount, lcnumber, refid, workflow_status, prev_trnamt, project_ou, Project_code, tms_flag, retaccount, retpayterm, retamount, gen_from, hold_amt, holdaccount, holdpayterm, adj_jv, MAIL_SENT, own_taxregion, mat_reason_code, autogen_flag, gen_from_MntFrght, Variance_Acct, hold_inv_pay, supplierAddress, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, timestamp, tran_status, invoce_cat, num_type, tran_date, anchor_date, fb_id, auto_adjust, auto_match, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_method, pay_priority, payment_ou, pay_mode, supp_code, pay_to_supp, supp_invoice_no, supp_invoice_date, supp_invoice_amount, comments, proposed_amount, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, utilized_invtol_per, unmatched_per, forcemth_tolper_applied, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, total_tcal_amount, tcal_exclusive_amt, supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, supp_contallowed, supp_contactperson, supp_bankclearno, supp_reftype, account_code, reconcilation_status, consistency_stamp, unmatched_amount, lcnumber, refid, workflow_status, prev_trnamt, project_ou, Project_code, tms_flag, retaccount, retpayterm, retamount, gen_from, hold_amt, holdaccount, holdpayterm, adj_jv, MAIL_SENT, own_taxregion, mat_reason_code, autogen_flag, gen_from_MntFrght, Variance_Acct, hold_inv_pay, supplierAddress, etlcreateddatetime
    FROM stg.stg_sin_invoice_hdr;
    
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