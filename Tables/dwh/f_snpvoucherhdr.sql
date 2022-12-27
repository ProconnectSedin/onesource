CREATE TABLE dwh.f_snpvoucherhdr (
    voucher_hdr_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    voucher_type character varying(10) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    vtimestamp integer,
    fb_id character varying(40) COLLATE public.nocase,
    notype_no character varying(20) COLLATE public.nocase,
    request_date timestamp without time zone,
    payee_name character varying(340) COLLATE public.nocase,
    pay_date timestamp without time zone,
    elec_payment character varying(10) COLLATE public.nocase,
    pay_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(20,2),
    pay_amount_bef_roff numeric(20,2),
    pay_amount numeric(20,2),
    roundoff_amount numeric(20,2),
    pay_method character varying(60) COLLATE public.nocase,
    payment_route character varying(10) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    bank_cash_code character varying(80) COLLATE public.nocase,
    relpay_ou integer,
    instr_charge character varying(10) COLLATE public.nocase,
    priority character varying(10) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    hr_reason_code character varying(20) COLLATE public.nocase,
    reversal_reason_code character varying(20) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    reversal_remarks character varying(510) COLLATE public.nocase,
    address1 character varying(80) COLLATE public.nocase,
    city character varying(80) COLLATE public.nocase,
    state character varying(80) COLLATE public.nocase,
    country character varying(80) COLLATE public.nocase,
    zip_code character varying(40) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    voucher_status character varying(10) COLLATE public.nocase,
    refdoc_no character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    total_tcal_amount numeric(20,2),
    tcal_exclusive_amt numeric(20,2),
    receipt_route character varying(10) COLLATE public.nocase,
    auto_gen_flag character varying(30) COLLATE public.nocase,
    receipt_ou integer,
    workflow_status character varying(40) COLLATE public.nocase,
    recon_reqflg character varying(30) COLLATE public.nocase,
    ifb_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_snpvoucherhdr ALTER COLUMN voucher_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_snpvoucherhdr_voucher_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_snpvoucherhdr
    ADD CONSTRAINT f_snpvoucherhdr_pkey PRIMARY KEY (voucher_hdr_key);

ALTER TABLE ONLY dwh.f_snpvoucherhdr
    ADD CONSTRAINT f_snpvoucherhdr_ukey UNIQUE (ou_id, voucher_no, voucher_type, tran_type, vtimestamp, ifb_flag);

CREATE INDEX f_snpvoucherhdr_key_idx ON dwh.f_snpvoucherhdr USING btree (curr_key);