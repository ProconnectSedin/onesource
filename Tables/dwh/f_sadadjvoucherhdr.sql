CREATE TABLE dwh.f_sadadjvoucherhdr (
    sadadjvoucherhdr_key bigint NOT NULL,
    sadadjvoucherhdr_curr_key bigint NOT NULL,
    sadadjvoucherhdr_vendor_key bigint NOT NULL,
    ou_id integer,
    adj_voucher_no character varying(40) COLLATE public.nocase,
    stimestamp integer,
    voucher_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    voucher_amount numeric(25,2),
    status character varying(50) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    adjust_seq character varying(30) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    voucher_type character varying(40) COLLATE public.nocase,
    rev_voucher_no character varying(40) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    notype_no character varying(20) COLLATE public.nocase,
    currentkey character varying(300) COLLATE public.nocase,
    voucher_tran_type character varying(80) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_exclusive_amt numeric(25,2),
    tcal_status character varying(30) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    autogen_flag character varying(30) COLLATE public.nocase,
    voucher_remarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sadadjvoucherhdr ALTER COLUMN sadadjvoucherhdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sadadjvoucherhdr_sadadjvoucherhdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_pkey PRIMARY KEY (sadadjvoucherhdr_key);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_ukey UNIQUE (ou_id, adj_voucher_no, stimestamp);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_sadadjvoucherhdr_curr_key_fkey FOREIGN KEY (sadadjvoucherhdr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_sadadjvoucherhdr_vendor_key_fkey FOREIGN KEY (sadadjvoucherhdr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_sadadjvoucherhdr_key_idx ON dwh.f_sadadjvoucherhdr USING btree (ou_id, adj_voucher_no, stimestamp);

CREATE INDEX f_sadadjvoucherhdr_key_idx1 ON dwh.f_sadadjvoucherhdr USING btree (sadadjvoucherhdr_curr_key, sadadjvoucherhdr_vendor_key);