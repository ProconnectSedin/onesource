CREATE TABLE dwh.f_sdininvoicehdr (
    sd_inv_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    s_timestamp integer,
    tran_status character varying(10) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    auto_adjust character varying(10) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    pay_term character varying(30) COLLATE public.nocase,
    payterm_version integer,
    elec_pay character varying(10) COLLATE public.nocase,
    pay_method character varying(60) COLLATE public.nocase,
    pay_to_supp character varying(40) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    pay_priority character varying(30) COLLATE public.nocase,
    payment_ou integer,
    supp_code character varying(40) COLLATE public.nocase,
    supp_invoice_no character varying(200) COLLATE public.nocase,
    supp_invoice_date timestamp without time zone,
    supp_invoice_amount numeric(25,2),
    supp_ou integer,
    comments character varying(512) COLLATE public.nocase,
    tran_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    item_amount numeric(25,2),
    base_amount numeric(25,2),
    par_base_amount numeric(25,2),
    rev_doc_no character varying(40) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    hld_reason_code character varying(20) COLLATE public.nocase,
    hld_remarks character varying(200) COLLATE public.nocase,
    auth_date timestamp without time zone,
    disc_comp_basis character varying(10) COLLATE public.nocase,
    discount_proportional character varying(10) COLLATE public.nocase,
    cap_non_ded_charge character varying(10) COLLATE public.nocase,
    pre_round_off_amount numeric(25,2),
    rounded_off_amount numeric(25,2),
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    total_tcal_amount numeric(25,2),
    tcal_exclusive_amt numeric(25,2),
    account_code character varying(80) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    autogen_flag character varying(30) COLLATE public.nocase,
    autogen_comp_id character varying(40) COLLATE public.nocase,
    prev_trnamt numeric(25,2),
    afe_number character varying(40) COLLATE public.nocase,
    cash_code character varying(80) COLLATE public.nocase,
    payment_type character varying(20) COLLATE public.nocase,
    corr_roff numeric(25,2),
    dervied_roff numeric(25,2),
    ict_flag character varying(30) COLLATE public.nocase,
    num_series character varying(80) COLLATE public.nocase,
    ales_flag character varying(30) COLLATE public.nocase,
    supplieraddress character varying(40) COLLATE public.nocase,
    lgt_invoice character varying(10) COLLATE public.nocase,
    trnsfr_bill_date timestamp without time zone,
    rcti_flag integer,
    mail_sent character varying(50) COLLATE public.nocase,
    own_taxregion character varying(20) COLLATE public.nocase,
    allow_auto_cap character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sdininvoicehdr ALTER COLUMN sd_inv_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sdininvoicehdr_sd_inv_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sdininvoicehdr
    ADD CONSTRAINT f_sdininvoicehdr_pkey PRIMARY KEY (sd_inv_key);

ALTER TABLE ONLY dwh.f_sdininvoicehdr
    ADD CONSTRAINT f_sdininvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, s_timestamp, payment_type, ict_flag, ales_flag, lgt_invoice, mail_sent, allow_auto_cap);

CREATE INDEX f_sdininvoicehdr_key_idx ON dwh.f_sdininvoicehdr USING btree (tran_type, tran_ou, tran_no, s_timestamp, payment_type, ict_flag, ales_flag, lgt_invoice, mail_sent, allow_auto_cap);