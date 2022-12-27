CREATE TABLE dwh.f_rptacctinfodtl (
    rptacctinfodtl_key bigint NOT NULL,
    rptacctinfodtl_curr_key bigint NOT NULL,
    rptacctinfodtl_company_key bigint NOT NULL,
    rptacctinfodtl_opcoa_key bigint NOT NULL,
    rptacctinfodtl_datekey bigint NOT NULL,
    ou_id integer,
    tran_no character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    posting_line_no integer,
    fin_post_date timestamp without time zone,
    currency character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    tran_amount numeric(25,2),
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    basecur_erate numeric(25,2),
    base_amount numeric(25,2),
    par_base_amt numeric(25,2),
    batch_id character varying(300) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    company_id character varying(20) COLLATE public.nocase,
    component_id character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    source_comp character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_rptacctinfodtl ALTER COLUMN rptacctinfodtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_rptacctinfodtl_rptacctinfodtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_pkey PRIMARY KEY (rptacctinfodtl_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_ukey UNIQUE (ou_id, tran_no, fb_id, account_code, tran_type, drcr_flag, posting_line_no);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_company_key_fkey FOREIGN KEY (rptacctinfodtl_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_curr_key_fkey FOREIGN KEY (rptacctinfodtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_datekey_fkey FOREIGN KEY (rptacctinfodtl_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_opcoa_key_fkey FOREIGN KEY (rptacctinfodtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

CREATE INDEX f_rptacctinfodtl_key_idx ON dwh.f_rptacctinfodtl USING btree (ou_id, tran_no, fb_id, account_code, tran_type, drcr_flag, posting_line_no);

CREATE INDEX f_rptacctinfodtl_key_idx1 ON dwh.f_rptacctinfodtl USING btree (rptacctinfodtl_curr_key, rptacctinfodtl_company_key, rptacctinfodtl_datekey, rptacctinfodtl_opcoa_key);