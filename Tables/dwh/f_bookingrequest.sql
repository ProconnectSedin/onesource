CREATE TABLE dwh.f_bookingrequest (
    br_key bigint NOT NULL,
    br_loc_key bigint NOT NULL,
    br_curr_key bigint NOT NULL,
    br_rou_key bigint NOT NULL,
    br_customer_key bigint NOT NULL,
    br_ouinstance integer,
    br_request_id character varying(40) COLLATE public.nocase,
    br_customer_id character varying(40) COLLATE public.nocase,
    br_status character varying(80) COLLATE public.nocase,
    br_type character varying(80) COLLATE public.nocase,
    br_customer_ref_no character varying(510) COLLATE public.nocase,
    br_receiver_ref_no character varying(510) COLLATE public.nocase,
    br_payment_ref_no character varying(510) COLLATE public.nocase,
    br_service_type character varying(80) COLLATE public.nocase,
    br_sub_service_type character varying(80) COLLATE public.nocase,
    br_transport_mode character varying(50) COLLATE public.nocase,
    br_inco_terms character varying(80) COLLATE public.nocase,
    br_comments character varying(8000) COLLATE public.nocase,
    br_consigner_customer_same character varying(10) COLLATE public.nocase,
    br_timestamp integer,
    br_original_br_id character varying(40) COLLATE public.nocase,
    br_request_confirmation_date timestamp without time zone,
    br_validation_profile_id character varying(40) COLLATE public.nocase,
    br_contract_id character varying(40) COLLATE public.nocase,
    br_route_id character varying(40) COLLATE public.nocase,
    br_revenue numeric(20,2),
    br_error_code character varying(40) COLLATE public.nocase,
    br_priority character varying(80) COLLATE public.nocase,
    br_recurring_flag character varying(30) COLLATE public.nocase,
    br_customer_location character varying(80) COLLATE public.nocase,
    br_payment_type character varying(80) COLLATE public.nocase,
    br_customer_primary_phone character varying(80) COLLATE public.nocase,
    br_customer_email_id character varying(80) COLLATE public.nocase,
    br_sender_ref_no character varying(510) COLLATE public.nocase,
    br_create_as_template character varying(30) COLLATE public.nocase,
    br_creation_date timestamp without time zone,
    br_created_by character varying(60) COLLATE public.nocase,
    br_last_modified_date timestamp without time zone,
    br_last_modified_by character varying(60) COLLATE public.nocase,
    br_billing_status character varying(20) COLLATE public.nocase,
    br_requested_date timestamp without time zone,
    br_reason_code character varying(80) COLLATE public.nocase,
    br_remarks character varying(510) COLLATE public.nocase,
    br_contract_amend_no integer,
    br_hazardous character varying(10) COLLATE public.nocase,
    br_order_type character varying(250) COLLATE public.nocase,
    br_inslia_redington character varying(20) COLLATE public.nocase,
    br_shippers_inv_no character varying(510) COLLATE public.nocase,
    br_invoice_value numeric(20,2),
    br_currency character varying(80) COLLATE public.nocase,
    brrd_shippers_invoice_date timestamp without time zone,
    br_bill_to_id character varying(80) COLLATE public.nocase,
    br_creation_source character varying(80) COLLATE public.nocase,
    br_wf_guid character varying(300) COLLATE public.nocase,
    br_previous_status character varying(50) COLLATE public.nocase,
    br_status_prior_amend character varying(80) COLLATE public.nocase,
    br_declared_value numeric(20,2),
    br_insurance_value numeric(20,2),
    br_cod character varying(10) COLLATE public.nocase,
    br_cop character varying(10) COLLATE public.nocase,
    br_shipping_fee character varying(10) COLLATE public.nocase,
    br_collection_mode character varying(80) COLLATE public.nocase,
    br_include character varying(80) COLLATE public.nocase,
    br_reversal_jv_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_bookingrequest ALTER COLUMN br_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_bookingrequest_br_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_pkey PRIMARY KEY (br_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_ukey UNIQUE (br_ouinstance, br_request_id);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_curr_key_fkey FOREIGN KEY (br_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_customer_key_fkey FOREIGN KEY (br_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_loc_key_fkey FOREIGN KEY (br_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_rou_key_fkey FOREIGN KEY (br_rou_key) REFERENCES dwh.d_route(rou_key);

CREATE INDEX f_bookingrequest_key_idx ON dwh.f_bookingrequest USING btree (br_curr_key, br_rou_key, br_loc_key, br_customer_key);

CREATE INDEX f_bookingrequest_key_idx1 ON dwh.f_bookingrequest USING btree (br_ouinstance, br_request_id);