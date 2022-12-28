CREATE TABLE stg.stg_wms_outbound_header_h (
    wms_oub_ou integer NOT NULL,
    wms_oub_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_prim_rf_dc_typ character varying(160) COLLATE public.nocase,
    wms_oub_prim_rf_dc_no character varying(72) COLLATE public.nocase,
    wms_oub_prim_rf_dc_date timestamp without time zone,
    wms_oub_orderdate timestamp without time zone,
    wms_oub_ob_status character varying(32) COLLATE public.nocase,
    wms_oub_order_type character varying(160) COLLATE public.nocase,
    wms_oub_order_priority character varying(160) COLLATE public.nocase,
    wms_oub_urgent_chk integer,
    wms_oub_cust_code character varying(72) COLLATE public.nocase,
    wms_oub_cust_type character varying(1020) COLLATE public.nocase,
    wms_oub_end_cust_ref_doc character varying(72) COLLATE public.nocase,
    wms_oub_address_id character varying(24) COLLATE public.nocase,
    wms_oub_ord_src character varying(200) COLLATE public.nocase,
    wms_oub_amendno integer NOT NULL,
    wms_oub_refdoctype character varying(32) COLLATE public.nocase,
    wms_oub_refdocno character varying(72) COLLATE public.nocase,
    wms_oub_refdocdate timestamp without time zone,
    wms_oub_secrefdoctype1 character varying(160) COLLATE public.nocase,
    wms_oub_secrefdoctype2 character varying(160) COLLATE public.nocase,
    wms_oub_secrefdoctype3 character varying(160) COLLATE public.nocase,
    wms_oub_secrefdocno1 character varying(72) COLLATE public.nocase,
    wms_oub_secrefdocno2 character varying(72) COLLATE public.nocase,
    wms_oub_secrefdocno3 character varying(72) COLLATE public.nocase,
    wms_oub_secrefdocdate1 timestamp without time zone,
    wms_oub_secrefdocdate2 timestamp without time zone,
    wms_oub_secrefdocdate3 timestamp without time zone,
    wms_oub_carriername character varying(160) COLLATE public.nocase,
    wms_oub_shipment_mode character varying(160) COLLATE public.nocase,
    wms_oub_shipment_type character varying(1020) COLLATE public.nocase,
    wms_oub_cnsgn_code_shpto character varying(72) COLLATE public.nocase,
    wms_oub_ship_point_id character varying(72) COLLATE public.nocase,
    wms_oub_address1 character varying(400) COLLATE public.nocase,
    wms_oub_address2 character varying(400) COLLATE public.nocase,
    wms_oub_address3 character varying(400) COLLATE public.nocase,
    wms_oub_unqaddress character varying(160) COLLATE public.nocase,
    wms_oub_postcode character varying(160) COLLATE public.nocase,
    wms_oub_country character varying(160) COLLATE public.nocase,
    wms_oub_state character varying(160) COLLATE public.nocase,
    wms_oub_city character varying(160) COLLATE public.nocase,
    wms_oub_phoneno character varying(80) COLLATE public.nocase,
    wms_oub_delivery_date timestamp without time zone,
    wms_oub_service_from timestamp without time zone,
    wms_oub_service_to timestamp without time zone,
    wms_oub_itm_plan_gd_iss_dt timestamp without time zone,
    wms_oub_itm_plan_dt_iss timestamp without time zone,
    wms_oub_instructions character varying(1020) COLLATE public.nocase,
    wms_oub_incoterms character varying(160) COLLATE public.nocase,
    wms_oub_inco_location character varying(40) COLLATE public.nocase,
    wms_oub_country_of_origin character varying(160) COLLATE public.nocase,
    wms_oub_port_of_shipment character varying(160) COLLATE public.nocase,
    wms_oub_destination_country character varying(160) COLLATE public.nocase,
    wms_oub_port_destination character varying(160) COLLATE public.nocase,
    wms_oub_created_by character varying(120) COLLATE public.nocase,
    wms_oub_created_date timestamp without time zone,
    wms_oub_modified_by character varying(120) COLLATE public.nocase,
    wms_oub_modified_date timestamp without time zone,
    wms_oub_timestamp integer,
    wms_oub_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_oub_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_oub_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_oub_operation_status character varying(32) COLLATE public.nocase,
    wms_oub_contract_id character varying(72) COLLATE public.nocase,
    wms_oub_contract_amend_no integer,
    wms_oub_subservice_type character varying(1020) COLLATE public.nocase,
    wms_oub_shp_name character varying(80) COLLATE public.nocase,
    wms_oub_shp_zone character varying(80) COLLATE public.nocase,
    wms_oub_shp_sub_zne character varying(80) COLLATE public.nocase,
    wms_oub_shp_region character varying(80) COLLATE public.nocase,
    wms_oub_pickup_from_date_time timestamp without time zone,
    wms_oub_pickup_to_date_time timestamp without time zone,
    wms_oub_transport_location character varying(40) COLLATE public.nocase,
    wms_oub_transport_service character varying(32) COLLATE public.nocase,
    wms_oub_bill_to_name character varying(240) COLLATE public.nocase,
    wms_oub_bill_det_addr_line1 character varying(400) COLLATE public.nocase,
    wms_oub_bill_det_addr_line2 character varying(400) COLLATE public.nocase,
    wms_oub_bill_det_post_code character varying(160) COLLATE public.nocase,
    wms_oub_bill_det_country character varying(160) COLLATE public.nocase,
    wms_oub_bill_det_city character varying(160) COLLATE public.nocase,
    wms_oub_bill_det_state character varying(160) COLLATE public.nocase,
    wms_oub_bill_det_phone character varying(80) COLLATE public.nocase,
    wms_oub_bill_det_ship_addr integer,
    wms_oub_bill_det_pay_gate_auth_no character varying(160) COLLATE public.nocase,
    wms_oub_bill_det_auth_date timestamp without time zone,
    wms_oub_bill_det_pay_sts character varying(1020) COLLATE public.nocase,
    wms_oub_cancel integer,
    wms_oub_cancel_code character varying(160) COLLATE public.nocase,
    wms_oub_reason_code character varying(160) COLLATE public.nocase,
    wms_oub_trippln_id character varying(72) COLLATE public.nocase,
    wms_oub_br_ou character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_wms_outbound_header_h_key_idx2 ON stg.stg_wms_outbound_header_h USING btree (wms_oub_ou, wms_oub_loc_code, wms_oub_outbound_ord, wms_oub_amendno);