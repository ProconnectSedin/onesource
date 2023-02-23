-- Table: raw.raw_emod_country_mst

-- DROP TABLE IF EXISTS "raw".raw_emod_country_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_emod_country_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    country_code character varying(10) COLLATE public.nocase,
    iso_curr_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    country_descr character varying(200) COLLATE public.nocase,
    createdby character varying(60) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_emod_country_mst
    OWNER to proconnect;