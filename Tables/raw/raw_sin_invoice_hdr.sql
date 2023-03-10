CREATE TABLE raw.raw_sin_invoice_hdr (
    raw_id bigint NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    tran_status character varying(100) COLLATE public.nocase,
    invoce_cat character varying(12) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    auto_adjust character varying(4) COLLATE public.nocase,
    auto_match character varying(4) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    pay_term character varying(60) COLLATE public.nocase,
    payterm_version integer,
    elec_pay character varying(4) COLLATE public.nocase,
    pay_method character varying(120) COLLATE public.nocase,
    pay_priority character varying(48) COLLATE public.nocase,
    payment_ou integer,
    pay_mode character varying(100) COLLATE public.nocase,
    supp_code character varying(64) COLLATE public.nocase,
    pay_to_supp character varying(64) COLLATE public.nocase,
    supp_invoice_no character varying(400) COLLATE public.nocase,
    supp_invoice_date timestamp without time zone,
    supp_invoice_amount numeric,
    comments character varying(1024) COLLATE public.nocase,
    proposed_amount numeric,
    tran_amount numeric,
    par_exchange_rate numeric,
    item_amount numeric,
    tax_amount numeric,
    disc_amount numeric,
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
    discount_proportional character varying(4) COLLATE public.nocase,
    comp_bp_code character varying(128) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    lsv_id character varying(120) COLLATE public.nocase,
    comp_acct_in character varying(40) COLLATE public.nocase,
    comp_bp_ref character varying(80) COLLATE public.nocase,
    comp_bp_acc_no character varying(128) COLLATE public.nocase,
    esr_id character varying(120) COLLATE public.nocase,
    partid_digits integer,
    refno_digits integer,
    supp_acct_in character varying(40) COLLATE public.nocase,
    supp_bp_ref character varying(80) COLLATE public.nocase,
    supp_bp_acc_no character varying(128) COLLATE public.nocase,
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
    pre_round_off_amount numeric,
    rounded_off_amount numeric,
    utilized_invtol_per numeric,
    unmatched_per numeric,
    forcemth_tolper_applied numeric,
    batch_id character varying(512) COLLATE public.nocase,
    doc_status character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(48) COLLATE public.nocase,
    total_tcal_amount numeric,
    tcal_exclusive_amt numeric,
    supp_companycode character varying(40) COLLATE public.nocase,
    supp_comppttname character varying(160) COLLATE public.nocase,
    supp_suplbank character varying(128) COLLATE public.nocase,
    supp_suplbankname character varying(240) COLLATE public.nocase,
    supp_swiftid character varying(80) COLLATE public.nocase,
    supp_ibanno character varying(160) COLLATE public.nocase,
    supp_lsvcontractid character varying(120) COLLATE public.nocase,
    supp_contractref character varying(160) COLLATE public.nocase,
    supp_lsvfromdate timestamp without time zone,
    supp_lsvtodate timestamp without time zone,
    supp_contallowed character(8) COLLATE public.nocase,
    supp_contactperson character varying(180) COLLATE public.nocase,
    supp_bankclearno character varying(128) COLLATE public.nocase,
    supp_reftype character varying(160) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    reconcilation_status character varying(100) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    unmatched_amount numeric,
    lcnumber character varying(120) COLLATE public.nocase,
    refid character varying(480) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    prev_trnamt numeric,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    tms_flag character varying(8) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    retaccount character varying(128) COLLATE public.nocase,
    retpayterm character varying(60) COLLATE public.nocase,
    retamount numeric,
    gen_from character varying(100) COLLATE public.nocase,
    hold_amt numeric,
    holdaccount character varying(128) COLLATE public.nocase,
    holdpayterm character varying(60) COLLATE public.nocase,
    adj_jv character varying(1020) COLLATE public.nocase,
    mail_sent character varying(100) DEFAULT 'N'::character varying COLLATE public.nocase,
    own_taxregion character varying(40) COLLATE public.nocase,
    mat_reason_code character varying(40) COLLATE public.nocase,
    autogen_flag character varying(48) COLLATE public.nocase,
    gen_from_mntfrght character varying(160) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    variance_acct character varying(1020) COLLATE public.nocase,
    hold_inv_pay character varying(80) COLLATE public.nocase,
    supplieraddress character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_sin_invoice_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_sin_invoice_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_sin_invoice_hdr
    ADD CONSTRAINT raw_sin_invoice_hdr_pkey PRIMARY KEY (raw_id);