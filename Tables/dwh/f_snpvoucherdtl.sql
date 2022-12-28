CREATE TABLE dwh.f_snpvoucherdtl (
    voucher_dtl_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    voucher_type character varying(10) COLLATE public.nocase,
    account_lineno integer,
    tran_type character varying(80) COLLATE public.nocase,
    vtimestamp integer,
    usage_id character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    amount numeric(13,2),
    drcr_flag character varying(10) COLLATE public.nocase,
    base_amount numeric(13,2),
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    receive_bank_cash_code character varying(80) COLLATE public.nocase,
    sur_receipt_no character varying(40) COLLATE public.nocase,
    dest_comp character varying(20) COLLATE public.nocase,
    destination_accode character varying(80) COLLATE public.nocase,
    destination_ou integer,
    destination_fb character varying(40) COLLATE public.nocase,
    destination_costcenter character varying(80) COLLATE public.nocase,
    destination_interfbjvno character varying(40) COLLATE public.nocase,
    accountcode_interfb character varying(80) COLLATE public.nocase,
    destaccount_currency character varying(10) COLLATE public.nocase,
    sur_ou integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_snpvoucherdtl ALTER COLUMN voucher_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_snpvoucherdtl_voucher_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_pkey PRIMARY KEY (voucher_dtl_key);

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_ukey UNIQUE (ou_id, voucher_no, voucher_type, account_lineno, tran_type, vtimestamp);

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_curr_key_fkey FOREIGN KEY (curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_snpvoucherdtl_key_idx ON dwh.f_snpvoucherdtl USING btree (curr_key);