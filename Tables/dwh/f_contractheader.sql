CREATE TABLE dwh.f_contractheader (
    cont_hdr_key bigint NOT NULL,
    cont_id character varying(40) COLLATE public.nocase,
    cont_ou integer,
    cont_amendno integer,
    cont_desc character varying(510) COLLATE public.nocase,
    cont_date timestamp without time zone,
    cont_type character varying(20) COLLATE public.nocase,
    cont_status character varying(20) COLLATE public.nocase,
    cont_rsn_code character varying(80) COLLATE public.nocase,
    cont_service_type character varying(20) COLLATE public.nocase,
    cont_valid_from timestamp without time zone,
    cont_valid_to timestamp without time zone,
    cont_cust_contract_ref_no character varying(140) COLLATE public.nocase,
    cont_customer_id character varying(40) COLLATE public.nocase,
    cont_supp_contract_ref_no character varying(150) COLLATE public.nocase,
    cont_vendor_id character varying(40) COLLATE public.nocase,
    cont_ref_doc_type character varying(20) COLLATE public.nocase,
    cont_ref_doc_no character varying(40) COLLATE public.nocase,
    cont_bill_freq character varying(20) COLLATE public.nocase,
    cont_bill_date_day character varying(20) COLLATE public.nocase,
    cont_billing_stage character varying(20) COLLATE public.nocase,
    cont_currency character varying(20) COLLATE public.nocase,
    cont_exchange_rate numeric(20,2),
    cont_bulk_rate_chg_per numeric(20,2),
    cont_division character varying(20) COLLATE public.nocase,
    cont_location character varying(20) COLLATE public.nocase,
    cont_remarks character varying(510) COLLATE public.nocase,
    cont_slab_type character varying(20) COLLATE public.nocase,
    cont_timestamp integer,
    cont_created_by character varying(60) COLLATE public.nocase,
    cont_created_dt timestamp without time zone,
    cont_modified_by character varying(60) COLLATE public.nocase,
    cont_modified_dt timestamp without time zone,
    cont_space_last_bill_dt timestamp without time zone,
    cont_payment_type character varying(80) COLLATE public.nocase,
    cont_std_cont_portal integer,
    cont_prev_status character varying(20) COLLATE public.nocase,
    cont_cust_grp character varying(510) COLLATE public.nocase,
    cont_non_billable integer,
    non_billable_chk integer,
    cont_last_day character varying(20) COLLATE public.nocase,
    cont_div_loc_cust integer,
    cont_numbering_type character varying(20) COLLATE public.nocase,
    cont_wscchtsa_last_bil_date timestamp without time zone,
    cont_stapbspo_last_bil_date timestamp without time zone,
    cont_whrtchap_last_bil_date timestamp without time zone,
    cont_iata_chk character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    cont_vendor_key bigint,
    cont_location_key bigint,
    cont_customer_key bigint,
    cont_date_key bigint
);

ALTER TABLE dwh.f_contractheader ALTER COLUMN cont_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contractheader_cont_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contract_pkey PRIMARY KEY (cont_hdr_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contract_ukey UNIQUE (cont_id, cont_ou);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_customer_key_fkey FOREIGN KEY (cont_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_date_key_fkey FOREIGN KEY (cont_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_location_key_fkey FOREIGN KEY (cont_location_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_vendor_key_fkey FOREIGN KEY (cont_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_contractheader_key_idx ON dwh.f_contractheader USING btree (cont_id, cont_ou);

CREATE INDEX f_contractheader_ndx ON dwh.f_contractheader USING btree (cont_ou, cont_id, cont_vendor_id, cont_type);