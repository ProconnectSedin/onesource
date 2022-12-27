CREATE TABLE dwh.f_surreceiptdtl (
    surreceiptdtl_key bigint NOT NULL,
    surreceiptdtl_curr_key bigint NOT NULL,
    surreceiptdtl_opcoa_key bigint NOT NULL,
    ou_id integer,
    receipt_type character varying(10) COLLATE public.nocase,
    receipt_no character varying(40) COLLATE public.nocase,
    refdoc_lineno integer,
    tran_type character varying(80) COLLATE public.nocase,
    stimestamp integer,
    usage character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    account_amount numeric(25,2),
    drcr_flag character varying(10) COLLATE public.nocase,
    base_amount numeric(25,2),
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    acct_type character varying(30) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    item_desc character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_surreceiptdtl ALTER COLUMN surreceiptdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_surreceiptdtl_surreceiptdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_pkey PRIMARY KEY (surreceiptdtl_key);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_ukey UNIQUE (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type, stimestamp);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_surreceiptdtl_curr_key_fkey FOREIGN KEY (surreceiptdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_surreceiptdtl_opcoa_key_fkey FOREIGN KEY (surreceiptdtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

CREATE INDEX f_surreceiptdtl_key_idx ON dwh.f_surreceiptdtl USING btree (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type, stimestamp);

CREATE INDEX f_surreceiptdtl_key_idx1 ON dwh.f_surreceiptdtl USING btree (surreceiptdtl_curr_key, surreceiptdtl_opcoa_key);