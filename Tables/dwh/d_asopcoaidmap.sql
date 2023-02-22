-- Table: dwh.d_asopcoaidmap

-- DROP TABLE IF EXISTS dwh.d_asopcoaidmap;

CREATE TABLE IF NOT EXISTS dwh.d_asopcoaidmap
(
    asopcoaidmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    opcoa_id character varying(20) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    map_status character varying(4) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_asopcoaidmap_pkey PRIMARY KEY (asopcoaidmap_key),
    CONSTRAINT d_asopcoaidmap_ukey UNIQUE (opcoa_id, company_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_asopcoaidmap
    OWNER to proconnect;
-- Index: d_asopcoaidmap_key_idx1

-- DROP INDEX IF EXISTS dwh.d_asopcoaidmap_key_idx1;

CREATE INDEX IF NOT EXISTS d_asopcoaidmap_key_idx1
    ON dwh.d_asopcoaidmap USING btree
    (opcoa_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;