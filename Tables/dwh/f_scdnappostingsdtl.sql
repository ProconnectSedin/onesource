CREATE TABLE dwh.f_scdnappostingsdtl (
    f_scdnappostingsdtl_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    posting_line_no integer,
    s_timestamp integer,
    line_no integer,
    company_code character varying(20) COLLATE public.nocase,
    posting_status character varying(10) COLLATE public.nocase,
    posting_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_type character varying(30) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    drcr_id character varying(10) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    exchange_rate numeric(13,2),
    base_amount numeric(13,2),
    par_exchange_rate numeric(13,2),
    par_base_amount numeric(13,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    guid character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    reftran_fbid character varying(40) COLLATE public.nocase,
    reftran_no character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(20) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    source_comp character varying(80) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_scdnappostingsdtl ALTER COLUMN f_scdnappostingsdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_scdnappostingsdtl_f_scdnappostingsdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_scdnappostingsdtl
    ADD CONSTRAINT f_scdnappostingsdtl_pkey PRIMARY KEY (f_scdnappostingsdtl_key);

ALTER TABLE ONLY dwh.f_scdnappostingsdtl
    ADD CONSTRAINT f_scdnappostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);

CREATE INDEX f_scdnappostingsdtl_key_idx ON dwh.f_scdnappostingsdtl USING btree (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);