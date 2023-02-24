-- Table: dwh.f_tstltranhdr

-- DROP TABLE IF EXISTS dwh.f_tstltranhdr;

CREATE TABLE IF NOT EXISTS dwh.f_tstltranhdr
(
    tstltranhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    tran_no character varying(36) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tax_community character varying(50) COLLATE public.nocase,
    tran_date timestamp without time zone,
    applicable_flag character varying(10) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    buid character varying(40) COLLATE public.nocase,
    fbid character varying(40) COLLATE public.nocase,
    tran_curr character varying(20) COLLATE public.nocase,
    incl_option character varying(16) COLLATE public.nocase,
    tax_excl_amt numeric(25,2),
    tax_incl_amt numeric(25,2),
    comp_tax_amt numeric(25,2),
    corr_tax_amt numeric(25,2),
    party_type character varying(16) COLLATE public.nocase,
    supp_cust_code character varying(36) COLLATE public.nocase,
    assessee_type character varying(80) COLLATE public.nocase,
    cap_deduct_charge character varying(16) COLLATE public.nocase,
    bas_exch_rate numeric(25,2),
    pbas_exch_rate numeric(25,2),
    comp_tax_amt_bascurr numeric(25,2),
    corr_tax_amt_bascurr numeric(25,2),
    nontax_tc_amt numeric(25,2),
    nontax_disc_amt numeric(25,2),
    component_name character varying(80) COLLATE public.nocase,
    original_tran_no character varying(36) COLLATE public.nocase,
    doc_status character varying(16) COLLATE public.nocase,
    tax_status character varying(16) COLLATE public.nocase,
    cert_recd_status character varying(16) COLLATE public.nocase,
    dr_cr_flag character varying(16) COLLATE public.nocase,
    usage_id character varying(64) COLLATE public.nocase,
    tax_excl_amt_bascurr numeric(25,2),
    tax_incl_amt_bascurr numeric(25,2),
    weightage_factor integer,
    tax_rate numeric(25,2),
    "timestamp" integer,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    post_date timestamp without time zone,
    rev_doc_date timestamp without time zone,
    rev_decl_year character varying(20) COLLATE public.nocase,
    revdecl_period character varying(30) COLLATE public.nocase,
    tranamt numeric(25,2),
    rev_tran_no character varying(36) COLLATE public.nocase,
    tradetype character varying(16) COLLATE public.nocase,
    rec_type character varying(2) COLLATE public.nocase,
    threshld_flag character varying(24) COLLATE public.nocase,
    cap_flag character varying(80) COLLATE public.nocase,
    supp_cust_name character varying(120) COLLATE public.nocase,
    supp_inv_no character varying(200) COLLATE public.nocase,
    supp_inv_date timestamp without time zone,
    supp_inv_amount numeric(25,2),
    recon_flag character varying(24) COLLATE public.nocase,
    nature_of_reason character varying(10) COLLATE public.nocase,
    report_flag character varying(20) COLLATE public.nocase,
    aadhaar_no character varying(80) COLLATE public.nocase,
    pan_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_tstltranhdr_pkey PRIMARY KEY (tstltranhdr_key),
    CONSTRAINT f_tstltranhdr_ukey UNIQUE (tran_no, tax_type, tran_type, tran_ou, component_name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tstltranhdr
    OWNER to proconnect;
-- Index: f_tstltranhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_tstltranhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_tstltranhdr_key_idx
    ON dwh.f_tstltranhdr USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, component_name COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;