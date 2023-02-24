-- Table: stg.stg_sr_receipt_mst

-- DROP TABLE IF EXISTS stg.stg_sr_receipt_mst;

CREATE TABLE IF NOT EXISTS stg.stg_sr_receipt_mst
(
    ou_id integer NOT NULL,
    receipt_no character varying(72) COLLATE public.nocase NOT NULL,
    receipt_type character varying(16) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    batch_id character varying(512) COLLATE public.nocase,
    origin_no character varying(72) COLLATE public.nocase,
    receipt_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    notype_no character varying(40) COLLATE public.nocase,
    receipt_status character varying(8) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    receipt_route character varying(16) COLLATE public.nocase,
    receipt_method character varying(16) COLLATE public.nocase,
    receipt_mode character varying(16) COLLATE public.nocase,
    bank_cash_code character varying(128) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    receipt_amount_bef_roff numeric,
    receipt_amount numeric,
    apply character varying(16) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    instr_no character varying(120) COLLATE public.nocase,
    micr_no character varying(120) COLLATE public.nocase,
    instr_amount numeric,
    instr_date timestamp without time zone,
    instr_status character varying(100) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    charges numeric,
    ref_no character varying(120) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    sub_analysis_code character varying(20) COLLATE public.nocase,
    reason_code character varying(40) COLLATE public.nocase,
    rr_flag character varying(16) COLLATE public.nocase,
    pbcexchrate numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    doc_status character varying(48) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    instr_type character varying(100) COLLATE public.nocase,
    pdr_status character varying(100) COLLATE public.nocase,
    pdr_rev_flag character varying(48) COLLATE public.nocase,
    bld_flag character varying(48) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    exratebanktoreceive numeric,
    bankamount numeric,
    bankamountbase numeric,
    workflow_status character varying(80) COLLATE public.nocase,
    ict_flag character varying(48) COLLATE public.nocase,
    report_flag character varying(40) COLLATE public.nocase,
    autogen_flag character varying(48) COLLATE public.nocase,
    realization_date timestamp without time zone,
    gen_from character varying(100) COLLATE public.nocase,
    auto_adjust character varying(48) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sr_receipt_mst_pkey PRIMARY KEY (ou_id, receipt_no, receipt_type, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sr_receipt_mst
    OWNER to proconnect;
-- Index: stg_sr_receipt_mst_key_idx

-- DROP INDEX IF EXISTS stg.stg_sr_receipt_mst_key_idx;

CREATE INDEX IF NOT EXISTS stg_sr_receipt_mst_key_idx
    ON stg.stg_sr_receipt_mst USING btree
    (ou_id ASC NULLS LAST, receipt_no COLLATE public.nocase ASC NULLS LAST, receipt_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;