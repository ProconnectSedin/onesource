-- Table: raw.raw_aloc_location_mst

-- DROP TABLE IF EXISTS "raw".raw_aloc_location_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_aloc_location_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_aloc_location_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_aloc_location_mst
    OWNER to proconnect;