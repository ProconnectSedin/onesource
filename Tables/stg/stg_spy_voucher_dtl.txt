-- Table: stg.stg_spy_voucher_dtl

-- DROP TABLE IF EXISTS stg.stg_spy_voucher_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_spy_voucher_dtl
(
    ou_id integer NOT NULL,
    paybatch_no character varying(72) COLLATE public.nocase NOT NULL,
    voucher_no character varying(72) COLLATE public.nocase NOT NULL,
    cr_doc_ou integer NOT NULL,
    cr_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    tran_type character varying(100) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    cr_doc_amount numeric,
    cr_doc_type character varying(160) COLLATE public.nocase NOT NULL,
    pay_amount numeric,
    discount numeric,
    penalty numeric,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    variance_amount numeric,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    tcal_status character varying(48) COLLATE public.nocase,
    cr_doc_line_no integer,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    tax_adj_jvno character varying(16000) COLLATE public.nocase,
    prop_wht_amt numeric,
    app_wht_amt numeric,
    own_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT spy_voucher_dtl_pkey PRIMARY KEY (ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, cr_doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_spy_voucher_dtl
    OWNER to proconnect;
-- Index: stg_spy_voucher_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_spy_voucher_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_spy_voucher_dtl_key_idx
    ON stg.stg_spy_voucher_dtl USING btree
    (ou_id ASC NULLS LAST, paybatch_no COLLATE public.nocase ASC NULLS LAST, voucher_no COLLATE public.nocase ASC NULLS LAST, cr_doc_ou ASC NULLS LAST, cr_doc_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;