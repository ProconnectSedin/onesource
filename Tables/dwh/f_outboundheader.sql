CREATE TABLE dwh.f_outboundheader (
    obh_hr_key bigint NOT NULL,
    obh_loc_key bigint NOT NULL,
    obh_cust_key bigint NOT NULL,
    oub_ou integer,
    oub_loc_code character varying(20) COLLATE public.nocase,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_prim_rf_dc_typ character varying(510) COLLATE public.nocase,
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
    oub_ord_src character varying(100) COLLATE public.nocase,
    oub_amendno integer,
    oub_refdoctype character varying(20) COLLATE public.nocase,
    oub_refdocno character varying(40) COLLATE public.nocase,
    oub_refdocdate timestamp without time zone,
    oub_carriername character varying(80) COLLATE public.nocase,
    oub_shipment_mode character varying(80) COLLATE public.nocase,
    oub_shipment_type character varying(510) COLLATE public.nocase,
    oub_cnsgn_code_shpto character varying(40) COLLATE public.nocase,
    oub_ship_point_id character varying(40) COLLATE public.nocase,
    oub_address1 character varying(200) COLLATE public.nocase,
    oub_address2 character varying(200) COLLATE public.nocase,
    oub_address3 character varying(200) COLLATE public.nocase,
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
    oub_created_by character varying(60) COLLATE public.nocase,
    oub_created_date timestamp without time zone,
    oub_modified_by character varying(60) COLLATE public.nocase,
    oub_modified_date timestamp without time zone,
    oub_timestamp integer,
    oub_operation_status character varying(20) COLLATE public.nocase,
    oub_contract_id character varying(40) COLLATE public.nocase,
    oub_contract_amend_no integer,
    oub_subservice_type character varying(510) COLLATE public.nocase,
    oub_shp_name character varying(40) COLLATE public.nocase,
    oub_shp_zone character varying(20) COLLATE public.nocase,
    oub_shp_sub_zne character varying(20) COLLATE public.nocase,
    oub_shp_region character varying(20) COLLATE public.nocase,
    oub_pickup_from_date_time timestamp without time zone,
    oub_pickup_to_date_time timestamp without time zone,
    oub_transport_location character varying(20) COLLATE public.nocase,
    oub_transport_service character varying(20) COLLATE public.nocase,
    oub_gen_req_id character varying(510) COLLATE public.nocase,
    oub_gen_from character varying(510) COLLATE public.nocase,
    oub_opfeboty_bil_status character varying(20) COLLATE public.nocase,
    oub_exp_stk integer,
    oub_consolidation_no character varying(80) COLLATE public.nocase,
    oub_bill_to_name character varying(120) COLLATE public.nocase,
    oub_bill_det_addr_line1 character varying(200) COLLATE public.nocase,
    oub_bill_det_addr_line2 character varying(200) COLLATE public.nocase,
    oub_bill_det_post_code character varying(80) COLLATE public.nocase,
    oub_bill_det_country character varying(80) COLLATE public.nocase,
    oub_bill_det_city character varying(80) COLLATE public.nocase,
    oub_bill_det_state character varying(80) COLLATE public.nocase,
    oub_bill_det_phone character varying(40) COLLATE public.nocase,
    oub_bill_det_ship_addr integer,
    oub_consgn_name character varying(300) COLLATE public.nocase,
    oub_cancel integer,
    oub_cancel_code character varying(80) COLLATE public.nocase,
    oub_prt_full_fill integer,
    oub_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    oub_orderdatekey bigint
);

ALTER TABLE dwh.f_outboundheader ALTER COLUMN obh_hr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundheader_obh_hr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_pkey PRIMARY KEY (obh_hr_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_ukey UNIQUE (oub_ou, oub_loc_code, oub_outbound_ord);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_obh_cust_key_fkey FOREIGN KEY (obh_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_obh_loc_key_fkey FOREIGN KEY (obh_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_oub_orderdatekey_fkey FOREIGN KEY (oub_orderdatekey) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_outboundheader_key_idx ON dwh.f_outboundheader USING btree (obh_cust_key, obh_loc_key);

CREATE INDEX f_outboundheader_key_idx1 ON dwh.f_outboundheader USING btree (oub_ou, oub_loc_code, oub_outbound_ord);

CREATE INDEX f_outboundheader_key_idx2 ON dwh.f_outboundheader USING btree (oub_ou, obh_loc_key, oub_prim_rf_dc_no);

CREATE INDEX f_outboundheader_key_idx3 ON dwh.f_outboundheader USING btree (obh_loc_key, obh_cust_key, oub_prim_rf_dc_no);

CREATE INDEX f_outboundheader_key_idx4 ON dwh.f_outboundheader USING btree (oub_prim_rf_dc_no, oub_ou);

CREATE INDEX f_outboundheader_key_idx_1 ON dwh.f_outboundheader USING btree (oub_orderdatekey);

CREATE INDEX f_outboundheader_key_idx_2 ON dwh.f_outboundheader USING btree (oub_modified_date, oub_created_date);

CREATE INDEX f_outboundheader_key_idx_5 ON dwh.f_outboundheader USING btree (oub_ou, oub_loc_code, oub_prim_rf_dc_no);

CREATE INDEX f_outboundheader_key_idx_7 ON dwh.f_outboundheader USING btree (oub_ou, oub_loc_code, oub_order_type, oub_shipment_type);