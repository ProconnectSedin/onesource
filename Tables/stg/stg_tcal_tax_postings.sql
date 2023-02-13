-- Table: stg.stg_tcal_tax_postings

-- DROP TABLE IF EXISTS stg.stg_tcal_tax_postings;

CREATE TABLE IF NOT EXISTS stg.stg_tcal_tax_postings
(
    tran_no character varying(36) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_line_no integer,
    acct_line_no integer,
    acct_type character varying(30) COLLATE public.nocase,
    acct_subtype character varying(30) COLLATE public.nocase,
    acct_code character varying(64) COLLATE public.nocase,
    contra_acct_type character varying(30) COLLATE public.nocase,
    dr_cr_flag character varying(20) COLLATE public.nocase,
    original_comp_tax_amt numeric(20,2),
    comp_tax_amt numeric(20,2),
    corr_tax_amt numeric(20,2),
    comp_tax_amt_bascurr numeric(20,2),
    corr_tax_amt_bascurr numeric(20,2),
    comp_tax_amt_pbascurr numeric(20,2),
    corr_tax_amt_pbascurr numeric(20,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    posting_curr character varying(20) COLLATE public.nocase,
    comp_posting_amt numeric(20,2),
    corr_posting_amt numeric(20,2),
    addnl_param1 integer,
    addnl_param2 numeric(20,2),
    addnl_param3 character varying(80) COLLATE public.nocase,
    addnl_param4 character varying(510) COLLATE public.nocase,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    pbas_exch_rate numeric(20,2),
    sub_acct_type character varying(64) COLLATE public.nocase,
    sub_account_code character varying(64) COLLATE public.nocase,
    sub_cost_center character varying(64) COLLATE public.nocase,
    anal_code_sub character varying(20) COLLATE public.nocase,
    sub_anal_code_sub character varying(20) COLLATE public.nocase,
    sub_acct_sub_type character varying(30) COLLATE public.nocase,
    bas_exch_rate numeric(20,2),
    tax_code character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(24) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(50) COLLATE public.nocase,
    cr_doc_term character varying(40) COLLATE public.nocase,
    ttran_taxable_amt numeric(20,2),
    ttran_tax_amt numeric(20,2),
    ttran_tax_code character varying(24) COLLATE public.nocase,
    posting_flag character varying(24) COLLATE public.nocase,
    ref_doc_line_no integer,
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tcal_tax_postings
    OWNER to proconnect;
-- Index: f_tcaltaxpsotings_idx

-- DROP INDEX IF EXISTS stg.f_tcaltaxpsotings_idx;

CREATE INDEX IF NOT EXISTS f_tcaltaxpsotings_idx
    ON stg.stg_tcal_tax_postings USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_line_no ASC NULLS LAST, acct_line_no ASC NULLS LAST)
    TABLESPACE pg_default;