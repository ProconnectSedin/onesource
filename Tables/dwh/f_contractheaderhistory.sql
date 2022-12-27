CREATE TABLE dwh.f_contractheaderhistory (
    cont_hdr_hst_key bigint NOT NULL,
    cont_hdr_hst_vendor_key bigint,
    cont_hdr_hst_loc_key bigint,
    cont_hdr_hst_customer_key bigint,
    cont_hdr_hst_datekey bigint,
    cont_hdr_hst_curr_key bigint,
    cont_id character varying(40) COLLATE public.nocase,
    cont_ou integer,
    cont_amendno integer,
    cont_desc character varying(510) COLLATE public.nocase,
    cont_date timestamp without time zone,
    cont_type character varying(20) COLLATE public.nocase,
    cont_status character varying(20) COLLATE public.nocase,
    cont_rsn_code character varying(80) COLLATE public.nocase,
    cont_service_type character varying(80) COLLATE public.nocase,
    cont_valid_from timestamp without time zone,
    cont_valid_to timestamp without time zone,
    cont_cust_contract_ref_no character varying(140) COLLATE public.nocase,
    cont_customer_id character varying(40) COLLATE public.nocase,
    cont_supp_contract_ref_no character varying(140) COLLATE public.nocase,
    cont_vendor_id character varying(40) COLLATE public.nocase,
    cont_ref_doc_type character varying(20) COLLATE public.nocase,
    cont_ref_doc_no character varying(40) COLLATE public.nocase,
    cont_bill_freq character varying(20) COLLATE public.nocase,
    cont_bill_date_day character varying(20) COLLATE public.nocase,
    cont_billing_stage character varying(20) COLLATE public.nocase,
    cont_currency character varying(20) COLLATE public.nocase,
    cont_exchange_rate numeric(25,2),
    cont_bulk_rate_chg_per numeric(25,2),
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
    cont_vendor_group character varying(80) COLLATE public.nocase,
    cont_cust_grp character varying(510) COLLATE public.nocase,
    cont_lag_time numeric(25,2),
    cont_lag_time_uom character varying(20) COLLATE public.nocase,
    cont_non_billable integer,
    non_billable_chk integer,
    cont_last_day character varying(20) COLLATE public.nocase,
    cont_div_loc_cust integer,
    cont_numbering_type character varying(20) COLLATE public.nocase,
    cont_workflow_status character varying(510) COLLATE public.nocase,
    cont_reason_for_return character varying(510) COLLATE public.nocase,
    min_weight numeric(25,2),
    volm_conversion numeric(25,2),
    cont_plan_difot character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contractheaderhistory ALTER COLUMN cont_hdr_hst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contractheaderhistory_cont_hdr_hst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_pkey PRIMARY KEY (cont_hdr_hst_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_ukey UNIQUE (cont_id, cont_ou, cont_amendno);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_curr_key_fkey FOREIGN KEY (cont_hdr_hst_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_customer_key_fkey FOREIGN KEY (cont_hdr_hst_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_datekey_fkey FOREIGN KEY (cont_hdr_hst_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_loc_key_fkey FOREIGN KEY (cont_hdr_hst_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_vendor_key_fkey FOREIGN KEY (cont_hdr_hst_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_contractheaderhistory_key_idx ON dwh.f_contractheaderhistory USING btree (cont_id, cont_ou, cont_amendno);

CREATE INDEX f_contractheaderhistory_key_idx1 ON dwh.f_contractheaderhistory USING btree (cont_hdr_hst_customer_key, cont_hdr_hst_datekey, cont_hdr_hst_loc_key, cont_hdr_hst_vendor_key, cont_hdr_hst_curr_key);