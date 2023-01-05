-- Table: dwh.f_cdcndcnotehdr

-- DROP TABLE IF EXISTS dwh.f_cdcndcnotehdr;

CREATE TABLE IF NOT EXISTS dwh.f_cdcndcnotehdr
(
    cdcndc_note_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    tran_status character varying(10) COLLATE public.nocase,
    note_type character varying(10) COLLATE public.nocase,
    note_cat character varying(10) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    pay_term character varying(30) COLLATE public.nocase,
    payterm_version integer,
    elec_pay character varying(10) COLLATE public.nocase,
    pay_method character varying(60) COLLATE public.nocase,
    cust_ou integer,
    cust_code character varying(40) COLLATE public.nocase,
    cust_note_no character varying(40) COLLATE public.nocase,
    cust_note_date timestamp without time zone,
    cust_note_amount numeric(25,2),
    comments character varying(512) COLLATE public.nocase,
    tran_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    item_amount numeric(25,2),
    base_amount numeric(25,2),
    par_base_amount numeric(25,2),
    rev_doc_no character varying(40) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    hld_reason_code character varying(20) COLLATE public.nocase,
    auth_date timestamp without time zone,
    disc_comp_basis character varying(10) COLLATE public.nocase,
    discount_proportional character varying(10) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    lsv_id character varying(60) COLLATE public.nocase,
    comp_acct_in character varying(20) COLLATE public.nocase,
    comp_bp_ref character varying(40) COLLATE public.nocase,
    comp_bp_acc_no character varying(80) COLLATE public.nocase,
    esr_id character varying(60) COLLATE public.nocase,
    cust_bank_acct character varying(80) COLLATE public.nocase,
    cust_bank_id character varying(80) COLLATE public.nocase,
    vat_applicable character varying(10) COLLATE public.nocase,
    vat_exchange_rate numeric(25,2),
    vat_charge numeric(25,2),
    non_vat_charge numeric(25,2),
    doc_level_disc numeric(25,2),
    vat_incl character varying(10) COLLATE public.nocase,
    retain_init_distbn character varying(10) COLLATE public.nocase,
    cap_non_ded_charge character varying(10) COLLATE public.nocase,
    average_vat_rate numeric(25,2),
    vat_excl_amount numeric(25,2),
    vat_amount numeric(25,2),
    vat_incl_amount numeric(25,2),
    pre_round_off_amount numeric(25,2),
    rounded_off_amount numeric(25,2),
    batch_id character varying(300) COLLATE public.nocase,
    doc_status character varying(30) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amount numeric(25,2),
    tcal_total_amount numeric(25,2),
    custbank_ptt_reference character varying(60) COLLATE public.nocase,
    custbank_ptt_accno character varying(40) COLLATE public.nocase,
    compbank_ptt_code character varying(40) COLLATE public.nocase,
    cont_participation_id character varying(60) COLLATE public.nocase,
    applied_flag character varying(30) COLLATE public.nocase,
    cust_contractref character varying(80) COLLATE public.nocase,
    cust_bp_ref character varying(40) COLLATE public.nocase,
    autogen_flag character varying(50) COLLATE public.nocase,
    draft_flag character varying(30) COLLATE public.nocase,
    reasoncode character varying(20) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    consistency_stamp character varying(30) COLLATE public.nocase,
    cm_doc_no character varying(40) COLLATE public.nocase,
    workflow_status character varying(40) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(140) COLLATE public.nocase,
    afe_number character varying(40) COLLATE public.nocase,
    job_number character varying(40) COLLATE public.nocase,
    costcenter_hdr character varying(20) COLLATE public.nocase,
    dest_comp_code character varying(20) COLLATE public.nocase,
    dest_ou character varying(40) COLLATE public.nocase,
    dest_fb character varying(80) COLLATE public.nocase,
    dest_sup_code character varying(40) COLLATE public.nocase,
    dest_supacct_code character varying(80) COLLATE public.nocase,
    payproc_point character varying(40) COLLATE public.nocase,
    payment_priority character varying(30) COLLATE public.nocase,
    auto_adjust character varying(30) COLLATE public.nocase,
    inter_compflag character varying(30) COLLATE public.nocase,
    supp_anchor_date timestamp without time zone,
    supp_comments character varying(510) COLLATE public.nocase,
    ims_flag character varying(30) COLLATE public.nocase,
    scheme_code character varying(40) COLLATE public.nocase,
    ict_flag character varying(30) COLLATE public.nocase,
    srdoctype character varying(80) COLLATE public.nocase,
    pdc_flag character varying(30) COLLATE public.nocase,
    own_taxregion character varying(20) COLLATE public.nocase,
    customeraddress character varying(510) COLLATE public.nocase,
    otc_flag character varying(30) COLLATE public.nocase,
    gen_from character varying(50) COLLATE public.nocase,
    ifb_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cdcndcnotehdr_pkey PRIMARY KEY (cdcndc_note_hdr_key),
    CONSTRAINT f_cdcndcnotehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, "timestamp", ict_flag, ifb_flag)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cdcndcnotehdr
    OWNER to proconnect;