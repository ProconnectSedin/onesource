CREATE TABLE dwh.f_tcaltranhdr (
    f_tcaltranhdr_key bigint NOT NULL,
    company_key bigint NOT NULL,
    tran_no character varying(40) COLLATE public.nocase,
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
    incl_option character varying(20) COLLATE public.nocase,
    tax_excl_amt numeric(25,2),
    tax_incl_amt numeric(25,2),
    tran_amt numeric(25,2),
    comp_tax_amt numeric(25,2),
    corr_tax_amt numeric(25,2),
    party_type character varying(20) COLLATE public.nocase,
    supp_cust_code character varying(40) COLLATE public.nocase,
    assessee_type character varying(80) COLLATE public.nocase,
    cap_deduct_charge character varying(20) COLLATE public.nocase,
    bas_exch_rate numeric(25,2),
    pbas_exch_rate numeric(25,2),
    comp_tax_amt_bascurr numeric(25,2),
    corr_tax_amt_bascurr numeric(25,2),
    nontax_tc_amt numeric(25,2),
    nontax_disc_amt numeric(25,2),
    component_name character varying(80) COLLATE public.nocase,
    original_tran_no character varying(40) COLLATE public.nocase,
    reversed_tran_no character varying(40) COLLATE public.nocase,
    doc_status character varying(20) COLLATE public.nocase,
    tax_status character varying(20) COLLATE public.nocase,
    cert_recd_status character varying(20) COLLATE public.nocase,
    dr_cr_flag character varying(20) COLLATE public.nocase,
    usage_id character varying(80) COLLATE public.nocase,
    trade_type character varying(20) COLLATE public.nocase,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    s_timestamp integer,
    receipt_type character varying(10) COLLATE public.nocase,
    threshold_flag character varying(30) COLLATE public.nocase,
    capital_flag character varying(80) COLLATE public.nocase,
    post_date timestamp without time zone,
    tcal_pdc_flag character varying(30) COLLATE public.nocase,
    supp_inv_no character varying(200) COLLATE public.nocase,
    supp_inv_date timestamp without time zone,
    supp_inv_amount numeric(25,2),
    nature_of_reason character varying(2000) COLLATE public.nocase,
    recon_sup_tax_inv_flag character varying(10) COLLATE public.nocase,
    aadhaar_no character varying(80) COLLATE public.nocase,
    pan_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tcaltranhdr ALTER COLUMN f_tcaltranhdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tcaltranhdr_f_tcaltranhdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_pkey PRIMARY KEY (f_tcaltranhdr_key);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_ukey UNIQUE (tran_no, tax_type, tran_type, tran_ou);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_company_key_fkey FOREIGN KEY (company_key) REFERENCES dwh.d_company(company_key);

CREATE INDEX f_tcaltranhdr_key_idx ON dwh.f_tcaltranhdr USING btree (tran_no, tax_type, tran_type, tran_ou);