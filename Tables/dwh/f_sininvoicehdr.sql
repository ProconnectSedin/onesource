CREATE TABLE dwh.f_sininvoicehdr (
    si_inv_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    tran_status character varying(50) COLLATE public.nocase,
    invoce_cat character varying(10) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    auto_adjust character varying(10) COLLATE public.nocase,
    auto_match character varying(10) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    pay_term character varying(30) COLLATE public.nocase,
    elec_pay character varying(10) COLLATE public.nocase,
    pay_method character varying(60) COLLATE public.nocase,
    pay_priority character varying(30) COLLATE public.nocase,
    payment_ou integer,
    pay_mode character varying(50) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    pay_to_supp character varying(40) COLLATE public.nocase,
    supp_invoice_no character varying(200) COLLATE public.nocase,
    supp_invoice_date timestamp without time zone,
    supp_invoice_amount numeric(25,2),
    comments character varying(512) COLLATE public.nocase,
    proposed_amount numeric(25,2),
    tran_amount numeric(25,2),
    item_amount numeric(25,2),
    tax_amount numeric(25,2),
    disc_amount numeric(25,2),
    base_amount numeric(25,2),
    rev_doc_no character varying(40) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    disc_comp_basis character varying(10) COLLATE public.nocase,
    discount_proportional character varying(10) COLLATE public.nocase,
    vat_applicable character varying(10) COLLATE public.nocase,
    pre_round_off_amount numeric(25,2),
    rounded_off_amount numeric(25,2),
    utilized_invtol_per numeric(25,2),
    unmatched_per numeric(25,2),
    forcemth_tolper_applied numeric(25,2),
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    total_tcal_amount numeric(25,2),
    tcal_exclusive_amt numeric(25,2),
    account_code character varying(80) COLLATE public.nocase,
    reconcilation_status character varying(50) COLLATE public.nocase,
    unmatched_amount numeric(25,2),
    workflow_status character varying(40) COLLATE public.nocase,
    prev_trnamt numeric(25,2),
    tms_flag character varying(10) COLLATE public.nocase,
    mail_sent character varying(50) COLLATE public.nocase,
    own_taxregion character varying(20) COLLATE public.nocase,
    autogen_flag character varying(30) COLLATE public.nocase,
    gen_from_mntfrght character varying(80) COLLATE public.nocase,
    variance_acct character varying(510) COLLATE public.nocase,
    hold_inv_pay character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sininvoicehdr ALTER COLUMN si_inv_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sininvoicehdr_si_inv_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sininvoicehdr
    ADD CONSTRAINT f_sininvoicehdr_pkey PRIMARY KEY (si_inv_key);

ALTER TABLE ONLY dwh.f_sininvoicehdr
    ADD CONSTRAINT f_sininvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, "timestamp", tms_flag, gen_from_mntfrght);

CREATE INDEX f_sininvoicehdr_key_idx ON dwh.f_sininvoicehdr USING btree (tran_type, tran_ou, tran_no, "timestamp", tms_flag, gen_from_mntfrght);