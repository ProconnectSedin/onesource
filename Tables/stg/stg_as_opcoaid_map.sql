-- Table: stg.stg_as_opcoaid_map

-- DROP TABLE IF EXISTS stg.stg_as_opcoaid_map;

CREATE TABLE IF NOT EXISTS stg.stg_as_opcoaid_map
(
    opcoa_id character varying(40) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    map_status character varying(8) COLLATE public.nocase,
    resou_id integer,
    srccoa_id character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT as_opcoaid_map_pkey PRIMARY KEY (opcoa_id, company_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_as_opcoaid_map
    OWNER to proconnect;
-- Index: stg_as_opcoaid_map_key_idx2

-- DROP INDEX IF EXISTS stg.stg_as_opcoaid_map_key_idx2;

CREATE INDEX IF NOT EXISTS stg_as_opcoaid_map_key_idx2
    ON stg.stg_as_opcoaid_map USING btree
    (opcoa_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;