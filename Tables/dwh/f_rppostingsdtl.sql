CREATE TABLE dwh.f_rppostingsdtl (
    rppostingsdtl_key bigint NOT NULL,
    rppostingsdtl_curr_key bigint NOT NULL,
    rppostingsdtl_company_key bigint NOT NULL,
    rppostingsdtl_opcoa_key bigint NOT NULL,
    rppostingsdtl_datekey bigint NOT NULL,
    ou_id integer,
    serial_no integer,
    unique_no integer,
    doc_type character varying(80) COLLATE public.nocase,
    tran_ou integer,
    document_no character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    rtimestamp integer,
    fb_id character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    account_currcode character varying(10) COLLATE public.nocase,
    drcr_flag character varying(10) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    tran_amount numeric(25,2),
    base_amount numeric(25,2),
    exchange_rate numeric(25,2),
    par_base_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    auth_date timestamp without time zone,
    narration character varying(510) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    mac_post_flag character varying(30) COLLATE public.nocase,
    reftran_fbid character varying(40) COLLATE public.nocase,
    reftran_no character varying(40) COLLATE public.nocase,
    supcust_code character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(80) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    ctrlacctype character varying(30) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    pdc_void_flag character varying(30) COLLATE public.nocase,
    check_no character varying(60) COLLATE public.nocase,
    line_no integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_rppostingsdtl ALTER COLUMN rppostingsdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_rppostingsdtl_rppostingsdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_pkey PRIMARY KEY (rppostingsdtl_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_ukey UNIQUE (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_company_key_fkey FOREIGN KEY (rppostingsdtl_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_curr_key_fkey FOREIGN KEY (rppostingsdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_datekey_fkey FOREIGN KEY (rppostingsdtl_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_opcoa_key_fkey FOREIGN KEY (rppostingsdtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

CREATE INDEX f_rppostingsdtl_key_idx ON dwh.f_rppostingsdtl USING btree (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);

CREATE INDEX f_rppostingsdtl_key_idx1 ON dwh.f_rppostingsdtl USING btree (rppostingsdtl_curr_key, rppostingsdtl_company_key, rppostingsdtl_datekey, rppostingsdtl_opcoa_key);