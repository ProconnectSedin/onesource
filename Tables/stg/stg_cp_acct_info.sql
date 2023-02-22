-- Table: stg.stg_cp_acct_info

-- DROP TABLE IF EXISTS stg.stg_cp_acct_info;

CREATE TABLE IF NOT EXISTS stg.stg_cp_acct_info
(
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    acc_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    tran_date timestamp without time zone,
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
    company_code character varying(40) COLLATE public.nocase,
    component_name character varying(640) COLLATE public.nocase,
    acct_type character varying(60) COLLATE public.nocase,
    bank_cash_code character varying(128) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    sourcecomp character varying(160) COLLATE public.nocase,
    posting_flag character varying(48) COLLATE public.nocase,
    remarks character varying(1024) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT cp_acct_info_pkey UNIQUE (ou_id, tran_no, fb_id, acc_code, drcr_flag, tran_type, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cp_acct_info
    OWNER to proconnect;
-- Index: stg_cp_acct_info_key_idx2

-- DROP INDEX IF EXISTS stg.stg_cp_acct_info_key_idx2;

CREATE INDEX IF NOT EXISTS stg_cp_acct_info_key_idx2
    ON stg.stg_cp_acct_info USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;