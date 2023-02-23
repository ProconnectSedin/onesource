-- Table: dwh.d_asfinperioddtl

-- DROP TABLE IF EXISTS dwh.d_asfinperioddtl;

CREATE TABLE IF NOT EXISTS dwh.d_asfinperioddtl
(
    asfinperioddtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    finyr_code character varying(20) COLLATE public.nocase,
    finprd_code character varying(30) COLLATE public.nocase,
    fin_timestamp integer,
    finprd_desc character varying(80) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    finprd_enddt timestamp without time zone,
    finprd_status character varying(10) COLLATE public.nocase,
    sequence_no integer,
    legacy_date character varying(40) COLLATE public.nocase,
    active_from timestamp without time zone,
    active_to timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    finprd_grp character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_asfinperioddtl_pkey PRIMARY KEY (asfinperioddtl_key),
    CONSTRAINT d_asfinperioddtl_ukey UNIQUE (finyr_code, finprd_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_asfinperioddtl
    OWNER to proconnect;