-- Table: dwh.f_fccyrclosestatus

-- DROP TABLE IF EXISTS dwh.f_fccyrclosestatus;

CREATE TABLE IF NOT EXISTS dwh.f_fccyrclosestatus
(
    fccyrclosestatus_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fccyrclosestatus_companykey bigint,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    ou_id integer,
    status character varying(50) COLLATE public.nocase,
    closed_by character varying(60) COLLATE public.nocase,
    closed_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    fcc_finyr_startdt timestamp without time zone,
    fcc_finyr_enddt timestamp without time zone,
    fcc_finyr_range character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT fccyrclosestatus_pkey PRIMARY KEY (fccyrclosestatus_key),
    CONSTRAINT fccyrclosestatus_ukey UNIQUE (company_code, fb_id, fin_year)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fccyrclosestatus
    OWNER to proconnect;
-- Index: fcc_yr_close_status_key_idx

-- DROP INDEX IF EXISTS dwh.fcc_yr_close_status_key_idx;

CREATE INDEX IF NOT EXISTS fcc_yr_close_status_key_idx
    ON dwh.f_fccyrclosestatus USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;