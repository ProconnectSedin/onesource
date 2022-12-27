CREATE TABLE dwh.f_cdiarpostingsdtl (
    cdi_dtl_key bigint NOT NULL,
    company_key bigint NOT NULL,
    fb_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    itm_hdr_key bigint NOT NULL,
    uom_key bigint NOT NULL,
    customer_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    posting_line_no integer,
    mac_post_flag character varying(30) COLLATE public.nocase,
    vat_line_no integer,
    vatusageid integer,
    ctimestamp integer,
    line_no integer,
    company_code character varying(20) COLLATE public.nocase,
    posting_status character varying(10) COLLATE public.nocase,
    posting_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_type character varying(80) COLLATE public.nocase,
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
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    item_code character varying(80) COLLATE public.nocase,
    item_variant character varying(80) COLLATE public.nocase,
    quantity numeric(13,2),
    reftran_fbid character varying(40) COLLATE public.nocase,
    reftran_no character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    reftran_type character varying(20) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    cust_code character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    hdrremarks character varying(510) COLLATE public.nocase,
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

ALTER TABLE dwh.f_cdiarpostingsdtl ALTER COLUMN cdi_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cdiarpostingsdtl_cdi_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cdiarpostingsdtl
    ADD CONSTRAINT f_cdiarpostingsdtl_pkey PRIMARY KEY (cdi_dtl_key);

ALTER TABLE ONLY dwh.f_cdiarpostingsdtl
    ADD CONSTRAINT f_cdiarpostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, ctimestamp);

CREATE INDEX f_cdiarpostingsdtl_date_idx ON dwh.f_cdiarpostingsdtl USING btree (createddate, modifieddate, entry_date, auth_date, posting_date, tran_date);

CREATE INDEX f_cdiarpostingsdtl_key_idx ON dwh.f_cdiarpostingsdtl USING btree (company_key, fb_key, curr_key, itm_hdr_key, uom_key, customer_key);