-- Table: dwh.f_rptreceipthdr

-- DROP TABLE IF EXISTS dwh.f_rptreceipthdr;

CREATE TABLE IF NOT EXISTS dwh.f_rptreceipthdr
(
    rptreceipthdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    receipt_no character varying(36) COLLATE public.nocase,
    "timestamp" integer,
    receipt_date timestamp without time zone,
    receipt_category character varying(30) COLLATE public.nocase,
    receipt_status character varying(50) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    notype_no character varying(20) COLLATE public.nocase,
    cust_area character varying(50) COLLATE public.nocase,
    cust_code character varying(36) COLLATE public.nocase,
    receipt_route character varying(20) COLLATE public.nocase,
    receipt_mode character varying(36) COLLATE public.nocase,
    adjustment_type character varying(20) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    receipt_amount numeric(25,2),
    bank_cash_code character varying(64) COLLATE public.nocase,
    collector character varying(80) COLLATE public.nocase,
    remitter character varying(120) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    instr_no character varying(60) COLLATE public.nocase,
    micr_no character varying(36) COLLATE public.nocase,
    instr_amount numeric(25,2),
    instr_date timestamp without time zone,
    remitting_bank character varying(64) COLLATE public.nocase,
    charges numeric(25,2),
    cost_center character varying(20) COLLATE public.nocase,
    unapplied_amount numeric(25,2),
    reason_code character varying(20) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    remarks character varying(200) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    flag character varying(24) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    tcal_status character varying(24) COLLATE public.nocase,
    tcal_exclusive_amt numeric(25,2),
    insamt_btcal numeric(25,2),
    cust_account_code character varying(64) COLLATE public.nocase,
    ibe_flag character varying(24) COLLATE public.nocase,
    lc_number character varying(60) COLLATE public.nocase,
    chargesdeducted numeric(25,2),
    tdsamount numeric(25,2),
    instr_type character varying(50) COLLATE public.nocase,
    stamp_duty numeric(25,2),
    ict_flag character varying(24) COLLATE public.nocase,
    comp_reference character varying(60) COLLATE public.nocase,
    creditcardchrgs numeric(25,2),
    report_flag character varying(20) COLLATE public.nocase,
    realization_date timestamp without time zone,
    instr_status character varying(510) COLLATE public.nocase,
    lgt_invoice_flag character varying(24) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_rptreceipthdr_pkey PRIMARY KEY (rptreceipthdr_key),
    CONSTRAINT f_rptreceipthdr_ukey UNIQUE (ou_id, receipt_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_rptreceipthdr
    OWNER to proconnect;
-- Index: f_rptreceipthdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_rptreceipthdr_key_idx;

CREATE INDEX IF NOT EXISTS f_rptreceipthdr_key_idx
    ON dwh.f_rptreceipthdr USING btree
    (ou_id ASC NULLS LAST, receipt_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;