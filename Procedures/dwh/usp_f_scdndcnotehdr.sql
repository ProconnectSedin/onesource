CREATE OR REPLACE PROCEDURE dwh.usp_f_scdndcnotehdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_scdn_dcnote_hdr;

    UPDATE dwh.F_scdndcnotehdr t
    SET
        s_timestamp                  = s.timestamp,
        supp_code                    = s.supp_code,
        tran_status                  = s.tran_status,
        note_type                    = s.note_type,
        note_cat                     = s.note_cat,
        num_type                     = s.num_type,
        tran_date                    = s.tran_date,
        anchor_date                  = s.anchor_date,
        fb_id                        = s.fb_id,
        tran_currency                = s.tran_currency,
        exchange_rate                = s.exchange_rate,
        pay_term                     = s.pay_term,
        payterm_version              = s.payterm_version,
        elec_pay                     = s.elec_pay,
        pay_mode                     = s.pay_mode,
        pay_method                   = s.pay_method,
        pay_priority                 = s.pay_priority,
        payment_ou                   = s.payment_ou,
        supp_ou                      = s.supp_ou,
        supp_note_no                 = s.supp_note_no,
        supp_note_date               = s.supp_note_date,
        supp_note_amount             = s.supp_note_amount,
        s_comments                   = s.comments,
        tran_amount                  = s.tran_amount,
        par_exchange_rate            = s.par_exchange_rate,
        base_amount                  = s.base_amount,
        par_base_amount              = s.par_base_amount,
        rev_doc_no                   = s.rev_doc_no,
        rev_doc_ou                   = s.rev_doc_ou,
        rev_date                     = s.rev_date,
        ref_doc_no                   = s.ref_doc_no,
        ref_doc_ou                   = s.ref_doc_ou,
        rev_reason_code              = s.rev_reason_code,
        rev_remarks                  = s.rev_remarks,
        auth_date                    = s.auth_date,
        disc_comp_basis              = s.disc_comp_basis,
        discount_proportional        = s.discount_proportional,
        pre_round_off_amount         = s.pre_round_off_amount,
        rounded_off_amount           = s.rounded_off_amount,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        batch_id                     = s.batch_id,
        tcal_status                  = s.tcal_status,
        tcal_exclusive_amount        = s.tcal_exclusive_amount,
        tcal_total_amount            = s.tcal_total_amount,
        autogen_flag                 = s.autogen_flag,
        account_code                 = s.account_code,
        auto_adjust                  = s.auto_adjust,
        MAIL_SENT                    = s.MAIL_SENT,
        SupplierAddress              = s.SupplierAddress,
        ifb_flag                     = s.ifb_flag,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_scdn_dcnote_hdr s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.ict_flag = s.ict_flag
    AND t.ifb_flag = s.ifb_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_scdndcnotehdr
    (
        tran_type, tran_ou, tran_no, s_timestamp, supp_code, 
		tran_status, note_type, note_cat, num_type, tran_date, 
		anchor_date, fb_id, tran_currency, exchange_rate, pay_term, 
		payterm_version, elec_pay, pay_mode, pay_method, pay_priority, 
		payment_ou, supp_ou, supp_note_no, supp_note_date, supp_note_amount, 
		s_comments, tran_amount, par_exchange_rate, base_amount, par_base_amount, 
		rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, 
		rev_reason_code, rev_remarks, auth_date, disc_comp_basis, discount_proportional, 
		pre_round_off_amount, rounded_off_amount, createdby, createddate, modifiedby, 
		modifieddate, batch_id, tcal_status, tcal_exclusive_amount, tcal_total_amount, 
		autogen_flag, account_code, ibe_flag, auto_adjust, ict_flag, 
		MAIL_SENT, SupplierAddress, ifb_flag, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.timestamp, s.supp_code, 
		s.tran_status, s.note_type, s.note_cat, s.num_type, s.tran_date,
		s.anchor_date, s.fb_id, s.tran_currency, s.exchange_rate, s.pay_term, 
		s.payterm_version, s.elec_pay, s.pay_mode, s.pay_method, s.pay_priority, 
		s.payment_ou, s.supp_ou, s.supp_note_no, s.supp_note_date, s.supp_note_amount, 
		s.comments, s.tran_amount, s.par_exchange_rate, s.base_amount, s.par_base_amount, 
		s.rev_doc_no, s.rev_doc_ou, s.rev_date, s.ref_doc_no, s.ref_doc_ou, 
		s.rev_reason_code, s.rev_remarks, s.auth_date, s.disc_comp_basis, s.discount_proportional, 
		s.pre_round_off_amount, s.rounded_off_amount, s.createdby, s.createddate, s.modifiedby, 
		s.modifieddate, s.batch_id, s.tcal_status, s.tcal_exclusive_amount, s.tcal_total_amount, 
		s.autogen_flag, s.account_code, s.ibe_flag, s.auto_adjust, s.ict_flag, 
		s.MAIL_SENT, s.SupplierAddress, s.ifb_flag, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_scdn_dcnote_hdr s
    LEFT JOIN dwh.F_scdndcnotehdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.ict_flag = t.ict_flag
    AND s.ifb_flag = t.ifb_flag
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_scdn_dcnote_hdr
    (
        tran_type, tran_ou, tran_no, timestamp, supp_code, 
		tran_status, note_type, note_cat, num_type, tran_date, 
		anchor_date, fb_id, tran_currency, exchange_rate, pay_term, 
		payterm_version, elec_pay, pay_mode, pay_method, pay_priority, 
		payment_ou, supp_ou, supp_note_no, supp_note_date, supp_note_amount, 
		comments, tran_amount, par_exchange_rate, item_amount, tax_amount, 
		disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, 
		rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, 
		hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, 
		posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, 
		lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, 
		partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, 
		vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, 
		vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, 
		vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, doc_status, 
		createdby, createddate, modifiedby, modifieddate, batch_id, 
		usage_id, tcal_status, tcal_exclusive_amount, tcal_total_amount, elec_flag, 
		supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, 
		supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, 
		supp_contallowed, supp_contactperson, supp_bankclearno, suppbank_ptt_reference, autogen_flag, 
		account_code, ibe_flag, consistency_stamp, template_no, workflow_status, 
		project_ou, Project_code, afe_number, job_number, costcenter_hdr, 
		auto_adjust, ict_flag, ref_type, rev_flag, pdc_flag, 
		srdoctype, MAIL_SENT, own_taxregion, SupplierAddress, gen_from, 
		ifb_flag, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, timestamp, supp_code, 
		tran_status, note_type, note_cat, num_type, tran_date, 
		anchor_date, fb_id, tran_currency, exchange_rate, pay_term, 
		payterm_version, elec_pay, pay_mode, pay_method, pay_priority, 
		payment_ou, supp_ou, supp_note_no, supp_note_date, supp_note_amount, 
		comments, tran_amount, par_exchange_rate, item_amount, tax_amount, 
		disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, 
		rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, 
		hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, 
		posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, 
		lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, 
		partid_digits, refno_digits, supp_acct_in, supp_bp_ref, supp_bp_acc_no, 
		vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, 
		vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, 
		vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, doc_status, 
		createdby, createddate, modifiedby, modifieddate, batch_id, 
		usage_id, tcal_status, tcal_exclusive_amount, tcal_total_amount, elec_flag, 
		supp_companycode, supp_comppttname, supp_suplbank, supp_suplbankname, supp_swiftid, 
		supp_ibanno, supp_lsvcontractid, supp_contractref, supp_lsvfromdate, supp_lsvtodate, 
		supp_contallowed, supp_contactperson, supp_bankclearno, suppbank_ptt_reference, autogen_flag, 
		account_code, ibe_flag, consistency_stamp, template_no, workflow_status, 
		project_ou, Project_code, afe_number, job_number, costcenter_hdr, 
		auto_adjust, ict_flag, ref_type, rev_flag, pdc_flag, 
		srdoctype, MAIL_SENT, own_taxregion, SupplierAddress, gen_from, 
		ifb_flag, etlcreateddatetime
	FROM stg.stg_scdn_dcnote_hdr;
    
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