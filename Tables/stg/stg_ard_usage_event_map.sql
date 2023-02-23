-- Table: stg.stg_ard_usage_event_map

-- DROP TABLE IF EXISTS stg.stg_ard_usage_event_map;

CREATE TABLE IF NOT EXISTS stg.stg_ard_usage_event_map
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    usage_id character varying(80) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ard_usage_event_map_pkey PRIMARY KEY (company_code, usage_id, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ard_usage_event_map
    OWNER to proconnect;
-- Index: stg_ard_usage_event_map_key_idx

-- DROP INDEX IF EXISTS stg.stg_ard_usage_event_map_key_idx;

CREATE INDEX IF NOT EXISTS stg_ard_usage_event_map_key_idx
    ON stg.stg_ard_usage_event_map USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, usage_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;