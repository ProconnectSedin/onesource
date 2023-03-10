CREATE TABLE dwh.f_cbadjadjvoucherhdr (
    adj_voucher_hdr_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    voucher_tran_type character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    voucher_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    voucher_amount numeric(20,2),
    status character varying(50) COLLATE public.nocase,
    cust_code character varying(40) COLLATE public.nocase,
    cust_hierarchy character varying(40) COLLATE public.nocase,
    adjust_seq character varying(30) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    voucher_type character varying(40) COLLATE public.nocase,
    rev_voucher_no character varying(40) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    notype_no character varying(20) COLLATE public.nocase,
    currentkey character varying(300) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amt numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cbadjadjvoucherhdr ALTER COLUMN adj_voucher_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cbadjadjvoucherhdr_adj_voucher_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cbadjadjvoucherhdr
    ADD CONSTRAINT f_cbadjadjvoucherhdr_pkey PRIMARY KEY (adj_voucher_hdr_key);

ALTER TABLE ONLY dwh.f_cbadjadjvoucherhdr
    ADD CONSTRAINT f_cbadjadjvoucherhdr_ukey UNIQUE (ou_id, adj_voucher_no, voucher_tran_type);