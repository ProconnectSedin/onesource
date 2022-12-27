CREATE TABLE dwh.f_surfbpostingsdtl (
    surf_dtl_key bigint NOT NULL,
    surf_trn_curr_key bigint NOT NULL,
    surf_trn_company_key bigint NOT NULL,
    ou_id integer,
    tran_type character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_no character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(10) COLLATE public.nocase,
    acct_lineno integer,
    "timestamp" integer,
    acct_type character varying(30) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tran_amount numeric(13,2),
    base_amount numeric(13,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    origin_ou integer,
    exchange_rate numeric(13,2),
    par_exchange_rate numeric(13,2),
    par_base_amount numeric(13,2),
    ref_tran_type character varying(80) COLLATE public.nocase,
    ref_fbid character varying(40) COLLATE public.nocase,
    auth_date timestamp without time zone,
    post_date timestamp without time zone,
    bu_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    flag character varying(10) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    receipt_type character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    source_comp character varying(60) COLLATE public.nocase,
    narration character varying(510) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    tran_lineno integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_surfbpostingsdtl ALTER COLUMN surf_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_surfbpostingsdtl_surf_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_pkey PRIMARY KEY (surf_dtl_key);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_ukey UNIQUE (ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno, "timestamp");

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_surf_trn_company_key_fkey FOREIGN KEY (surf_trn_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_surf_trn_curr_key_fkey FOREIGN KEY (surf_trn_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_surfbpostingsdtl_key_idx ON dwh.f_surfbpostingsdtl USING btree (surf_trn_curr_key, surf_trn_company_key);