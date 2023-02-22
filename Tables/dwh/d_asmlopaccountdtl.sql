-- Table: dwh.d_asmlopaccountdtl

-- DROP TABLE IF EXISTS dwh.d_asmlopaccountdtl;

CREATE TABLE IF NOT EXISTS dwh.d_asmlopaccountdtl
(
    asmlopaccountdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    language_id integer,
    opcoa_id character varying(20) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    ml_account_desc character varying(80) COLLATE public.nocase,
    ml_account_desc_shd character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    currency_code character varying(10) COLLATE public.nocase,
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
    CONSTRAINT d_asmlopaccountdtl_pkey PRIMARY KEY (asmlopaccountdtl_key),
    CONSTRAINT d_asmlopaccountdtl_ukey UNIQUE (language_id, opcoa_id, account_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_asmlopaccountdtl
    OWNER to proconnect;
-- Index: d_asmlopaccountdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.d_asmlopaccountdtl_key_idx1;

CREATE INDEX IF NOT EXISTS d_asmlopaccountdtl_key_idx1
    ON dwh.d_asmlopaccountdtl USING btree
    (language_id ASC NULLS LAST, opcoa_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;