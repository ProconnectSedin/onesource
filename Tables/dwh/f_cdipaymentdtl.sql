-- Table: dwh.f_cdipaymentdtl

-- DROP TABLE IF EXISTS dwh.f_cdipaymentdtl;

CREATE TABLE IF NOT EXISTS dwh.f_cdipaymentdtl
(
    cdipaymentdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cdipaymentdtl_datekey integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    due_date timestamp without time zone,
    due_amount_type character varying(10) COLLATE public.nocase,
    due_percent numeric(20,2),
    due_amount numeric(20,2),
    disc_comp_amount numeric(20,2),
    disc_amount_type character varying(10) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric(20,2),
    disc_amount numeric(20,2),
    penalty_percent numeric(13,2),
    esr_ref_no character varying(60) COLLATE public.nocase,
    base_due_amount numeric(20,2),
    base_disc_amount numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cdipaymentdtl_pkey PRIMARY KEY (cdipaymentdtl_key),
    CONSTRAINT f_cdipaymentdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cdipaymentdtl
    OWNER to proconnect;
-- Index: f_cdipaymentdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_cdipaymentdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_cdipaymentdtl_key_idx
    ON dwh.f_cdipaymentdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;