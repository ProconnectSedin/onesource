-- Table: stg.stg_stn_acct_info_dtl

-- DROP TABLE IF EXISTS stg.stg_stn_acct_info_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_stn_acct_info_dtl
(
    ou_id character varying(60) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    drcr_flag character varying(24) COLLATE public.nocase NOT NULL,
    account_type character varying(60) COLLATE public.nocase NOT NULL,
    tran_date timestamp without time zone,
    fin_post_date timestamp without time zone,
    currency_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tran_amount numeric,
    fb_id character varying(80) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    pbcur_erate numeric,
    par_base_amt numeric,
    fin_post_status character varying(8) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    transfer_docno character varying(72) COLLATE public.nocase,
    acct_line_no integer,
    bu_id character varying(80) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_acct_info_dtl_pkey UNIQUE (ou_id, company_code, tran_no, tran_type, account_code, drcr_flag, account_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_stn_acct_info_dtl
    OWNER to proconnect;
-- Index: stg_stn_acct_info_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_stn_acct_info_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_stn_acct_info_dtl_key_idx2
    ON stg.stg_stn_acct_info_dtl USING btree
    (ou_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, account_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;