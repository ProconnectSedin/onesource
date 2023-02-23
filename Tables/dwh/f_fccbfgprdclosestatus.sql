-- Table: dwh.f_fccbfgprdclosestatus

-- DROP TABLE IF EXISTS dwh.f_fccbfgprdclosestatus;

CREATE TABLE IF NOT EXISTS dwh.f_fccbfgprdclosestatus
(
    fccbfgprdclosestatus_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    bfg_code character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    run_no character varying(36) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    closed_by character varying(60) COLLATE public.nocase,
    closed_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fcc_finprd_startdt timestamp without time zone,
    fcc_finprd_enddt timestamp without time zone,
    fcc_finyr_startdt timestamp without time zone,
    fcc_finyr_enddt timestamp without time zone,
    fcc_finyr_range character varying(50) COLLATE public.nocase,
    fcc_finprd_range character varying(50) COLLATE public.nocase,
    batch_id character varying(36) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    companycode_key bigint,
    CONSTRAINT f_fccbfgprdclosestatus_pkey PRIMARY KEY (fccbfgprdclosestatus_key),
    CONSTRAINT f_fccbfgprdclosestatus_ukey UNIQUE (company_code, ou_id, bfg_code, fb_id, fin_year, fin_period)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fccbfgprdclosestatus
    OWNER to proconnect;
-- Index: f_fccbfgprdclosestatus_key_idx

-- DROP INDEX IF EXISTS dwh.f_fccbfgprdclosestatus_key_idx;

CREATE INDEX IF NOT EXISTS f_fccbfgprdclosestatus_key_idx
    ON dwh.f_fccbfgprdclosestatus USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, bfg_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;