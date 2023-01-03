-- PROCEDURE: dwh.usp_f_cdcndcnotehdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cdcndcnotehdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cdcndcnotehdr(
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
    FROM stg.stg_cdcn_dcnote_hdr;

    UPDATE dwh.F_cdcndcnotehdr t
    SET
        tran_status                   = s.tran_status,
        note_type                     = s.note_type,
        note_cat                      = s.note_cat,
        num_type                      = s.num_type,
        tran_date                     = s.tran_date,
        anchor_date                   = s.anchor_date,
        fb_id                         = s.fb_id,
        tran_currency                 = s.tran_currency,
        exchange_rate                 = s.exchange_rate,
        pay_term                      = s.pay_term,
        payterm_version               = s.payterm_version,
        elec_pay                      = s.elec_pay,
        pay_method                    = s.pay_method,
        cust_ou                       = s.cust_ou,
        cust_code                     = s.cust_code,
        cust_note_no                  = s.cust_note_no,
        cust_note_date                = s.cust_note_date,
        cust_note_amount              = s.cust_note_amount,
        comments                      = s.comments,
        tran_amount                   = s.tran_amount,
        par_exchange_rate             = s.par_exchange_rate,
        item_amount                   = s.item_amount,
        base_amount                   = s.base_amount,
        par_base_amount               = s.par_base_amount,
        rev_doc_no                    = s.rev_doc_no,
        rev_doc_ou                    = s.rev_doc_ou,
        rev_date                      = s.rev_date,
        ref_doc_no                    = s.ref_doc_no,
        ref_doc_ou                    = s.ref_doc_ou,
        rev_reason_code               = s.rev_reason_code,
        rev_remarks                   = s.rev_remarks,
        hld_reason_code               = s.hld_reason_code,
        auth_date                     = s.auth_date,
        disc_comp_basis               = s.disc_comp_basis,
        discount_proportional         = s.discount_proportional,
        bank_code                     = s.bank_code,
        lsv_id                        = s.lsv_id,
        comp_acct_in                  = s.comp_acct_in,
        comp_bp_ref                   = s.comp_bp_ref,
        comp_bp_acc_no                = s.comp_bp_acc_no,
        esr_id                        = s.esr_id,
        cust_bank_acct                = s.cust_bank_acct,
        cust_bank_id                  = s.cust_bank_id,
        vat_applicable                = s.vat_applicable,
        vat_exchange_rate             = s.vat_exchange_rate,
        vat_charge                    = s.vat_charge,
        non_vat_charge                = s.non_vat_charge,
        doc_level_disc                = s.doc_level_disc,
        vat_incl                      = s.vat_incl,
        retain_init_distbn            = s.retain_init_distbn,
        cap_non_ded_charge            = s.cap_non_ded_charge,
        average_vat_rate              = s.average_vat_rate,
        vat_excl_amount               = s.vat_excl_amount,
        vat_amount                    = s.vat_amount,
        vat_incl_amount               = s.vat_incl_amount,
        pre_round_off_amount          = s.pre_round_off_amount,
        rounded_off_amount            = s.rounded_off_amount,
        batch_id                      = s.batch_id,
        doc_status                    = s.doc_status,
        createdby                     = s.createdby,
        createddate                   = s.createddate,
        modifiedby                    = s.modifiedby,
        modifieddate                  = s.modifieddate,
        tcal_status                   = s.tcal_status,
        tcal_exclusive_amount         = s.tcal_exclusive_amount,
        tcal_total_amount             = s.tcal_total_amount,
        custbank_ptt_reference        = s.custbank_ptt_reference,
        custbank_ptt_accno            = s.custbank_ptt_accno,
        compbank_ptt_code             = s.compbank_ptt_code,
        cont_participation_id         = s.cont_participation_id,
        applied_flag                  = s.applied_flag,
        cust_contractref              = s.cust_contractref,
        cust_bp_ref                   = s.cust_bp_ref,
        autogen_flag                  = s.autogen_flag,
        draft_flag                    = s.draft_flag,
        reasoncode                    = s.reasoncode,
        ibe_flag                      = s.ibe_flag,
        consistency_stamp             = s.consistency_stamp,
        cm_doc_no                     = s.cm_doc_no,
        workflow_status               = s.workflow_status,
        project_ou                    = s.project_ou,
        Project_code                  = s.Project_code,
        afe_number                    = s.afe_number,
        job_number                    = s.job_number,
        costcenter_hdr                = s.costcenter_hdr,
        dest_comp_code                = s.dest_comp_code,
        dest_Ou                       = s.dest_Ou,
        dest_FB                       = s.dest_FB,
        dest_sup_code                 = s.dest_sup_code,
        dest_supacct_code             = s.dest_supacct_code,
        PayProc_Point                 = s.PayProc_Point,
        Payment_Priority              = s.Payment_Priority,
        Auto_Adjust                   = s.Auto_Adjust,
        inter_compflag                = s.inter_compflag,
        supp_anchor_date              = s.supp_anchor_date,
        supp_comments                 = s.supp_comments,
        ims_flag                      = s.ims_flag,
        scheme_code                   = s.scheme_code,
        srdoctype                     = s.srdoctype,
        pdc_flag                      = s.pdc_flag,
        own_taxregion                 = s.own_taxregion,
        customerAddress               = s.customerAddress,
        otc_flag                      = s.otc_flag,
        gen_from                      = s.gen_from,
        timestamp                     = s.timestamp,
        ict_flag                      = s.ict_flag,
        ifb_flag                      = s.ifb_flag,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_cdcn_dcnote_hdr s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no ;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdcndcnotehdr
    (
        tran_type, tran_ou, tran_no, timestamp, tran_status, note_type, note_cat, num_type, tran_date, anchor_date, fb_id, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_method, cust_ou, cust_code, cust_note_no, cust_note_date, cust_note_amount, comments, tran_amount, par_exchange_rate, item_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_reason_code, auth_date, disc_comp_basis, discount_proportional, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, cust_bank_acct, cust_bank_id, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amount, tcal_total_amount, custbank_ptt_reference, custbank_ptt_accno, compbank_ptt_code, cont_participation_id, applied_flag, cust_contractref, cust_bp_ref, autogen_flag, draft_flag, reasoncode, ibe_flag, consistency_stamp, cm_doc_no, workflow_status, project_ou, Project_code, afe_number, job_number, costcenter_hdr, dest_comp_code, dest_Ou, dest_FB, dest_sup_code, dest_supacct_code, PayProc_Point, Payment_Priority, Auto_Adjust, inter_compflag, supp_anchor_date, supp_comments, ims_flag, scheme_code, ict_flag, srdoctype, pdc_flag, own_taxregion, customerAddress, otc_flag, gen_from, ifb_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.timestamp, s.tran_status, s.note_type, s.note_cat, s.num_type, s.tran_date, s.anchor_date, s.fb_id, s.tran_currency, s.exchange_rate, s.pay_term, s.payterm_version, s.elec_pay, s.pay_method, s.cust_ou, s.cust_code, s.cust_note_no, s.cust_note_date, s.cust_note_amount, s.comments, s.tran_amount, s.par_exchange_rate, s.item_amount, s.base_amount, s.par_base_amount, s.rev_doc_no, s.rev_doc_ou, s.rev_date, s.ref_doc_no, s.ref_doc_ou, s.rev_reason_code, s.rev_remarks, s.hld_reason_code, s.auth_date, s.disc_comp_basis, s.discount_proportional, s.bank_code, s.lsv_id, s.comp_acct_in, s.comp_bp_ref, s.comp_bp_acc_no, s.esr_id, s.cust_bank_acct, s.cust_bank_id, s.vat_applicable, s.vat_exchange_rate, s.vat_charge, s.non_vat_charge, s.doc_level_disc, s.vat_incl, s.retain_init_distbn, s.cap_non_ded_charge, s.average_vat_rate, s.vat_excl_amount, s.vat_amount, s.vat_incl_amount, s.pre_round_off_amount, s.rounded_off_amount, s.batch_id, s.doc_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.tcal_status, s.tcal_exclusive_amount, s.tcal_total_amount, s.custbank_ptt_reference, s.custbank_ptt_accno, s.compbank_ptt_code, s.cont_participation_id, s.applied_flag, s.cust_contractref, s.cust_bp_ref, s.autogen_flag, s.draft_flag, s.reasoncode, s.ibe_flag, s.consistency_stamp, s.cm_doc_no, s.workflow_status, s.project_ou, s.Project_code, s.afe_number, s.job_number, s.costcenter_hdr, s.dest_comp_code, s.dest_Ou, s.dest_FB, s.dest_sup_code, s.dest_supacct_code, s.PayProc_Point, s.Payment_Priority, s.Auto_Adjust, s.inter_compflag, s.supp_anchor_date, s.supp_comments, s.ims_flag, s.scheme_code, s.ict_flag, s.srdoctype, s.pdc_flag, s.own_taxregion, s.customerAddress, s.otc_flag, s.gen_from, s.ifb_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdcn_dcnote_hdr s
    LEFT JOIN dwh.F_cdcndcnotehdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdcn_dcnote_hdr
    (
        tran_type, tran_ou, tran_no, timestamp, tran_status, note_type, note_cat, num_type, tran_date, anchor_date, fb_id, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_mode, pay_method, cust_ou, cust_code, cust_note_no, cust_note_date, cust_note_amount, comments, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, cust_bank_acct, cust_bank_id, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amount, tcal_total_amount, custbank_ptt_reference, custbank_ptt_accno, compbank_ptt_code, cont_participation_id, applied_flag, cust_contractref, cust_bp_ref, autogen_flag, draft_flag, reasoncode, ibe_flag, consistency_stamp, cm_doc_no, workflow_status, project_ou, Project_code, afe_number, job_number, costcenter_hdr, dest_comp_code, dest_Ou, dest_FB, dest_sup_code, dest_supacct_code, PayProc_Point, Payment_Priority, Auto_Adjust, inter_compflag, supp_anchor_date, supp_comments, ims_flag, scheme_code, ict_flag, srdoctype, pdc_flag, own_taxregion, customerAddress, otc_flag, gen_from, ifb_flag, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, timestamp, tran_status, note_type, note_cat, num_type, tran_date, anchor_date, fb_id, tran_currency, exchange_rate, pay_term, payterm_version, elec_pay, pay_mode, pay_method, cust_ou, cust_code, cust_note_no, cust_note_date, cust_note_amount, comments, tran_amount, par_exchange_rate, item_amount, tax_amount, disc_amount, base_amount, par_base_amount, rev_doc_no, rev_doc_ou, rev_date, ref_doc_no, ref_doc_ou, rev_reason_code, rev_remarks, hld_date, hld_reason_code, hld_remarks, auth_date, posting_date, posting_status, disc_comp_basis, discount_proportional, comp_bp_code, bank_code, lsv_id, comp_acct_in, comp_bp_ref, comp_bp_acc_no, esr_id, cust_bank_acct, cust_bank_id, vat_applicable, vat_exchange_rate, vat_charge, non_vat_charge, doc_level_disc, vat_incl, retain_init_distbn, cap_non_ded_charge, average_vat_rate, vat_excl_amount, vat_amount, vat_incl_amount, pre_round_off_amount, rounded_off_amount, batch_id, doc_status, createdby, createddate, modifiedby, modifieddate, tcal_status, tcal_exclusive_amount, tcal_total_amount, custbank_ptt_reference, custbank_ptt_accno, compbank_ptt_code, cont_participation_id, applied_flag, cust_contractref, cust_bp_ref, autogen_flag, draft_flag, reasoncode, ibe_flag, consistency_stamp, cm_doc_no, workflow_status, project_ou, Project_code, afe_number, job_number, costcenter_hdr, dest_comp_code, dest_Ou, dest_FB, dest_sup_code, dest_supacct_code, PayProc_Point, Payment_Priority, Auto_Adjust, inter_compflag, supp_anchor_date, supp_comments, ims_flag, scheme_code, ict_flag, srdoctype, pdc_flag, own_taxregion, customerAddress, otc_flag, gen_from, ifb_flag, etlcreateddatetime
    FROM stg.stg_cdcn_dcnote_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_cdcndcnotehdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
