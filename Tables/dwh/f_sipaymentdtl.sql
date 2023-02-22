-- Table: dwh.f_sipaymentdtl

-- DROP TABLE IF EXISTS dwh.f_sipaymentdtl;

CREATE TABLE IF NOT EXISTS dwh.f_sipaymentdtl
(
    sipaymentdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    tran_ou integer,
    due_percent numeric(13,2),
    disc_percent numeric(13,2),
    penalty_percent numeric(13,2),
    due_date timestamp without time zone,
    due_amount_type character varying(30) COLLATE public.nocase,
    due_amount numeric(13,2),
    disc_comp_amount numeric(13,2),
    disc_amount_type character varying(30) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_amount numeric(13,2),
    esr_coding_line character varying(36) COLLATE public.nocase,
    base_due_amount numeric(13,2),
    base_disc_amount numeric(13,2),
    lo_id character varying(40) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    "timestamp" integer,
    rev_flag character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sipaymentdtl_pkey PRIMARY KEY (sipaymentdtl_key),
    CONSTRAINT f_sipaymentdtl_ukey UNIQUE (tran_type, tran_no, term_no, tran_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sipaymentdtl
    OWNER to proconnect;
-- Index: f_sipaymentdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sipaymentdtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_sipaymentdtl_key_idx1
    ON dwh.f_sipaymentdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST)
    TABLESPACE pg_default;