CREATE TABLE stg.stg_cdi_invoice_hdr (
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    ctimestamp integer NOT NULL,
    tran_status character varying(12) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    bill_to_cust character varying(72) COLLATE public.nocase,
    auto_adjust character varying(4) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    pay_term character varying(60) COLLATE public.nocase,
    payterm_version integer,
    receipt_method character varying(120) COLLATE public.nocase,
    comments character varying(1024) COLLATE public.nocase,
    tran_amount numeric,
    receipt_type character varying(4) COLLATE public.nocase,
    sales_channel character varying(24) COLLATE public.nocase,
    sales_type character varying(20) COLLATE public.nocase,
    ship_to_cust character varying(72) COLLATE public.nocase,
    ship_to_id character varying(24) COLLATE public.nocase,
    price_list_code character varying(100) COLLATE public.nocase,
    sales_person character varying(24) COLLATE public.nocase,
    par_exchange_rate numeric,
    item_amount numeric,
    tax_amount numeric,
    disc_amount numeric,
    gross_frt_amount numeric,
    net_frt_amount numeric,
    base_amount numeric,
    par_base_amount numeric,
    rev_doc_no character varying(72) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(40) COLLATE public.nocase,
    rev_remarks character varying(400) COLLATE public.nocase,
    hld_date timestamp without time zone,
    hld_reason_code character varying(40) COLLATE public.nocase,
    hld_remarks character varying(400) COLLATE public.nocase,
    auth_date timestamp without time zone,
    posting_date timestamp without time zone,
    posting_status character varying(12) COLLATE public.nocase,
    disc_comp_basis character varying(4) COLLATE public.nocase,
    disc_proportional character varying(4) COLLATE public.nocase,
    comp_bp_code character varying(128) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    lsv_id character varying(120) COLLATE public.nocase,
    comp_acct_in character varying(40) COLLATE public.nocase,
    comp_bp_ref character varying(80) COLLATE public.nocase,
    comp_bp_acc_no character varying(128) COLLATE public.nocase,
    esr_id character varying(120) COLLATE public.nocase,
    cust_bank_acct character varying(128) COLLATE public.nocase,
    cust_bank_id character varying(128) COLLATE public.nocase,
    vat_applicable character varying(4) COLLATE public.nocase,
    vat_exchange_rate numeric,
    vat_charge numeric,
    non_vat_charge numeric,
    doc_level_disc numeric,
    vat_incl character varying(4) COLLATE public.nocase,
    retain_init_distbn character varying(4) COLLATE public.nocase,
    cap_non_ded_charge character varying(4) COLLATE public.nocase,
    average_vat_rate numeric,
    vat_excl_amount numeric,
    vat_amount numeric,
    vat_incl_amount numeric,
    frt_cost_center character varying(40) COLLATE public.nocase,
    frt_analysis_code character varying(20) COLLATE public.nocase,
    frt_subanalysis_code character varying(20) COLLATE public.nocase,
    pre_round_off_amount numeric,
    rounded_off_amount numeric,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    doc_status character varying(48) COLLATE public.nocase,
    cust_companycode character varying(40) COLLATE public.nocase,
    cust_comppttname character varying(160) COLLATE public.nocase,
    cust_suplbank character varying(128) COLLATE public.nocase,
    cust_suplbankname character varying(240) COLLATE public.nocase,
    cust_swiftid character varying(80) COLLATE public.nocase,
    cust_ibanno character varying(160) COLLATE public.nocase,
    cust_lsvcontractid character varying(120) COLLATE public.nocase,
    cust_contractref character varying(160) COLLATE public.nocase,
    cust_lsvfromdate timestamp without time zone,
    cust_lsvtodate timestamp without time zone,
    cust_contallowed character varying(120) COLLATE public.nocase,
    cust_contactperson character varying(180) COLLATE public.nocase,
    cust_bankclearno character varying(128) COLLATE public.nocase,
    tcal_status character varying(48) COLLATE public.nocase,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    bill_toid character varying(24) COLLATE public.nocase,
    draft_flag character varying(48) COLLATE public.nocase,
    cust_account_code character varying(128) COLLATE public.nocase,
    cdi_pick_notes character varying(1020) COLLATE public.nocase,
    cdi_pack_notes character varying(1020) COLLATE public.nocase,
    cdi_shipment_notes character varying(1020) COLLATE public.nocase,
    cdi_invoice_notes character varying(1020) COLLATE public.nocase,
    cdi_order_priority integer,
    cdi_sales_team character varying(72) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    bank_cash_code character varying(128) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    autogen_flag character varying(48) COLLATE public.nocase,
    autogen_comp_id character varying(64) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    prev_trnamt numeric,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    costcenter_hdr character varying(40) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    ict_flag character varying(48) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    template_no character varying(72) COLLATE public.nocase,
    num_series character varying(160) COLLATE public.nocase,
    retaccount character varying(128) COLLATE public.nocase,
    retpayterm character varying(60) COLLATE public.nocase,
    retamount numeric,
    holdaccount character varying(128) COLLATE public.nocase,
    holdpayterm character varying(60) COLLATE public.nocase,
    holdamt numeric,
    lgt_invoice character varying(4) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    trnsfr_bill_no character varying(72) COLLATE public.nocase,
    trnsfr_bill_date timestamp without time zone,
    trnsfr_bill_ou integer,
    mail_sent character varying(100) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    own_taxregion character varying(40) COLLATE public.nocase,
    ot_cust_name character varying(160) COLLATE public.nocase,
    otc_flag character varying(48) COLLATE public.nocase,
    adj_tran_type character varying(40) COLLATE public.nocase,
    rpt_ou integer,
    cbadj_ou integer,
    auto_adjust_chk character varying(12) COLLATE public.nocase,
    receipt_mode character varying(72) COLLATE public.nocase,
    receipt_currency character varying(20) COLLATE public.nocase,
    receipt_exchangerate numeric,
    receipt_instr_no character varying(120) COLLATE public.nocase,
    receipt_instr_date timestamp without time zone,
    receipt_instr_amount numeric,
    receipt_micr_no character varying(72) COLLATE public.nocase,
    receipt_bankcode character varying(128) COLLATE public.nocase,
    receipt_instr_type character varying(100) COLLATE public.nocase,
    comp_ref_no character varying(120) COLLATE public.nocase,
    rpt_notype_no character varying(40) COLLATE public.nocase,
    receipt_no character varying(72) COLLATE public.nocase,
    rec_tran_type character varying(40) COLLATE public.nocase,
    cbadj_voucher_no character varying(72) COLLATE public.nocase,
    crdoc_no character varying(72) COLLATE public.nocase,
    diver_status character varying(100) COLLATE public.nocase,
    freigtmethod character varying(120) COLLATE public.nocase,
    invoicetype character varying(120) COLLATE public.nocase,
    cdi_spemp_code character varying(100) COLLATE public.nocase,
    authorization_date timestamp without time zone,
    tms_receipt_date character varying(100) COLLATE public.nocase,
    tms_invoice character varying(1020) COLLATE public.nocase,
    tms_receipt_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_cdi_invoice_hdr
    ADD CONSTRAINT pk__cdi_invoice_hdr__3e9958de PRIMARY KEY (tran_type, tran_ou, tran_no);