-- Table: stg.stg_tstl_tax_postings

-- DROP TABLE IF EXISTS stg.stg_tstl_tax_postings;

CREATE TABLE IF NOT EXISTS stg.stg_tstl_tax_postings
(
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_line_no integer NOT NULL,
    acct_line_no integer NOT NULL,
    acct_type character varying(60) COLLATE public.nocase NOT NULL,
    acct_subtype character varying(60) COLLATE public.nocase,
    acct_code character varying(128) COLLATE public.nocase NOT NULL,
    dr_cr_flag character varying(32) COLLATE public.nocase NOT NULL,
    comp_tax_amt numeric NOT NULL,
    corr_tax_amt numeric NOT NULL,
    comp_tax_amt_bascurr numeric NOT NULL,
    corr_tax_amt_bascurr numeric NOT NULL,
    comp_tax_amt_pbascurr numeric,
    corr_tax_amt_pbascurr numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character(20) COLLATE public.nocase,
    subanalysis_code character(20) COLLATE public.nocase,
    addnl_param1 integer,
    addnl_param2 numeric,
    addnl_param3 character varying(160) COLLATE public.nocase,
    addnl_param4 character varying(1020) COLLATE public.nocase,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase NOT NULL,
    modified_date timestamp without time zone NOT NULL,
    tax_code character varying(40) COLLATE public.nocase,
    tax_ref_doc_no character varying(72) COLLATE public.nocase,
    tax_ref_doc_ou integer,
    tax_ref_doc_type character varying(160) COLLATE public.nocase,
    tax_tran_date timestamp without time zone,
    tax_refdoc_line_no integer,
    contraacct_type character varying(60) COLLATE public.nocase,
    orig_comp_tax_amt numeric,
    posting_curr character varying(20) COLLATE public.nocase,
    compposting_amt numeric,
    corrposting_amt numeric,
    pbasexch_rate numeric,
    subacct_type character varying(60) COLLATE public.nocase,
    subaccount_code character varying(128) COLLATE public.nocase,
    subcost_center character varying(40) COLLATE public.nocase,
    analcode_sub character(20) COLLATE public.nocase,
    subanal_code_sub character(20) COLLATE public.nocase,
    subacct_sub_type character varying(60) COLLATE public.nocase,
    basexch_rate numeric,
    refdoc_no character varying(72) COLLATE public.nocase,
    refdoc_ou integer,
    refdoc_type character varying(100) COLLATE public.nocase,
    crdoc_term character varying(80) COLLATE public.nocase,
    ttrantaxable_amt numeric,
    ttrantax_amt numeric,
    ttran_taxcode character varying(40) COLLATE public.nocase,
    post_flag character varying(48) COLLATE public.nocase,
    refdoc_line_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT tstl_tax_postings_pk PRIMARY KEY (tran_no, tax_type, tran_type, tran_ou, tran_line_no, acct_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tstl_tax_postings
    OWNER to proconnect;
-- Index: stg_tstl_tax_postings_idx

-- DROP INDEX IF EXISTS stg.stg_tstl_tax_postings_idx;

CREATE INDEX IF NOT EXISTS stg_tstl_tax_postings_idx
    ON stg.stg_tstl_tax_postings USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_line_no ASC NULLS LAST, acct_line_no ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_tstl_tax_postings_idx1

-- DROP INDEX IF EXISTS stg.stg_tstl_tax_postings_idx1;

CREATE INDEX IF NOT EXISTS stg_tstl_tax_postings_idx1
    ON stg.stg_tstl_tax_postings USING btree
    (acct_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;