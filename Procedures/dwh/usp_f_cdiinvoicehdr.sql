CREATE PROCEDURE dwh.usp_f_cdiinvoicehdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_cdi_invoice_hdr;

    UPDATE dwh.F_cdiinvoicehdr t
    SET
        fb_key                    	= -1,
        curr_key                    = COALESCE(cr.curr_key,-1),		
        tran_status                 = s.tran_status,
        tran_date                   = s.tran_date,
        anchor_date                 = s.anchor_date,
        fb_id                       = s.fb_id,
        bill_to_cust                = s.bill_to_cust,
        auto_adjust                 = s.auto_adjust,
        tran_currency               = s.tran_currency,
        exchange_rate               = s.exchange_rate,
        pay_term                    = s.pay_term,
        payterm_version             = s.payterm_version,
        receipt_method              = s.receipt_method,
        comments                    = s.comments,
        tran_amount                 = s.tran_amount,
        receipt_type                = s.receipt_type,
        sales_channel               = s.sales_channel,
        sales_type                  = s.sales_type,
        ship_to_cust                = s.ship_to_cust,
        ship_to_id                  = s.ship_to_id,
        item_amount                 = s.item_amount,
        gross_frt_amount            = s.gross_frt_amount,
        net_frt_amount              = s.net_frt_amount,
        base_amount                 = s.base_amount,
        rev_doc_no                  = s.rev_doc_no,
        rev_doc_ou                  = s.rev_doc_ou,
        rev_date                    = s.rev_date,
        ref_doc_no                  = s.ref_doc_no,
        ref_doc_ou                  = s.ref_doc_ou,
        rev_reason_code             = s.rev_reason_code,
        rev_remarks                 = s.rev_remarks,
        disc_comp_basis             = s.disc_comp_basis,
        disc_proportional           = s.disc_proportional,
        vat_applicable              = s.vat_applicable,
        pre_round_off_amount        = s.pre_round_off_amount,
        rounded_off_amount          = s.rounded_off_amount,
        batch_id                    = s.batch_id,
        createdby                   = s.createdby,
        createddate                 = s.createddate,
        modifiedby                  = s.modifiedby,
        modifieddate                = s.modifieddate,
        tcal_status                 = s.tcal_status,
        tcal_exclusive_amt          = s.tcal_exclusive_amt,
        total_tcal_amount           = s.total_tcal_amount,
        bill_toid                   = s.bill_toid,
        draft_flag                  = s.draft_flag,
        cust_account_code           = s.cust_account_code,
        ibe_flag                    = s.ibe_flag,
        autogen_flag                = s.autogen_flag,
        autogen_comp_id             = s.autogen_comp_id,
        prev_trnamt                 = s.prev_trnamt,
        num_series                  = s.num_series,
        retamount                   = s.retamount,
        holdamt                     = s.holdamt,
        trnsfr_bill_no              = s.trnsfr_bill_no,
        trnsfr_bill_date            = s.trnsfr_bill_date,
        trnsfr_bill_ou              = s.trnsfr_bill_ou,
        own_taxregion               = s.own_taxregion,
        OT_cust_name                = s.OT_cust_name,
        otc_flag                    = s.otc_flag,
        rpt_ou                      = s.rpt_ou,
        cbadj_ou                    = s.cbadj_ou,
        auto_adjust_chk             = s.auto_adjust_chk,
        receipt_currency            = s.receipt_currency,
        receipt_exchangerate        = s.receipt_exchangerate,
        receipt_instr_type          = s.receipt_instr_type,
        rpt_notype_no               = s.rpt_notype_no,
        rec_tran_type               = s.rec_tran_type,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_cdi_invoice_hdr s
/*	LEFT JOIN dwh.d_financebook f
		ON  s.fb_id					= f.fb_id
		AND s.tran_ou				= f.resou_id*/
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency			= cr.iso_curr_code	
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.ctimestamp = s.ctimestamp
    AND t.ict_flag = s.ict_flag
    AND t.lgt_invoice = s.lgt_invoice
    AND t.MAIL_SENT = s.MAIL_SENT;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdiinvoicehdr
    (
        fb_key,curr_key,tran_type, tran_ou, tran_no, ctimestamp, tran_status, tran_date, anchor_date, fb_id, bill_to_cust, auto_adjust, tran_currency, exchange_rate, pay_term, payterm_version, receipt_method, comments, tran_amount, receipt_type, sales_channel, sales_type, ship_to_cust, ship_to_id, item_amount, gross_frt_amount, net_frt_amount, base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, disc_comp_basis, disc_proportional, vat_applicable, pre_round_off_amount, rounded_off_amount, batch_id, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amt, total_tcal_amount, bill_toid, draft_flag, cust_account_code, ibe_flag, autogen_flag, autogen_comp_id, prev_trnamt, ict_flag, num_series, retamount, holdamt, lgt_invoice, trnsfr_bill_no, trnsfr_bill_date, trnsfr_bill_ou, MAIL_SENT, own_taxregion, OT_cust_name, otc_flag, rpt_ou, cbadj_ou, auto_adjust_chk, receipt_currency, receipt_exchangerate, receipt_instr_type, rpt_notype_no, rec_tran_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        -1,COALESCE(cr.curr_key,-1),s.tran_type, s.tran_ou, s.tran_no, s.ctimestamp, s.tran_status, s.tran_date, s.anchor_date, s.fb_id, s.bill_to_cust, s.auto_adjust, s.tran_currency, s.exchange_rate, s.pay_term, s.payterm_version, s.receipt_method, s.comments, s.tran_amount, s.receipt_type, s.sales_channel, s.sales_type, s.ship_to_cust, s.ship_to_id, s.item_amount, s.gross_frt_amount, s.net_frt_amount, s.base_amount, s.rev_doc_no, s.rev_doc_ou, s.rev_date, s.ref_doc_no, s.ref_doc_ou, s.rev_reason_code, s.rev_remarks, s.disc_comp_basis, s.disc_proportional, s.vat_applicable, s.pre_round_off_amount, s.rounded_off_amount, s.batch_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.tcal_exclusive_amt, s.total_tcal_amount, s.bill_toid, s.draft_flag, s.cust_account_code, s.ibe_flag, s.autogen_flag, s.autogen_comp_id, s.prev_trnamt, s.ict_flag, s.num_series, s.retamount, s.holdamt, s.lgt_invoice, s.trnsfr_bill_no, s.trnsfr_bill_date, s.trnsfr_bill_ou, s.MAIL_SENT, s.own_taxregion, s.OT_cust_name, s.otc_flag, s.rpt_ou, s.cbadj_ou, s.auto_adjust_chk, s.receipt_currency, s.receipt_exchangerate, s.receipt_instr_type, s.rpt_notype_no, s.rec_tran_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdi_invoice_hdr s
	/*LEFT JOIN dwh.d_financebook f
		ON  s.fb_id					= f.fb_id
		AND s.tran_ou				= f.resou_id*/
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency			= cr.iso_curr_code		
    LEFT JOIN dwh.F_cdiinvoicehdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.ctimestamp = t.ctimestamp
    AND s.ict_flag = t.ict_flag
    AND s.lgt_invoice = t.lgt_invoice
    AND s.MAIL_SENT = t.MAIL_SENT
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdi_invoice_hdr
    (
        tran_type, tran_ou, tran_no, ctimestamp, tran_status, tran_date, anchor_date, fb_id, bill_to_cust, auto_adjust, tran_currency, exchange_rate, pay_term, payterm_version, receipt_method, comments, tran_amount, receipt_type, sales_channel, sales_type, ship_to_cust, ship_to_id, price_list_code, sales_person, par_exchange_rate, item_amount, tax_amount, disc_amount, gross_frt_amount, net_frt_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, disc_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, cust_bank_acct, cust_bank_id, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, frt_cost_center, frt_analysis_code, frt_subanalysis_code, pre_round_off_amount, rounded_off_amount, batch_id, createdby, createddate, modifiedby, modifieddate, doc_status, cust_companycode, cust_comppttname, cust_suplbank, cust_suplbankname, cust_swiftid, cust_ibanno, cust_lsvcontractid, cust_contractref, cust_lsvfromdate, cust_lsvtodate, cust_contallowed, cust_contactperson, cust_bankclearno, tcal_status, tcal_exclusive_amt, total_tcal_amount, bill_toid, draft_flag, cust_account_code, cdi_pick_notes, cdi_pack_notes, cdi_shipment_notes, cdi_invoice_notes, cdi_order_priority, cdi_sales_team, ibe_flag, bank_cash_code, BillOfLadingNo, BookingNo, MasterBillOfLadingNo, autogen_flag, autogen_comp_id, consistency_stamp, workflow_status, prev_trnamt, afe_number, job_number, costcenter_hdr, project_ou, Project_code, ict_flag, template_no, num_series, retaccount, retpayterm, retamount, holdaccount, holdpayterm, holdamt, lgt_invoice, trnsfr_bill_no, trnsfr_bill_date, trnsfr_bill_ou, MAIL_SENT, own_taxregion, OT_cust_name, otc_flag, adj_tran_type, rpt_ou, cbadj_ou, auto_adjust_chk, receipt_mode, receipt_currency, receipt_exchangerate, receipt_instr_no, receipt_instr_date, receipt_instr_amount, receipt_micr_no, receipt_bankcode, receipt_instr_type, comp_ref_no, rpt_notype_no, receipt_no, rec_tran_type, cbadj_voucher_no, crdoc_no, diver_status, freigtmethod, invoicetype, cdi_spemp_code, authorization_Date, tms_receipt_date, TMS_invoice, TMS_receipt_no, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, ctimestamp, tran_status, tran_date, anchor_date, fb_id, bill_to_cust, auto_adjust, tran_currency, exchange_rate, pay_term, payterm_version, receipt_method, comments, tran_amount, receipt_type, sales_channel, sales_type, ship_to_cust, ship_to_id, price_list_code, sales_person, par_exchange_rate, item_amount, tax_amount, disc_amount, gross_frt_amount, net_frt_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, disc_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, cust_bank_acct, cust_bank_id, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, frt_cost_center, frt_analysis_code, frt_subanalysis_code, pre_round_off_amount, rounded_off_amount, batch_id, createdby, createddate, modifiedby, modifieddate, doc_status, cust_companycode, cust_comppttname, cust_suplbank, cust_suplbankname, cust_swiftid, cust_ibanno, cust_lsvcontractid, cust_contractref, cust_lsvfromdate, cust_lsvtodate, cust_contallowed, cust_contactperson, cust_bankclearno, tcal_status, tcal_exclusive_amt, total_tcal_amount, bill_toid, draft_flag, cust_account_code, cdi_pick_notes, cdi_pack_notes, cdi_shipment_notes, cdi_invoice_notes, cdi_order_priority, cdi_sales_team, ibe_flag, bank_cash_code, BillOfLadingNo, BookingNo, MasterBillOfLadingNo, autogen_flag, autogen_comp_id, consistency_stamp, workflow_status, prev_trnamt, afe_number, job_number, costcenter_hdr, project_ou, Project_code, ict_flag, template_no, num_series, retaccount, retpayterm, retamount, holdaccount, holdpayterm, holdamt, lgt_invoice, trnsfr_bill_no, trnsfr_bill_date, trnsfr_bill_ou, MAIL_SENT, own_taxregion, OT_cust_name, otc_flag, adj_tran_type, rpt_ou, cbadj_ou, auto_adjust_chk, receipt_mode, receipt_currency, receipt_exchangerate, receipt_instr_no, receipt_instr_date, receipt_instr_amount, receipt_micr_no, receipt_bankcode, receipt_instr_type, comp_ref_no, rpt_notype_no, receipt_no, rec_tran_type, cbadj_voucher_no, crdoc_no, diver_status, freigtmethod, invoicetype, cdi_spemp_code, authorization_Date, tms_receipt_date, TMS_invoice, TMS_receipt_no, etlcreateddatetime
    FROM stg.stg_cdi_invoice_hdr;
    
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