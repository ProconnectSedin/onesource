-- Table: stg.stg_sdin_tcd_dtl

-- DROP TABLE IF EXISTS stg.stg_sdin_tcd_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_sdin_tcd_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    item_tcd_code character varying(128) COLLATE public.nocase NOT NULL,
    item_tcd_var character varying(128) COLLATE public.nocase NOT NULL,
    tcd_version integer NOT NULL,
    "timestamp" integer NOT NULL,
    item_type character varying(12) COLLATE public.nocase,
    tcd_level character varying(4) COLLATE public.nocase,
    tcd_rate numeric,
    taxable_amount numeric,
    tcd_amount numeric,
    tcd_currency character varying(20) COLLATE public.nocase,
    usage character varying(160) COLLATE public.nocase,
    base_amount numeric,
    par_base_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcd_line_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sdin_tcd_dtl_pkey UNIQUE (tran_type, tran_ou, tran_no, line_no, item_tcd_code, item_tcd_var, tcd_version)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sdin_tcd_dtl
    OWNER to proconnect;
-- Index: stg_sdin_tcd_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_sdin_tcd_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_sdin_tcd_dtl_key_idx2
    ON stg.stg_sdin_tcd_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, item_tcd_code COLLATE public.nocase ASC NULLS LAST, item_tcd_var COLLATE public.nocase ASC NULLS LAST, tcd_version ASC NULLS LAST)
    TABLESPACE pg_default;