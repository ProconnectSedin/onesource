-- Table: dwh.f_spyvoucherdtl

-- DROP TABLE IF EXISTS dwh.f_spyvoucherdtl;

CREATE TABLE IF NOT EXISTS dwh.f_spyvoucherdtl
(
    spyvoucherdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    paybatch_no character varying(40) COLLATE public.nocase,
    voucher_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    "timestamp" integer,
    cr_doc_amount numeric(20,2),
    cr_doc_type character varying(80) COLLATE public.nocase,
    pay_amount numeric(20,2),
    discount numeric(20,2),
    penalty numeric(20,2),
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    cr_doc_line_no integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_spyvoucherdtl_pkey PRIMARY KEY (spyvoucherdtl_key),
    CONSTRAINT f_spyvoucherdtl_ukey UNIQUE (ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, "timestamp", cr_doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_spyvoucherdtl
    OWNER to proconnect;
-- Index: f_spyvoucherdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_spyvoucherdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_spyvoucherdtl_key_idx
    ON dwh.f_spyvoucherdtl USING btree
    (ou_id ASC NULLS LAST, paybatch_no COLLATE public.nocase ASC NULLS LAST, voucher_no COLLATE public.nocase ASC NULLS LAST, cr_doc_ou ASC NULLS LAST, cr_doc_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, "timestamp" ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;