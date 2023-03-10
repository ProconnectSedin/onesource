CREATE TABLE dwh.f_sidochdr (
    sidochdr_key bigint NOT NULL,
    sidochdr_vendor_key bigint NOT NULL,
    sidochdr_currency_key bigint NOT NULL,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(40) COLLATE public.nocase,
    s_timestamp integer,
    transfer_status character varying(50) COLLATE public.nocase,
    bankcashcode character varying(80) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    vat_incorporate_flag character varying(30) COLLATE public.nocase,
    tran_date timestamp without time zone,
    lo_id character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    supplier_code character varying(40) COLLATE public.nocase,
    pay_term character varying(30) COLLATE public.nocase,
    payterm_version integer,
    tran_amount numeric(25,2),
    exchange_rate numeric(25,2),
    base_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    par_base_amount numeric(25,2),
    doc_status character varying(50) COLLATE public.nocase,
    reversed_docno character varying(40) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    checkseries_no character varying(80) COLLATE public.nocase,
    check_no character varying(60) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    paid_status character varying(50) COLLATE public.nocase,
    vat_applicable character varying(10) COLLATE public.nocase,
    average_vat_rate numeric(25,2),
    discount_proportional character varying(10) COLLATE public.nocase,
    discount_amount numeric(25,2),
    discount_availed numeric(25,2),
    penalty_amount numeric(25,2),
    paid_amount numeric(25,2),
    requested_amount numeric(25,2),
    adjusted_amount numeric(25,2),
    supp_ou integer,
    reversed_docou integer,
    supp_name character varying(340) COLLATE public.nocase,
    supp_inv_no character varying(200) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    cap_amount numeric(25,2),
    supp_invoice_date timestamp without time zone,
    component_id character varying(40) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    pay_to_supp character varying(40) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    pay_priority character varying(80) COLLATE public.nocase,
    apply_sr character varying(10) COLLATE public.nocase,
    pay_method character varying(50) COLLATE public.nocase,
    pdcflag character varying(30) COLLATE public.nocase,
    report_flag character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sidochdr ALTER COLUMN sidochdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sidochdr_sidochdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_pkey PRIMARY KEY (sidochdr_key);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_ukey UNIQUE (tran_ou, tran_type, tran_no);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_sidochdr_currency_key_fkey FOREIGN KEY (sidochdr_currency_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_sidochdr_vendor_key_fkey FOREIGN KEY (sidochdr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_sidochdr_key_idx ON dwh.f_sidochdr USING btree (tran_ou, tran_type, tran_no);