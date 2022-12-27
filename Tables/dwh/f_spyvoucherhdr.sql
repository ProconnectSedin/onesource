CREATE TABLE dwh.f_spyvoucherhdr (
    spy_vcr_hdr_key bigint NOT NULL,
    ou_id integer,
    paybatch_no character varying(40) COLLATE public.nocase,
    voucher_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    voucher_amount numeric(20,2),
    vouch_amt_bef numeric(20,2),
    roundoff_amt numeric(20,2),
    pay_currency character varying(10) COLLATE public.nocase,
    payee character varying(40) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    bank_cash_code character varying(80) COLLATE public.nocase,
    priority character varying(30) COLLATE public.nocase,
    dd_charges character varying(20) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    rev_date timestamp without time zone,
    batch_id character varying(300) COLLATE public.nocase,
    supp_acct_in character varying(30) COLLATE public.nocase,
    supp_bank_ref character varying(80) COLLATE public.nocase,
    supp_acc_no character varying(80) COLLATE public.nocase,
    lsv_id character varying(40) COLLATE public.nocase,
    esr_line character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    line_no integer,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amt numeric(20,2),
    request_date timestamp without time zone,
    supplier_code character varying(40) COLLATE public.nocase,
    recon_reqflg character varying(30) COLLATE public.nocase,
    ict_flag character varying(30) COLLATE public.nocase,
    mail_sent character varying(50) COLLATE public.nocase,
    loan_fa character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_spyvoucherhdr ALTER COLUMN spy_vcr_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_spyvoucherhdr_spy_vcr_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_spyvoucherhdr
    ADD CONSTRAINT f_spyvoucherhdr_pkey PRIMARY KEY (spy_vcr_hdr_key);

ALTER TABLE ONLY dwh.f_spyvoucherhdr
    ADD CONSTRAINT f_spyvoucherhdr_ukey UNIQUE (ou_id, paybatch_no, voucher_no, "timestamp", line_no, ict_flag);

CREATE INDEX f_spyvoucherhdr_key_idx1 ON dwh.f_spyvoucherhdr USING btree (ou_id, paybatch_no, voucher_no, "timestamp", line_no, ict_flag);