-- Table: dwh.f_srreceiptmst

-- DROP TABLE IF EXISTS dwh.f_srreceiptmst;

CREATE TABLE IF NOT EXISTS dwh.f_srreceiptmst
(
    srreceiptmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    srreceiptmst_datekey bigint,
    srreceiptmst_bankkey bigint,
    srrreceiptmst_suppkey bigint,
    srrreceiptmst_currkey bigint,
    srrreceiptmst_acckey bigint,
    ou_id integer,
    receipt_no character varying(40) COLLATE public.nocase,
    receipt_type character varying(10) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    batch_id character varying(260) COLLATE public.nocase,
    origin_no character varying(40) COLLATE public.nocase,
    receipt_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    notype_no character varying(20) COLLATE public.nocase,
    receipt_status character varying(10) COLLATE public.nocase,
    supplier_code character varying(40) COLLATE public.nocase,
    receipt_route character varying(10) COLLATE public.nocase,
    receipt_method character varying(10) COLLATE public.nocase,
    receipt_mode character varying(10) COLLATE public.nocase,
    bank_cash_code character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    exchange_rate numeric(20,2),
    receipt_amount_bef_roff numeric(20,2),
    receipt_amount numeric(20,2),
    apply character varying(10) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    instr_no character varying(60) COLLATE public.nocase,
    micr_no character varying(60) COLLATE public.nocase,
    instr_amount numeric(20,2),
    instr_date timestamp without time zone,
    instr_status character varying(50) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    charges numeric(13,2),
    ref_no character varying(60) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    sub_analysis_code character varying(10) COLLATE public.nocase,
    reason_code character varying(20) COLLATE public.nocase,
    rr_flag character varying(10) COLLATE public.nocase,
    pbcexchrate numeric(13,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    doc_status character varying(30) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    consistency_stamp character varying(30) COLLATE public.nocase,
    instr_type character varying(50) COLLATE public.nocase,
    pdr_status character varying(50) COLLATE public.nocase,
    pdr_rev_flag character varying(30) COLLATE public.nocase,
    bld_flag character varying(30) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(140) COLLATE public.nocase,
    exratebanktoreceive numeric(20,2),
    bankamount numeric(20,2),
    bankamountbase numeric(20,2),
    workflow_status character varying(40) COLLATE public.nocase,
    ict_flag character varying(30) COLLATE public.nocase,
    report_flag character varying(20) COLLATE public.nocase,
    autogen_flag character varying(30) COLLATE public.nocase,
    realization_date timestamp without time zone,
    gen_from character varying(50) COLLATE public.nocase,
    auto_adjust character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_srreceiptmst_pkey PRIMARY KEY (srreceiptmst_key),
    CONSTRAINT f_srreceiptmst_ukey UNIQUE (ou_id, receipt_no, receipt_type, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_srreceiptmst
    OWNER to proconnect;
-- Index: f_srreceiptmst_key_idx

-- DROP INDEX IF EXISTS dwh.f_srreceiptmst_key_idx;

CREATE INDEX IF NOT EXISTS f_srreceiptmst_key_idx
    ON dwh.f_srreceiptmst USING btree
    (ou_id ASC NULLS LAST, receipt_no COLLATE public.nocase ASC NULLS LAST, receipt_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;