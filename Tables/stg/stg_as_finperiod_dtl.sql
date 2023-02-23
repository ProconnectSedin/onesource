-- Table: stg.stg_as_finperiod_dtl

-- DROP TABLE IF EXISTS stg.stg_as_finperiod_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_as_finperiod_dtl
(
    finyr_code character varying(40) COLLATE public.nocase NOT NULL,
    finprd_code character varying(60) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    finprd_desc character varying(160) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    finprd_enddt timestamp without time zone,
    finprd_status character varying(8) COLLATE public.nocase,
    sequence_no integer,
    legacy_date character varying(80) COLLATE public.nocase,
    active_from timestamp without time zone,
    active_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    finprd_grp character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT as_finperiod_dtl_pkey PRIMARY KEY (finyr_code, finprd_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_as_finperiod_dtl
    OWNER to proconnect;