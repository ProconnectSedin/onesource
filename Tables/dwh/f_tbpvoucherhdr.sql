CREATE TABLE dwh.f_tbpvoucherhdr (
    tbpvoucherhdr_key bigint NOT NULL,
    company_key bigint NOT NULL,
    current_key character varying(300) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fb_voucher_no character varying(40) COLLATE public.nocase,
    s_timestamp integer,
    tran_type character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fb_voucher_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tbpvoucherhdr ALTER COLUMN tbpvoucherhdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tbpvoucherhdr_tbpvoucherhdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_pkey PRIMARY KEY (tbpvoucherhdr_key);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_ukey UNIQUE (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_company_key_fkey FOREIGN KEY (company_key) REFERENCES dwh.d_company(company_key);

CREATE INDEX f_tbpvoucherhdr_key_idx ON dwh.f_tbpvoucherhdr USING btree (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);