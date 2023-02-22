-- Table: stg.stg_sr_acctinfo_dtl

-- DROP TABLE IF EXISTS stg.stg_sr_acctinfo_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_sr_acctinfo_dtl
(
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    acct_lineno integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    acc_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    acct_type character varying(40) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amt numeric,
    business_unit character varying(80) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    sub_analysis_code character varying(20) COLLATE public.nocase,
    base_cur_exrate numeric,
    base_amt numeric,
    par_base_cur_exrate numeric,
    par_base_amt numeric,
    status character varying(100) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    hdrremarks character varying(1020) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sr_acctinfo_dtl_pkey UNIQUE (ou_id, tran_no, tran_type, acct_lineno, fb_id, acc_code, drcr_flag)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sr_acctinfo_dtl
    OWNER to proconnect;
-- Index: stg_sr_acctinfo_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_sr_acctinfo_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_sr_acctinfo_dtl_key_idx2
    ON stg.stg_sr_acctinfo_dtl USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, acct_lineno ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;