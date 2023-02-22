-- Table: stg.stg_cp_voucher_hdr

-- DROP TABLE IF EXISTS stg.stg_cp_voucher_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_cp_voucher_hdr
(
    ou_id integer NOT NULL,
    voucher_no character varying(80) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    pay_cat character varying(160) COLLATE public.nocase,
    req_date timestamp without time zone,
    business_unit character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    cus_reg_at integer,
    cus_code character varying(72) COLLATE public.nocase,
    pay_date timestamp without time zone,
    pay_method character varying(100) COLLATE public.nocase,
    pay_mode character varying(120) COLLATE public.nocase,
    pay_route character varying(120) COLLATE public.nocase,
    pay_cur character varying(20) COLLATE public.nocase,
    exch_rate numeric,
    pay_amount numeric,
    bank_cash_code character varying(128) COLLATE public.nocase,
    bank_charges character varying(80) COLLATE public.nocase,
    doc_ref character varying(72) COLLATE public.nocase,
    priority character varying(48) COLLATE public.nocase,
    billing_pt integer,
    relpay_pt integer,
    reason_code character varying(40) COLLATE public.nocase,
    el_pay character varying(48) COLLATE public.nocase,
    elec_pay_applied character varying(48) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    hldreason_code character varying(40) COLLATE public.nocase,
    revreason_code character varying(40) COLLATE public.nocase,
    rev_date timestamp without time zone,
    esr_partid character varying(120) COLLATE public.nocase,
    esr_ref character varying(72) COLLATE public.nocase,
    esr_codingline character varying(24) COLLATE public.nocase,
    lsv_contid character varying(120) COLLATE public.nocase,
    lsv_ref character varying(72) COLLATE public.nocase,
    cust_acct_in character varying(120) COLLATE public.nocase,
    cust_account character varying(128) COLLATE public.nocase,
    el_bank_pttcode character varying(128) COLLATE public.nocase,
    el_bank_id character varying(80) COLLATE public.nocase,
    cust_bank_acct character varying(128) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    pay_amt_bef_round numeric,
    roundoff_amt numeric,
    par_exchange_rate numeric,
    hldrev_remarks character varying(400) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    doc_status character varying(48) COLLATE public.nocase,
    tcal_status character varying(48) COLLATE public.nocase,
    total_tcal_amount numeric,
    tcal_exclusive_amt numeric,
    dig_ref_no integer,
    elecslip_ref_no character varying(120) COLLATE public.nocase,
    acc_type character varying(40) COLLATE public.nocase,
    cust_account_code character varying(128) COLLATE public.nocase,
    rebate_voucher character varying(48) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    pdc_status character varying(100) COLLATE public.nocase,
    payee_name character varying(1020) COLLATE public.nocase,
    ims_flag character varying(48) COLLATE public.nocase,
    scheme_code character varying(80) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    adjustment character varying(160) COLLATE public.nocase NOT NULL DEFAULT 'M'::character varying,
    ict_flag character varying(48) COLLATE public.nocase,
    final_settlement character varying(12) COLLATE public.nocase,
    gen_from character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT cp_voucher_hdr_pkey UNIQUE (ou_id, voucher_no, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cp_voucher_hdr
    OWNER to proconnect;
-- Index: stg_cp_voucher_hdr_key_idx2

-- DROP INDEX IF EXISTS stg.stg_cp_voucher_hdr_key_idx2;

CREATE INDEX IF NOT EXISTS stg_cp_voucher_hdr_key_idx2
    ON stg.stg_cp_voucher_hdr USING btree
    (ou_id ASC NULLS LAST, voucher_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;