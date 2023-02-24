-- Table: dwh.f_jvbkpostingsdtl

-- DROP TABLE IF EXISTS dwh.f_jvbkpostingsdtl;

CREATE TABLE IF NOT EXISTS dwh.f_jvbkpostingsdtl
(
    jvbkpostingsdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    jvbkpostingsdtl_cmpkey bigint,
    jvbkpostingsdtl_datekey bigint,
    jvbkpostingsdtl_currkey bigint,
    jvbkpostingsdtl_opcoakey bigint,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    posting_line_no integer,
    "timestamp" integer,
    line_no integer,
    company_code character varying(20) COLLATE public.nocase,
    posting_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_code character varying(64) COLLATE public.nocase,
    drcr_id character varying(2) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    exchange_rate numeric(13,2),
    base_amount numeric(13,2),
    par_exchange_rate numeric(13,2),
    par_base_amount numeric(13,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    guid character varying(256) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    source_comp character varying(24) COLLATE public.nocase,
    hdrremarks character varying(512) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT jvbkpostingsdtl_pkey PRIMARY KEY (jvbkpostingsdtl_key),
    CONSTRAINT jvbkpostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_jvbkpostingsdtl
    OWNER to proconnect;
-- Index: f_jvbkpostingsdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_jvbkpostingsdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_jvbkpostingsdtl_key_idx
    ON dwh.f_jvbkpostingsdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, posting_line_no ASC NULLS LAST)
    TABLESPACE pg_default;