CREATE TABLE dwh.f_dispatchdocheader (
    ddh_key bigint NOT NULL,
    ddh_customer_key bigint NOT NULL,
    ddh_consignee_hdr_key bigint NOT NULL,
    ddh_curr_key bigint NOT NULL,
    ddh_loc_key bigint NOT NULL,
    ddh_ouinstance integer,
    ddh_dispatch_doc_no character varying(40) COLLATE public.nocase,
    ddh_dispatch_doc_type character varying(80) COLLATE public.nocase,
    ddh_dispatch_doc_mode character varying(80) COLLATE public.nocase,
    ddh_dispatch_doc_num_type character varying(80) COLLATE public.nocase,
    ddh_dispatch_doc_status character varying(80) COLLATE public.nocase,
    ddh_dispatch_doc_date timestamp without time zone,
    ddh_transport_mode character varying(80) COLLATE public.nocase,
    ddh_reference_doc_type character varying(80) COLLATE public.nocase,
    ddh_reference_doc_no character varying(40) COLLATE public.nocase,
    ddh_customer_id character varying(80) COLLATE public.nocase,
    ddh_cust_ref_no character varying(510) COLLATE public.nocase,
    ddh_consignee_id character varying(80) COLLATE public.nocase,
    ddh_ship_from_id character varying(80) COLLATE public.nocase,
    ddh_ship_to_id character varying(80) COLLATE public.nocase,
    ddh_declared_goods_value numeric(25,2),
    ddh_currency character varying(80) COLLATE public.nocase,
    ddh_spl_instructions character varying(1000) COLLATE public.nocase,
    ddh_created_by character varying(60) COLLATE public.nocase,
    ddh_created_date timestamp without time zone,
    ddh_last_modified_by character varying(60) COLLATE public.nocase,
    ddh_lst_modified_date timestamp without time zone,
    ddh_trip_log character varying(40) COLLATE public.nocase,
    ddh_location character varying(80) COLLATE public.nocase,
    ddh_billing_status character varying(20) COLLATE public.nocase,
    ddh_autocreatecn_yn character varying(10) COLLATE public.nocase,
    ddh_pkup_recpt_no character varying(80) COLLATE public.nocase,
    ddh_service_type character varying(80) COLLATE public.nocase,
    ddh_subservice_type character varying(80) COLLATE public.nocase,
    ddtd_pick_up_date_time_con timestamp without time zone,
    ddtd_delivery_date_time_con timestamp without time zone,
    ddh_placeof_receipt character varying(80) COLLATE public.nocase,
    ddh_final_destination character varying(80) COLLATE public.nocase,
    ddh_net_weight numeric(25,2),
    ddh_gross_weight numeric(25,2),
    ddh_total_packages character varying(80) COLLATE public.nocase,
    ddh_chargeable_weight numeric(25,2),
    ddh_guid character varying(300) COLLATE public.nocase,
    ddh_weight_uom character varying(80) COLLATE public.nocase,
    ddh_total_volume numeric(25,2),
    ddh_volume_uom character varying(80) COLLATE public.nocase,
    ddh_senders_ref_no character varying(40) COLLATE public.nocase,
    ddh_receivers_ref_no character varying(40) COLLATE public.nocase,
    ddh_amend_version_no integer,
    ddh_reason_amendment character varying(80) COLLATE public.nocase,
    ddh_dispatch_doc_dvry_status character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocheader ALTER COLUMN ddh_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocheader_ddh_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_pkey PRIMARY KEY (ddh_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_consignee_hdr_key_fkey FOREIGN KEY (ddh_consignee_hdr_key) REFERENCES dwh.d_consignee(consignee_hdr_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_curr_key_fkey FOREIGN KEY (ddh_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_customer_key_fkey FOREIGN KEY (ddh_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_loc_key_fkey FOREIGN KEY (ddh_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_dispatchdocheader_key_idx ON dwh.f_dispatchdocheader USING btree (ddh_customer_key, ddh_consignee_hdr_key, ddh_curr_key, ddh_loc_key);

CREATE INDEX f_dispatchdocheader_key_idx1 ON dwh.f_dispatchdocheader USING btree (ddh_ouinstance, ddh_dispatch_doc_no);

CREATE INDEX f_dispatchdocheader_key_ndx ON dwh.f_dispatchdocheader USING btree (ddh_ouinstance, ddh_reference_doc_no);