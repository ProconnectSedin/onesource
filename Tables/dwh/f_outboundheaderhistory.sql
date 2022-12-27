CREATE TABLE dwh.f_outboundheaderhistory (
    obh_hr_his_key bigint NOT NULL,
    obh_loc_key bigint NOT NULL,
    obh_cust_key bigint NOT NULL,
    oub_orderdatekey bigint NOT NULL,
    oub_ou integer,
    oub_loc_code character varying(20) COLLATE public.nocase,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_prim_rf_dc_typ character varying(80) COLLATE public.nocase,
    oub_prim_rf_dc_no character varying(40) COLLATE public.nocase,
    oub_prim_rf_dc_date timestamp without time zone,
    oub_orderdate timestamp without time zone,
    oub_ob_status character varying(20) COLLATE public.nocase,
    oub_order_type character varying(80) COLLATE public.nocase,
    oub_order_priority character varying(80) COLLATE public.nocase,
    oub_urgent_chk integer,
    oub_cust_code character varying(40) COLLATE public.nocase,
    oub_cust_type character varying(510) COLLATE public.nocase,
    oub_end_cust_ref_doc character varying(40) COLLATE public.nocase,
    oub_address_id character varying(20) COLLATE public.nocase,
    oub_ord_src character varying(100) COLLATE public.nocase,
    oub_amendno integer,
    oub_refdoctype character varying(20) COLLATE public.nocase,
    oub_refdocno character varying(40) COLLATE public.nocase,
    oub_refdocdate timestamp without time zone,
    oub_secrefdoctype1 character varying(80) COLLATE public.nocase,
    oub_secrefdoctype2 character varying(80) COLLATE public.nocase,
    oub_secrefdoctype3 character varying(80) COLLATE public.nocase,
    oub_secrefdocno1 character varying(40) COLLATE public.nocase,
    oub_secrefdocno2 character varying(40) COLLATE public.nocase,
    oub_secrefdocno3 character varying(60) COLLATE public.nocase,
    oub_secrefdocdate1 timestamp without time zone,
    oub_secrefdocdate2 timestamp without time zone,
    oub_secrefdocdate3 timestamp without time zone,
    oub_carriername character varying(80) COLLATE public.nocase,
    oub_shipment_mode character varying(80) COLLATE public.nocase,
    oub_shipment_type character varying(510) COLLATE public.nocase,
    oub_cnsgn_code_shpto character varying(40) COLLATE public.nocase,
    oub_ship_point_id character varying(40) COLLATE public.nocase,
    oub_address1 character varying(200) COLLATE public.nocase,
    oub_address2 character varying(200) COLLATE public.nocase,
    oub_address3 character varying(200) COLLATE public.nocase,
    oub_unqaddress character varying(80) COLLATE public.nocase,
    oub_postcode character varying(80) COLLATE public.nocase,
    oub_country character varying(80) COLLATE public.nocase,
    oub_state character varying(80) COLLATE public.nocase,
    oub_city character varying(80) COLLATE public.nocase,
    oub_phoneno character varying(40) COLLATE public.nocase,
    oub_delivery_date timestamp without time zone,
    oub_service_from timestamp without time zone,
    oub_service_to timestamp without time zone,
    oub_itm_plan_gd_iss_dt timestamp without time zone,
    oub_itm_plan_dt_iss timestamp without time zone,
    oub_instructions character varying(510) COLLATE public.nocase,
    oub_incoterms character varying(80) COLLATE public.nocase,
    oub_inco_location character varying(20) COLLATE public.nocase,
    oub_country_of_origin character varying(80) COLLATE public.nocase,
    oub_port_of_shipment character varying(80) COLLATE public.nocase,
    oub_destination_country character varying(80) COLLATE public.nocase,
    oub_port_destination character varying(80) COLLATE public.nocase,
    oub_created_by character varying(60) COLLATE public.nocase,
    oub_created_date timestamp without time zone,
    oub_modified_by character varying(60) COLLATE public.nocase,
    oub_modified_date timestamp without time zone,
    oub_timestamp integer,
    oub_userdefined1 character varying(510) COLLATE public.nocase,
    oub_userdefined2 character varying(510) COLLATE public.nocase,
    oub_userdefined3 character varying(510) COLLATE public.nocase,
    oub_operation_status character varying(20) COLLATE public.nocase,
    oub_contract_id character varying(40) COLLATE public.nocase,
    oub_contract_amend_no integer,
    oub_subservice_type character varying(510) COLLATE public.nocase,
    oub_shp_name character varying(40) COLLATE public.nocase,
    oub_shp_zone character varying(40) COLLATE public.nocase,
    oub_shp_sub_zne character varying(40) COLLATE public.nocase,
    oub_shp_region character varying(40) COLLATE public.nocase,
    oub_pickup_from_date_time timestamp without time zone,
    oub_pickup_to_date_time timestamp without time zone,
    oub_transport_location character varying(20) COLLATE public.nocase,
    oub_transport_service character varying(20) COLLATE public.nocase,
    oub_bill_to_name character varying(120) COLLATE public.nocase,
    oub_bill_det_addr_line1 character varying(200) COLLATE public.nocase,
    oub_bill_det_addr_line2 character varying(200) COLLATE public.nocase,
    oub_bill_det_post_code character varying(80) COLLATE public.nocase,
    oub_bill_det_country character varying(80) COLLATE public.nocase,
    oub_bill_det_city character varying(80) COLLATE public.nocase,
    oub_bill_det_state character varying(80) COLLATE public.nocase,
    oub_bill_det_phone character varying(40) COLLATE public.nocase,
    oub_bill_det_ship_addr integer,
    oub_bill_det_pay_gate_auth_no character varying(80) COLLATE public.nocase,
    oub_bill_det_auth_date timestamp without time zone,
    oub_bill_det_pay_sts character varying(510) COLLATE public.nocase,
    oub_cancel integer,
    oub_cancel_code character varying(80) COLLATE public.nocase,
    oub_reason_code character varying(80) COLLATE public.nocase,
    oub_trippln_id character varying(36) COLLATE public.nocase,
    oub_br_ou character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outboundheaderhistory ALTER COLUMN obh_hr_his_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundheaderhistory_obh_hr_his_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_pkey PRIMARY KEY (obh_hr_his_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_ukey UNIQUE (oub_ou, oub_loc_code, oub_outbound_ord, oub_amendno);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_obh_cust_key_fkey FOREIGN KEY (obh_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_obh_loc_key_fkey FOREIGN KEY (obh_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_oub_orderdatekey_fkey FOREIGN KEY (oub_orderdatekey) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_outboundheaderhistory_key_idx1 ON dwh.f_outboundheaderhistory USING btree (oub_ou, oub_loc_code, oub_outbound_ord, oub_amendno);

CREATE INDEX f_outboundheaderhistory_key_idx2 ON dwh.f_outboundheaderhistory USING btree (obh_loc_key, obh_cust_key);

CREATE INDEX f_outboundheaderhistory_key_idx3 ON dwh.f_outboundheaderhistory USING btree (obh_hr_his_key);