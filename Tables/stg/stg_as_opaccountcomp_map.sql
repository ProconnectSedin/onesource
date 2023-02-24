-- Table: stg.stg_as_opaccountcomp_map

-- DROP TABLE IF EXISTS stg.stg_as_opaccountcomp_map;

CREATE TABLE IF NOT EXISTS stg.stg_as_opaccountcomp_map
(
    opcoa_id character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    map_status character varying(8) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT as_opaccountcomp_map_pkey PRIMARY KEY (opcoa_id, account_code, company_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_as_opaccountcomp_map
    OWNER to proconnect;
-- Index: stg_as_opaccountcomp_map_key_idx

-- DROP INDEX IF EXISTS stg.stg_as_opaccountcomp_map_key_idx;

CREATE INDEX IF NOT EXISTS stg_as_opaccountcomp_map_key_idx
    ON stg.stg_as_opaccountcomp_map USING btree
    (opcoa_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;