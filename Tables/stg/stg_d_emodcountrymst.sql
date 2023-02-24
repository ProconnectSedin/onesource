-- Table: stg.stg_d_emodcountrymst

-- DROP TABLE IF EXISTS stg.stg_d_emodcountrymst;

CREATE TABLE IF NOT EXISTS stg.stg_d_emodcountrymst
(
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

ALTER TABLE IF EXISTS stg.stg_d_emodcountrymst
    OWNER to proconnect;