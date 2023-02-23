-- Table: dwh.d_asopaccountcompmap

-- DROP TABLE IF EXISTS dwh.d_asopaccountcompmap;

CREATE TABLE IF NOT EXISTS dwh.d_asopaccountcompmap
(
    asopaccountcompmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    acc_key bigint,
    opcoa_id character varying(20) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    map_status character varying(10) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_asopaccountcompmap_pkey PRIMARY KEY (asopaccountcompmap_key),
    CONSTRAINT d_asopaccountcompmap_ukey UNIQUE (opcoa_id, account_code, company_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_asopaccountcompmap
    OWNER to proconnect;
-- Index: d_asopaccountcompmap_key_idx

-- DROP INDEX IF EXISTS dwh.d_asopaccountcompmap_key_idx;

CREATE INDEX IF NOT EXISTS d_asopaccountcompmap_key_idx
    ON dwh.d_asopaccountcompmap USING btree
    (opcoa_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;