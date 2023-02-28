-- Table: raw.raw_spy_voucher_dtl

-- DROP TABLE IF EXISTS "raw".raw_spy_voucher_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_spy_voucher_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_spy_voucher_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_spy_voucher_dtl
    OWNER to proconnect;