-- Table: stg.stg_aloc_location_mst

-- DROP TABLE IF EXISTS stg.stg_aloc_location_mst;

CREATE TABLE IF NOT EXISTS stg.stg_aloc_location_mst
(
    loc_code character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    ou_id integer,
    loc_desc character varying(160) COLLATE public.nocase,
    loc_abbr character varying(300) COLLATE public.nocase,
    parentloc_code character varying(80) COLLATE public.nocase,
    loc_type character varying(160) COLLATE public.nocase,
    loc_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    wf_flag character varying(48) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    latitude numeric,
    longitude numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_aloc_location_mst
    OWNER to proconnect;
-- Index: stg_aloc_location_mst_key_idx

-- DROP INDEX IF EXISTS stg.stg_aloc_location_mst_key_idx;

CREATE INDEX IF NOT EXISTS stg_aloc_location_mst_key_idx
    ON stg.stg_aloc_location_mst USING btree
    (loc_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;