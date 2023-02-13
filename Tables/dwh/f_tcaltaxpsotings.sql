-- Table: dwh.f_tcaltaxpsotings

-- DROP TABLE IF EXISTS dwh.f_tcaltaxpsotings;

CREATE TABLE IF NOT EXISTS dwh.f_tcaltaxpsotings
(
    tcal_tax_psot_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    pbas_exch_rate numeric(20,2),
    sub_account_code character varying(64) COLLATE public.nocase,
    bas_exch_rate numeric(20,2),
    tax_code character varying(20) COLLATE public.nocase,
    posting_flag character varying(24) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_tcal_tax_psotings_pkey PRIMARY KEY (tcal_tax_psot_key),
    CONSTRAINT f_tcal_tax_psotings_ukey UNIQUE (tran_no, tax_type, tran_type, tran_ou, tran_line_no, acct_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tcaltaxpsotings
    OWNER to proconnect;
-- Index: f_tcaltaxpsotings_idx

-- DROP INDEX IF EXISTS dwh.f_tcaltaxpsotings_idx;

CREATE INDEX IF NOT EXISTS f_tcaltaxpsotings_idx
    ON dwh.f_tcaltaxpsotings USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_line_no ASC NULLS LAST, acct_line_no ASC NULLS LAST)
    TABLESPACE pg_default;