-- Table: raw.raw_rpt_receipt_hdr

-- DROP TABLE IF EXISTS "raw".raw_rpt_receipt_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_rpt_receipt_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    receipt_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    receipt_date timestamp without time zone,
    receipt_category character varying(60) COLLATE public.nocase,
    receipt_status character varying(100) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    notype_no character varying(40) COLLATE public.nocase,
    cust_area character varying(100) COLLATE public.nocase,
    cust_code character varying(72) COLLATE public.nocase,
    receipt_route character varying(40) COLLATE public.nocase,
    receipt_mode character varying(72) COLLATE public.nocase,
    adjustment_type character varying(40) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    receipt_amount numeric,
    bank_cash_code character varying(128) COLLATE public.nocase,
    collector character varying(160) COLLATE public.nocase,
    remitter character varying(240) COLLATE public.nocase,
    comments character varying(1024) COLLATE public.nocase,
    instr_no character varying(120) COLLATE public.nocase,
    micr_no character varying(72) COLLATE public.nocase,
    instr_amount numeric,
    instr_date timestamp without time zone,
    remitting_bank character varying(128) COLLATE public.nocase,
    charges numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    card_no character varying(120) COLLATE public.nocase,
    card_auth_no character varying(72) COLLATE public.nocase,
    issuer character varying(160) COLLATE public.nocase,
    card_val_month character varying(40) COLLATE public.nocase,
    card_val_year character varying(60) COLLATE public.nocase,
    unapplied_amount numeric,
    reason_code character varying(40) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    remarks character varying(400) COLLATE public.nocase,
    doc_status character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    flag character varying(48) COLLATE public.nocase,
    par_base_amount numeric,
    par_exchange_rate numeric,
    tran_type character varying(100) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    tcal_status character varying(48) COLLATE public.nocase,
    total_tcal_status numeric,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    insamt_btcal numeric,
    cust_account_code character varying(128) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    pdr_status character varying(100) COLLATE public.nocase,
    lc_number character varying(120) COLLATE public.nocase,
    refid character varying(480) COLLATE public.nocase,
    chargesdeducted numeric,
    tdsamount numeric,
    pdr_rev_flag character varying(48) COLLATE public.nocase,
    instr_type character varying(100) COLLATE public.nocase,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    bld_flag character varying(48) COLLATE public.nocase,
    ims_flag character varying(48) COLLATE public.nocase,
    scheme_code character varying(160) COLLATE public.nocase,
    clearing_type character varying(100) COLLATE public.nocase,
    stax_app_flag character varying(4) COLLATE public.nocase,
    sertax_amount numeric,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    stamp_duty numeric,
    ict_flag character varying(48) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    mrpt_flag character varying(48) COLLATE public.nocase,
    comp_reference character varying(120) COLLATE public.nocase,
    tax_receipt_type character varying(72) COLLATE public.nocase,
    creditcardchrgs numeric,
    report_flag character varying(40) COLLATE public.nocase,
    autogen_flag character varying(48) COLLATE public.nocase,
    realization_date timestamp without time zone,
    instr_status character varying(1020) COLLATE public.nocase,
    receipt_cusaddid character varying(24) COLLATE public.nocase,
    gen_from character varying(100) COLLATE public.nocase,
    undercoll_flag character varying(48) COLLATE public.nocase,
    trnsfr_inv_no character varying(72) COLLATE public.nocase,
    trnsfr_inv_date timestamp without time zone,
    trnsfr_inv_ou integer,
    lgt_invoice_flag character varying(48) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_rpt_receipt_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_rpt_receipt_hdr
    OWNER to proconnect;