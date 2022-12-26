CREATE TABLE stg.stg_pro_tms_pltph_trip_plan_log (
    pro_ship_invno character varying(1020) COLLATE public.nocase,
    pro_ship_inv_date timestamp without time zone,
    pro_inv_value character varying(1020) COLLATE public.nocase,
    pro_inv_weight character varying(1020) COLLATE public.nocase,
    pro_consignee_name character varying(1020) COLLATE public.nocase,
    pro_consignee_address character varying(1020) COLLATE public.nocase,
    pro_consignee_pin_code character varying(1020) COLLATE public.nocase,
    pro_consignee_cont_no character varying(1020) COLLATE public.nocase,
    pro_dispatch_date timestamp without time zone,
    pro_dispatch_time timestamp without time zone,
    pro_dispatch_remarks character varying(1020) COLLATE public.nocase,
    pro_trip_sheet_date timestamp without time zone,
    pro_trip_sheet_time timestamp without time zone,
    pro_agent_desc character varying(1020) COLLATE public.nocase,
    pro_agent_docno character varying(1020) COLLATE public.nocase,
    pro_total_noof_thu character varying(1020) COLLATE public.nocase,
    pro_trip_sheet_no character varying(1020) COLLATE public.nocase,
    pro_vehicle_resource_type character varying(1020) COLLATE public.nocase,
    pro_vehicle_reg_no character varying(1020) COLLATE public.nocase,
    pro_driver_resource_id character varying(1020) COLLATE public.nocase,
    pro_trip_sheet_genby character varying(1020) COLLATE public.nocase,
    pro_location_id character varying(1020) COLLATE public.nocase,
    pro_customer_id character varying(1020) COLLATE public.nocase,
    pro_delivery_date timestamp without time zone,
    pro_delivery_time timestamp without time zone,
    pro_delivery_remarks character varying(1020) COLLATE public.nocase,
    pro_status character varying(1020) COLLATE public.nocase,
    pro_processflag character varying(48) COLLATE public.nocase,
    pro_process_guid character varying(512) COLLATE public.nocase,
    pro_plpth_processdate timestamp without time zone,
    pro_plpth_errorid character varying(48) COLLATE public.nocase,
    pro_plpth_errordesc character varying COLLATE public.nocase,
    pro_iris_processdate timestamp without time zone,
    pro_iris_processflag character varying(48) COLLATE public.nocase,
    pro_entrydate timestamp without time zone,
    docket_no character varying(1020) COLLATE public.nocase,
    process_start_date timestamp without time zone,
    legno integer,
    leg_beh character varying(1020) COLLATE public.nocase,
    br_service character varying(1020) COLLATE public.nocase,
    brid character varying(1020) COLLATE public.nocase,
    ou integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);