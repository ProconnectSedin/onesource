CREATE TABLE dwh.f_fbpvoucherdtl (
    fbp_dtl_key bigint NOT NULL,
    fbp_company_key bigint NOT NULL,
    parent_key character varying(300) COLLATE public.nocase,
    current_key character varying(300) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    fb_voucher_no character varying(40) COLLATE public.nocase,
    serial_no integer,
    "timestamp" integer,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_fbpvoucherdtl ALTER COLUMN fbp_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_fbpvoucherdtl_fbp_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_pkey PRIMARY KEY (fbp_dtl_key);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_ukey UNIQUE (parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_fbp_company_key_fkey FOREIGN KEY (fbp_company_key) REFERENCES dwh.d_company(company_key);

CREATE INDEX f_fbpvoucherdtl_key_idx ON dwh.f_fbpvoucherdtl USING btree (fbp_company_key);