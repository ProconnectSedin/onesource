-- Table: dwh.f_tstltaxpostings

-- DROP TABLE IF EXISTS dwh.f_tstltaxpostings;

CREATE TABLE IF NOT EXISTS dwh.f_tstltaxpostings
(
    tstltaxpostings_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_no character varying(36) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_line_no integer,
    acct_line_no integer,
    acct_type character varying(30) COLLATE public.nocase,
    acct_subtype character varying(30) COLLATE public.nocase,
    acct_code character varying(64) COLLATE public.nocase,
    dr_cr_flag character varying(16) COLLATE public.nocase,
    comp_tax_amt numeric(25,2),
    corr_tax_amt numeric(25,2),
    comp_tax_amt_bascurr numeric(25,2),
    corr_tax_amt_bascurr numeric(25,2),
    comp_tax_amt_pbascurr numeric(25,2),
    corr_tax_amt_pbascurr numeric(25,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tax_code character varying(20) COLLATE public.nocase,
    tax_tran_date timestamp without time zone,
    contraacct_type character varying(30) COLLATE public.nocase,
    orig_comp_tax_amt numeric(25,2),
    compposting_amt numeric(25,2),
    corrposting_amt numeric(25,2),
    pbasexch_rate numeric(25,2),
    subaccount_code character varying(64) COLLATE public.nocase,
    basexch_rate numeric(25,2),
    post_flag character varying(24) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    account_key bigint,
    CONSTRAINT f_tstltaxpostings_pkey PRIMARY KEY (tstltaxpostings_key),
    CONSTRAINT f_tstltaxpostings_ukey UNIQUE (tran_no, tax_type, tran_type, tran_ou, tran_line_no, acct_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tstltaxpostings
    OWNER to proconnect;
-- Index: f_tstltaxpostings_key_idx

-- DROP INDEX IF EXISTS dwh.f_tstltaxpostings_key_idx;

CREATE INDEX IF NOT EXISTS f_tstltaxpostings_key_idx
    ON dwh.f_tstltaxpostings USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_line_no ASC NULLS LAST, acct_line_no ASC NULLS LAST)
    TABLESPACE pg_default;
