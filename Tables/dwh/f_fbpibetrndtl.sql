-- Table: dwh.f_fbpibetrndtl

-- DROP TABLE IF EXISTS dwh.f_fbpibetrndtl;

CREATE TABLE IF NOT EXISTS dwh.f_fbpibetrndtl
(
    fbpibetrndtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(20) COLLATE public.nocase,
    fin_period character varying(20) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    drcr_flag character varying(12) COLLATE public.nocase,
    base_amount numeric(25,2),
    tran_amount numeric(25,2),
    batch_id character varying(256) COLLATE public.nocase,
    document_no character varying(36) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    company_code character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    accountcode_key bigint,
    currencycode_key bigint,
    companycode_key bigint,
    CONSTRAINT f_fbpibetrndtl_pkey PRIMARY KEY (fbpibetrndtl_key),
    CONSTRAINT f_fbpibetrndtl_ukey UNIQUE (ou_id, fb_id, fin_year, fin_period, account_code, currency_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fbpibetrndtl
    OWNER to proconnect;
-- Index: f_fbpibetrndtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_fbpibetrndtl_key_idx;

CREATE INDEX IF NOT EXISTS f_fbpibetrndtl_key_idx
    ON dwh.f_fbpibetrndtl USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;