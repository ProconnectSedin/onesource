CREATE TABLE stg.stg_tms_ddh_dispatch_document_hdr (
    ddh_ouinstance integer NOT NULL,
    ddh_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    ddh_dispatch_doc_type character varying(160) COLLATE public.nocase,
    ddh_dispatch_doc_mode character varying(160) COLLATE public.nocase,
    ddh_dispatch_doc_num_type character varying(160) COLLATE public.nocase,
    ddh_dispatch_doc_status character varying(160) COLLATE public.nocase,
    ddh_dispatch_doc_date timestamp without time zone,
    ddh_transport_mode character varying(160) COLLATE public.nocase,
    ddh_reference_doc_type character varying(160) COLLATE public.nocase,
    ddh_reference_doc_no character varying(72) COLLATE public.nocase,
    ddh_customer_id character varying(160) COLLATE public.nocase,
    ddh_cust_ref_no character varying(1020) COLLATE public.nocase,
    ddh_consignor_id character varying(160) COLLATE public.nocase,
    ddh_consignee_id character varying(160) COLLATE public.nocase,
    ddh_ship_from_id character varying(160) COLLATE public.nocase,
    ddh_ship_to_id character varying(160) COLLATE public.nocase,
    ddh_declared_goods_value numeric,
    ddh_currency character varying(160) COLLATE public.nocase,
    ddh_proforma character(4) COLLATE public.nocase,
    ddh_ship_agent_id character varying(160) COLLATE public.nocase,
    ddh_ship_agent_address_id character varying(160) COLLATE public.nocase,
    ddh_deliver_agent_id character varying(160) COLLATE public.nocase,
    ddh_deliver_agent_address_id character varying(160) COLLATE public.nocase,
    ddh_notify_party_id character varying(160) COLLATE public.nocase,
    ddh_notify_party_address_id character varying(160) COLLATE public.nocase,
    ddh_carrier_id character varying(160) COLLATE public.nocase,
    ddh_vessel_flight_rail_number character varying(160) COLLATE public.nocase,
    ddh_loading_or_departure_point character varying(160) COLLATE public.nocase,
    ddh_discharge_or_destination_point character varying(160) COLLATE public.nocase,
    ddh_arrival_date character varying(100) COLLATE public.nocase,
    ddh_departure_date character varying(100) COLLATE public.nocase,
    ddh_mbl_of_hbl character varying(160) COLLATE public.nocase,
    ddh_mawb_of_hawb character varying(160) COLLATE public.nocase,
    ddh_spl_instructions character varying(2000) COLLATE public.nocase,
    ddh_additional_info character varying(2000) COLLATE public.nocase,
    ddh_created_by character varying(120) COLLATE public.nocase,
    ddh_created_date timestamp without time zone,
    ddh_last_modified_by character varying(120) COLLATE public.nocase,
    ddh_lst_modified_date timestamp without time zone,
    ddh_timestamp integer,
    ddh_trip_log character varying(72) COLLATE public.nocase,
    ddh_location character varying(160) COLLATE public.nocase,
    ddh_billing_status character varying(32) COLLATE public.nocase,
    ddh_revenue numeric,
    ddh_autocreatecn_yn character(8) COLLATE public.nocase,
    ddh_pkup_recpt_no character varying(160) COLLATE public.nocase,
    ddh_dlvy_recpt_no character varying(160) COLLATE public.nocase,
    ddh_service_type character varying(160) COLLATE public.nocase,
    ddh_subservice_type character varying(160) COLLATE public.nocase,
    ddtd_pick_up_date_time_con timestamp without time zone,
    ddtd_delivery_date_time_con timestamp without time zone,
    ddh_agent character varying(160) COLLATE public.nocase,
    ddh_forwarding_agent character varying(1020) COLLATE public.nocase,
    ddh_cargo_description character varying(16000) COLLATE public.nocase,
    ddh_marks_numbers character varying(16000) COLLATE public.nocase,
    ddh_placeof_receipt character varying(160) COLLATE public.nocase,
    ddh_final_destination character varying(160) COLLATE public.nocase,
    ddh_net_weight numeric,
    ddh_gross_weight numeric,
    ddh_total_packages character varying(160) COLLATE public.nocase,
    ddh_chargeable_weight numeric,
    ddh_freight_charges character varying(160) COLLATE public.nocase,
    ddh_delivery_terms character varying(160) COLLATE public.nocase,
    ddh_guid character varying(512) COLLATE public.nocase,
    ddh_nature_quantity_goods character varying(16000) COLLATE public.nocase,
    ddh_agentiata_code character varying(160) COLLATE public.nocase,
    ddh_rate_class character varying(160) COLLATE public.nocase,
    ddh_commodityitemno character varying(160) COLLATE public.nocase,
    ddh_accounting_information character varying(1020) COLLATE public.nocase,
    ddh_declaredvalue_charge numeric,
    ddh_issuing_carrier_agentname character varying(160) COLLATE public.nocase,
    ddh_remarks character varying(1020) COLLATE public.nocase,
    ddh_handling_information character varying(1020) COLLATE public.nocase,
    ddh_declared_valuecustoms character varying(160) COLLATE public.nocase,
    ddh_amount_insurance character varying(160) COLLATE public.nocase,
    ddh_weight_uom character varying(160) COLLATE public.nocase,
    ddh_total_volume numeric,
    ddh_volume_uom character varying(160) COLLATE public.nocase,
    ddh_senders_ref_no character varying(72) COLLATE public.nocase,
    ddh_receivers_ref_no character varying(72) COLLATE public.nocase,
    ddh_amend_version_no integer,
    ddh_type_of_doc character varying(160) COLLATE public.nocase,
    ddh_registry_no character varying(1020) COLLATE public.nocase,
    ddh_cc_charges_destn_currency numeric,
    ddh_destination_currency character varying(72) COLLATE public.nocase,
    ddh_currency_conver_rate numeric,
    ddh_charges_code character varying(72) COLLATE public.nocase,
    ddh_reason_amendment character varying(160) COLLATE public.nocase,
    ddh_reason_description character varying(1020) COLLATE public.nocase,
    ddh_amendment_remarks character varying(10000) COLLATE public.nocase,
    ddh_other_charges character varying(160) COLLATE public.nocase,
    ddh_wtval_charges character varying(160) COLLATE public.nocase,
    ddh_dispatch_doc_dvry_status character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_ddh_dispatch_document_hdr
    ADD CONSTRAINT pk_tms_ddh_dispatch_document_hdr PRIMARY KEY (ddh_ouinstance, ddh_dispatch_doc_no);

CREATE INDEX stg_tms_ddh_dispatch_document_hdr_key_idx1 ON stg.stg_tms_ddh_dispatch_document_hdr USING btree (ddh_ouinstance, ddh_dispatch_doc_no);