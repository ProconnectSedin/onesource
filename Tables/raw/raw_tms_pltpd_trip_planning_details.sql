CREATE TABLE raw.raw_tms_pltpd_trip_planning_details (
    raw_id bigint NOT NULL,
    plptd_ouinstance integer NOT NULL,
    plptd_plan_run_no character varying(72) NOT NULL COLLATE public.nocase,
    plptd_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    plptd_trip_plan_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plptd_trip_plan_seq integer,
    plptd_trip_plan_cutoftime character varying(160) COLLATE public.nocase,
    plptd_bk_req_id character varying(72) COLLATE public.nocase,
    plptd_bk_leg_no character varying(72) COLLATE public.nocase,
    plptd_leg_behaviour character varying(160) COLLATE public.nocase,
    plptd_thu_covered_qty numeric,
    plptd_thu_line_no character varying(512) COLLATE public.nocase,
    plptd_execution_plan character varying(72) COLLATE public.nocase,
    plptd_created_by character varying(120) COLLATE public.nocase,
    plptd_created_date timestamp without time zone,
    plptd_last_modified_by character varying(120) COLLATE public.nocase,
    plptd_last_modified_date timestamp without time zone,
    plptd_line_status character varying(160) COLLATE public.nocase,
    plptd_billing_status character varying(32) COLLATE public.nocase,
    plptd_event_id character varying(160) COLLATE public.nocase,
    plptd_distinct_leg_id character varying(512) COLLATE public.nocase,
    plptd_plan_source character varying(160) COLLATE public.nocase,
    plptd_odo_start numeric,
    plptd_odo_end numeric,
    plptd_odo_uom character varying(160) COLLATE public.nocase,
    plpth_start_time timestamp without time zone,
    plpth_end_time timestamp without time zone,
    pltpd_manage_flag character(4) COLLATE public.nocase,
    pltpd_rest_hours numeric,
    plptd_trip_plan_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    pltpd_from character varying(160) COLLATE public.nocase,
    pltpd_from_type character varying(160) COLLATE public.nocase,
    pltpd_to character varying(160) COLLATE public.nocase,
    pltpd_to_type character varying(160) COLLATE public.nocase,
    plptd_distance numeric,
    plptd_supplier_billing_status character varying(160) COLLATE public.nocase,
    plptd_rest_start timestamp without time zone,
    plptd_transfer_doc_no character varying(160) COLLATE public.nocase,
    pltpd_pl_bk_qty numeric,
    pltpd_pl_bk_wei numeric,
    pltpd_pl_bk_wei_uom character varying(160) COLLATE public.nocase,
    pltpd_act_bk_qty numeric,
    pltpd_act_bk_wei numeric,
    pltpd_act_bk_wei_uom character varying(160) COLLATE public.nocase,
    pltpd_cuml_pl_wei numeric,
    pltpd_cuml_pl_wei_uom character varying(160) COLLATE public.nocase,
    pltpd_cuml_act_wei numeric,
    pltpd_cuml_act_wei_uom character varying(160) COLLATE public.nocase,
    pltpd_bk_wise_seq integer,
    pltpd_backhaul_flag character(4) COLLATE public.nocase,
    pltpd_timestamp integer,
    plptd_backtohub_type character varying(160) COLLATE public.nocase,
    pltpd_loading_time numeric,
    plptd_transit_time numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);