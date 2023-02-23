-- Table: dwh.f_cdcnpaymentdtl

-- DROP TABLE IF EXISTS dwh.f_cdcnpaymentdtl;

CREATE TABLE IF NOT EXISTS dwh.f_cdcnpaymentdtl
(
    cdcnpaymentdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    posting_status character varying(10) COLLATE public.nocase,
    posting_date timestamp without time zone,
    due_date timestamp without time zone,
    due_amount_type character varying(10) COLLATE public.nocase,
    due_percent numeric(23,2),
    due_amount numeric(23,2),
    disc_comp_amount numeric(23,2),
    disc_amount_type character varying(10) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric(23,2),
    disc_amount numeric(23,2),
    penalty_percent numeric(23,2),
    esr_ref_no character varying(60) COLLATE public.nocase,
    esr_coding_line character varying(260) COLLATE public.nocase,
    base_due_amount numeric(23,2),
    base_disc_amount numeric(23,2),
    guid character varying(260) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cdcnpaymentdtl_pkey PRIMARY KEY (cdcnpaymentdtl_key),
    CONSTRAINT f_cdcnpaymentdtl_ukey UNIQUE (tran_ou, tran_no, term_no, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cdcnpaymentdtl
    OWNER to proconnect;
-- Index: f_cdcnpaymentdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_cdcnpaymentdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_cdcnpaymentdtl_key_idx
    ON dwh.f_cdcnpaymentdtl USING btree
    (tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;