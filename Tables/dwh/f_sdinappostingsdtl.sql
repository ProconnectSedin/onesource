CREATE TABLE dwh.f_sdinappostingsdtl (
    f_sdinappostingsdtl_key bigint NOT NULL,
    account_key bigint NOT NULL,
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
    tran_amount numeric(25,2),
    exchange_rate numeric(25,2),
    base_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    par_base_amount numeric(25,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    guid character varying(300) COLLATE public.nocase,
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    item_code character varying(80) COLLATE public.nocase,
    item_variant character varying(80) COLLATE public.nocase,
    quantity numeric(25,2),
    reftran_fbid character varying(40) COLLATE public.nocase,
    reftran_no character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(20) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    source_comp character varying(30) COLLATE public.nocase,
    hdrremarks character varying(512) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    roundoff_flag character varying(30) COLLATE public.nocase,
    item_tcd_type character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sdinappostingsdtl ALTER COLUMN f_sdinappostingsdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sdinappostingsdtl_f_sdinappostingsdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_pkey PRIMARY KEY (f_sdinappostingsdtl_key);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_account_key_fkey FOREIGN KEY (account_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

CREATE INDEX f_sdinappostingsdtl_key_idx ON dwh.f_sdinappostingsdtl USING btree (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);