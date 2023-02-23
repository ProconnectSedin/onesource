-- Table: stg.stg_fcc_bfg_yr_close_status

-- DROP TABLE IF EXISTS stg.stg_fcc_bfg_yr_close_status;

CREATE TABLE IF NOT EXISTS stg.stg_fcc_bfg_yr_close_status
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    bfg_code character varying(80) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    status character varying(100) COLLATE public.nocase,
    closed_by character varying(120) COLLATE public.nocase,
    closed_date timestamp without time zone,
    run_no character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fcc_finyr_startdt timestamp without time zone,
    fcc_finyr_enddt timestamp without time zone,
    fcc_finyr_range character varying(100) COLLATE public.nocase,
    batch_id character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT fcc_bfg_yr_close_status_pkey PRIMARY KEY (company_code, ou_id, bfg_code, fb_id, fin_year)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fcc_bfg_yr_close_status
    OWNER to proconnect;
-- Index: stg_fcc_bfg_yr_close_status_idx

-- DROP INDEX IF EXISTS stg.stg_fcc_bfg_yr_close_status_idx;

CREATE INDEX IF NOT EXISTS stg_fcc_bfg_yr_close_status_idx
    ON stg.stg_fcc_bfg_yr_close_status USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, bfg_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;