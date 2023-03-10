CREATE TABLE dwh.f_cdiinvoicehdr (
    cdi_inv_hdr_key bigint NOT NULL,
    fb_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    ctimestamp integer,
    tran_status character varying(10) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    bill_to_cust character varying(40) COLLATE public.nocase,
    auto_adjust character varying(10) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(20,2),
    pay_term character varying(30) COLLATE public.nocase,
    payterm_version integer,
    receipt_method character varying(60) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    tran_amount numeric(20,2),
    receipt_type character varying(10) COLLATE public.nocase,
    sales_channel character varying(20) COLLATE public.nocase,
    sales_type character varying(10) COLLATE public.nocase,
    ship_to_cust character varying(40) COLLATE public.nocase,
    ship_to_id character varying(20) COLLATE public.nocase,
    item_amount numeric(20,2),
    gross_frt_amount numeric(20,2),
    net_frt_amount numeric(20,2),
    base_amount numeric(20,2),
    rev_doc_no character varying(40) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    disc_comp_basis character varying(10) COLLATE public.nocase,
    disc_proportional character varying(10) COLLATE public.nocase,
    vat_applicable character varying(10) COLLATE public.nocase,
    pre_round_off_amount numeric(20,2),
    rounded_off_amount numeric(20,2),
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amt numeric(20,2),
    total_tcal_amount numeric(20,2),
    bill_toid character varying(20) COLLATE public.nocase,
    draft_flag character varying(30) COLLATE public.nocase,
    cust_account_code character varying(80) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    autogen_flag character varying(30) COLLATE public.nocase,
    autogen_comp_id character varying(40) COLLATE public.nocase,
    prev_trnamt numeric(20,2),
    ict_flag character varying(30) COLLATE public.nocase,
    num_series character varying(80) COLLATE public.nocase,
    retamount numeric(20,2),
    holdamt numeric(20,2),
    lgt_invoice character varying(10) COLLATE public.nocase,
    trnsfr_bill_no character varying(40) COLLATE public.nocase,
    trnsfr_bill_date timestamp without time zone,
    trnsfr_bill_ou integer,
    mail_sent character varying(50) COLLATE public.nocase,
    own_taxregion character varying(20) COLLATE public.nocase,
    ot_cust_name character varying(80) COLLATE public.nocase,
    otc_flag character varying(30) COLLATE public.nocase,
    rpt_ou integer,
    cbadj_ou integer,
    auto_adjust_chk character varying(10) COLLATE public.nocase,
    receipt_currency character varying(10) COLLATE public.nocase,
    receipt_exchangerate numeric(20,2),
    receipt_instr_type character varying(50) COLLATE public.nocase,
    rpt_notype_no character varying(20) COLLATE public.nocase,
    rec_tran_type character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cdiinvoicehdr ALTER COLUMN cdi_inv_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cdiinvoicehdr_cdi_inv_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cdiinvoicehdr
    ADD CONSTRAINT f_cdiinvoicehdr_pkey PRIMARY KEY (cdi_inv_hdr_key);

ALTER TABLE ONLY dwh.f_cdiinvoicehdr
    ADD CONSTRAINT f_cdiinvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, ctimestamp, ict_flag, lgt_invoice, mail_sent);

CREATE INDEX f_cdiinvoicehdr_key_idx ON dwh.f_cdiinvoicehdr USING btree (fb_key, curr_key);