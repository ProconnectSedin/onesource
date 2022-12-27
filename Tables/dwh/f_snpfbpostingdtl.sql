CREATE TABLE dwh.f_snpfbpostingdtl (
    snfb_pos_key bigint NOT NULL,
    batch_id character varying(300) COLLATE public.nocase,
    ou_id integer,
    document_no character varying(40) COLLATE public.nocase,
    account_lineno integer,
    account_code character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(20) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_ou integer,
    tran_type character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    drcr_flag character varying(20) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    base_amount numeric(13,2),
    exchange_rate numeric(13,2),
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    mac_post_flag character varying(30) COLLATE public.nocase,
    acct_type character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    posting_flag character varying(30) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    tranline_no integer,
    reftran_no character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    reftran_type character varying(510) COLLATE public.nocase,
    reftran_fbid character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_snpfbpostingdtl ALTER COLUMN snfb_pos_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_snpfbpostingdtl_snfb_pos_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_snpfbpostingdtl
    ADD CONSTRAINT f_snpfbpostingdtl_pkey PRIMARY KEY (snfb_pos_key);

ALTER TABLE ONLY dwh.f_snpfbpostingdtl
    ADD CONSTRAINT f_snpfbpostingdtl_ukey UNIQUE (batch_id, ou_id, document_no, account_lineno, account_code, "timestamp");

CREATE INDEX f_snpfbpostingdtl_key_idx ON dwh.f_snpfbpostingdtl USING btree (batch_id, ou_id, document_no, account_lineno, account_code, "timestamp");