-- Table: dwh.d_aspostingruledtl

-- DROP TABLE IF EXISTS dwh.d_aspostingruledtl;

CREATE TABLE IF NOT EXISTS dwh.d_aspostingruledtl
(
    aspostingruledtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    jv_type character varying(50) COLLATE public.nocase,
    effective_from timestamp without time zone,
    autopost_acctype character varying(80) COLLATE public.nocase,
    ctrl_acctype character varying(80) COLLATE public.nocase,
    account_class character varying(40) COLLATE public.nocase,
    account_group character varying(40) COLLATE public.nocase,
    sequence_no integer,
    "timestamp" integer,
    account_code character varying(64) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    effective_to timestamp without time zone,
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
    CONSTRAINT d_aspostingruledtl_pkey PRIMARY KEY (aspostingruledtl_key),
    CONSTRAINT d_aspostingruledtl_ukey UNIQUE (company_code, jv_type, effective_from, autopost_acctype, ctrl_acctype, account_class, account_group, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_aspostingruledtl
    OWNER to proconnect;
-- Index: d_aspostingruledtl_key_idx1

-- DROP INDEX IF EXISTS dwh.d_aspostingruledtl_key_idx1;

CREATE INDEX IF NOT EXISTS d_aspostingruledtl_key_idx1
    ON dwh.d_aspostingruledtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, jv_type COLLATE public.nocase ASC NULLS LAST, effective_from ASC NULLS LAST, autopost_acctype COLLATE public.nocase ASC NULLS LAST, ctrl_acctype COLLATE public.nocase ASC NULLS LAST, account_class COLLATE public.nocase ASC NULLS LAST, account_group COLLATE public.nocase ASC NULLS LAST, sequence_no ASC NULLS LAST)
    TABLESPACE pg_default;