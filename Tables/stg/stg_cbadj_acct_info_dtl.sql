-- Table: stg.stg_cbadj_acct_info_dtl

-- DROP TABLE IF EXISTS stg.stg_cbadj_acct_info_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_cbadj_acct_info_dtl
(
    ou_id integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amount numeric,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    pbcur_erate numeric,
    par_base_amt numeric,
    fin_post_status character varying(100) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    source_comp character varying(48) COLLATE public.nocase,
    component_name character varying(64) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(160) COLLATE public.nocase,
    ref_doc_term character varying(80) COLLATE public.nocase,
    narration character varying(512) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    cust_code character varying(72) COLLATE public.nocase,
    address_id character varying(24) COLLATE public.nocase,
    pdc_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT cbadj_acct_info_dtl_pkey PRIMARY KEY (ou_id, tran_no, tran_type, account_code, drcr_flag, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cbadj_acct_info_dtl
    OWNER to proconnect;
-- Index: stg_cbadj_acct_info_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_cbadj_acct_info_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_cbadj_acct_info_dtl_idx
    ON stg.stg_cbadj_acct_info_dtl USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_cbadj_acct_info_dtl_idx1

-- DROP INDEX IF EXISTS stg.stg_cbadj_acct_info_dtl_idx1;

CREATE INDEX IF NOT EXISTS stg_cbadj_acct_info_dtl_idx1
    ON stg.stg_cbadj_acct_info_dtl USING btree
    (cust_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_cbadj_acct_info_dtl_idx2

-- DROP INDEX IF EXISTS stg.stg_cbadj_acct_info_dtl_idx2;

CREATE INDEX IF NOT EXISTS stg_cbadj_acct_info_dtl_idx2
    ON stg.stg_cbadj_acct_info_dtl USING btree
    (currency_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_cbadj_acct_info_dtl_idx3

-- DROP INDEX IF EXISTS stg.stg_cbadj_acct_info_dtl_idx3;

CREATE INDEX IF NOT EXISTS stg_cbadj_acct_info_dtl_idx3
    ON stg.stg_cbadj_acct_info_dtl USING btree
    (account_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_cbadj_acct_info_dtl_idx4

-- DROP INDEX IF EXISTS stg.stg_cbadj_acct_info_dtl_idx4;

CREATE INDEX IF NOT EXISTS stg_cbadj_acct_info_dtl_idx4
    ON stg.stg_cbadj_acct_info_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;