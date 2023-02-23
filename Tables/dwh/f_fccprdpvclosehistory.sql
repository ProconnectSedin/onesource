-- Table: dwh.f_fccprdpvclosehistory

-- DROP TABLE IF EXISTS dwh.f_fccprdpvclosehistory;

CREATE TABLE IF NOT EXISTS dwh.f_fccprdpvclosehistory
(
    fccprdpvclosehistory_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fccprdpvclosehistory_cmpkey bigint,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    bfg_code character varying(40) COLLATE public.nocase,
    serial_no character varying(36) COLLATE public.nocase,
    "timestamp" integer,
    ou_id integer,
    run_no character varying(36) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    closed_by character varying(60) COLLATE public.nocase,
    closed_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT fccprdpvclosehistory_pkey PRIMARY KEY (fccprdpvclosehistory_key),
    CONSTRAINT fccprdpvclosehistory_ukey UNIQUE (company_code, fb_id, fin_year, fin_period, bfg_code, serial_no, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fccprdpvclosehistory
    OWNER to proconnect;
-- Index: f_fccprdpvclosehistory_key_idx

-- DROP INDEX IF EXISTS dwh.f_fccprdpvclosehistory_key_idx;

CREATE INDEX IF NOT EXISTS f_fccprdpvclosehistory_key_idx
    ON dwh.f_fccprdpvclosehistory USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, bfg_code COLLATE public.nocase ASC NULLS LAST, serial_no COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;