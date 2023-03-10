CREATE TABLE dwh.f_spyprepayvchhdr (
    prepay_vch_hdr_key bigint NOT NULL,
    vendor_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    ptimestamp integer,
    voucher_type character varying(80) COLLATE public.nocase,
    request_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    payment_route character varying(20) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    priority character varying(30) COLLATE public.nocase,
    pay_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(20,2),
    dd_charges character varying(20) COLLATE public.nocase,
    pay_amount numeric(20,2),
    pay_amt_bef_round numeric(20,2),
    roundoff_amt numeric(20,2),
    pay_date timestamp without time zone,
    bank_cash_code character varying(80) COLLATE public.nocase,
    relpay_ou character varying(40) COLLATE public.nocase,
    reason_code character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    rev_date timestamp without time zone,
    notype_no character varying(20) COLLATE public.nocase,
    supp_area character varying(40) COLLATE public.nocase,
    supp_doc_no character varying(200) COLLATE public.nocase,
    supp_doc_date timestamp without time zone,
    supp_doc_amt numeric(20,2),
    supp_prepay_acct character varying(80) COLLATE public.nocase,
    bank_cash_acct character varying(80) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_exclusive_amt numeric(20,2),
    tcal_status character varying(30) COLLATE public.nocase,
    voucher_amount numeric(20,2),
    ibe_flag character varying(30) COLLATE public.nocase,
    workflow_status character varying(40) COLLATE public.nocase,
    tr_flag character varying(10) COLLATE public.nocase,
    surnotype_no character varying(20) COLLATE public.nocase,
    bank_amount numeric(20,2),
    lgt_invoice_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_spyprepayvchhdr ALTER COLUMN prepay_vch_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_spyprepayvchhdr_prepay_vch_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_spyprepayvchhdr
    ADD CONSTRAINT f_spyprepayvchhdr_pkey PRIMARY KEY (prepay_vch_hdr_key);

ALTER TABLE ONLY dwh.f_spyprepayvchhdr
    ADD CONSTRAINT f_spyprepayvchhdr_ukey UNIQUE (ou_id, voucher_no, tran_type, ptimestamp, lgt_invoice_flag);

CREATE INDEX f_spyprepayvchhdr_key_idx ON dwh.f_spyprepayvchhdr USING btree (vendor_key, curr_key);