-- Table: dwh.d_emodcountrymst

-- DROP TABLE IF EXISTS dwh.d_emodcountrymst;

CREATE TABLE IF NOT EXISTS dwh.d_emodcountrymst
(
    emodcountrymst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    country_code character varying(10) COLLATE public.nocase,
    iso_curr_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    country_descr character varying(200) COLLATE public.nocase,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT emodcountrymst_pkey PRIMARY KEY (emodcountrymst_key),
    CONSTRAINT emodcountrymst_ukey UNIQUE (country_code, iso_curr_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_emodcountrymst
    OWNER to proconnect;