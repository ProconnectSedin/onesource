-- Table: stg.stg_fcc_prd_pvclose_history

-- DROP TABLE IF EXISTS stg.stg_fcc_prd_pvclose_history;

CREATE TABLE IF NOT EXISTS stg.stg_fcc_prd_pvclose_history
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    fin_period character varying(60) COLLATE public.nocase NOT NULL,
    bfg_code character varying(80) COLLATE public.nocase NOT NULL,
    serial_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    ou_id integer NOT NULL,
    run_no character varying(72) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    closed_by character varying(120) COLLATE public.nocase,
    closed_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk__fcc_prd___2502578f0d9d50b0 PRIMARY KEY (company_code, fb_id, fin_year, fin_period, bfg_code, serial_no, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fcc_prd_pvclose_history
    OWNER to proconnect;
-- Index: stg_fcc_prd_pvclose_history_key_idx

-- DROP INDEX IF EXISTS stg.stg_fcc_prd_pvclose_history_key_idx;

CREATE INDEX IF NOT EXISTS stg_fcc_prd_pvclose_history_key_idx
    ON stg.stg_fcc_prd_pvclose_history USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, bfg_code COLLATE public.nocase ASC NULLS LAST, serial_no COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;