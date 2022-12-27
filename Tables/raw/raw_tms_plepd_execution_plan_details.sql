CREATE TABLE raw.raw_tms_plepd_execution_plan_details (
    raw_id bigint NOT NULL,
    plepd_ouinstance integer NOT NULL,
    plepd_execution_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    plepd_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plepd_bk_id character varying(72) COLLATE public.nocase,
    plepd_bk_ref_route_id character varying(160) COLLATE public.nocase,
    plepd_leg_id character varying(160) COLLATE public.nocase,
    plepd_leg_behaviour_id character varying(60) COLLATE public.nocase,
    plepd_leg_seq_no integer,
    plepd_leg_status character varying(160) COLLATE public.nocase,
    plepd_planning_seq_no integer,
    plepd_leg_from character varying(160) COLLATE public.nocase,
    plepd_from_leg_geo_type character varying(160) COLLATE public.nocase,
    plepd_leg_from_postal_code character varying(160) COLLATE public.nocase,
    plepd_leg_from_subzone character varying(160) COLLATE public.nocase,
    plepd_leg_from_city character varying(160) COLLATE public.nocase,
    plepd_leg_from_zone character varying(160) COLLATE public.nocase,
    plepd_leg_from_state character varying(160) COLLATE public.nocase,
    plepd_leg_from_region character varying(160) COLLATE public.nocase,
    plepd_leg_from_country character varying(160) COLLATE public.nocase,
    plepd_leg_to character varying(160) COLLATE public.nocase,
    plepd_to_leg_geo_type character varying(160) COLLATE public.nocase,
    plepd_leg_to_postal_code character varying(160) COLLATE public.nocase,
    plepd_leg_to_subzone character varying(160) COLLATE public.nocase,
    plepd_leg_to_city character varying(160) COLLATE public.nocase,
    plepd_leg_to_zone character varying(160) COLLATE public.nocase,
    plepd_leg_to_state character varying(160) COLLATE public.nocase,
    plepd_leg_to_region character varying(160) COLLATE public.nocase,
    plepd_leg_to_country character varying(160) COLLATE public.nocase,
    plepd_leg_transport_mode character varying(160) COLLATE public.nocase,
    plepd_available_qty numeric,
    plepd_draft_qty numeric,
    plepd_confirmed_qty numeric,
    plepd_initiated_qty numeric,
    plepd_executed_qty numeric,
    plepd_qty_uom character varying(60) COLLATE public.nocase,
    plepd_available_vol numeric,
    plepd_draft_vol numeric,
    plepd_confirmed_vol numeric,
    plepd_executed_vol numeric,
    plepd_vol_uom character varying(60) COLLATE public.nocase,
    plepd_available_weight numeric,
    plepd_draft_weight numeric,
    plepd_confirmed_weight numeric,
    plepd_executed_weight numeric,
    plepd_weight_uom character varying(60) COLLATE public.nocase,
    plepd_created_by character varying(120) COLLATE public.nocase,
    plepd_created_date timestamp without time zone,
    plepd_last_modified_by character varying(120) COLLATE public.nocase,
    plepd_last_modified_date timestamp without time zone,
    plepd_timestamp integer,
    plepd_leg_to_suburb character varying(160) COLLATE public.nocase,
    plepd_leg_from_suburb character varying(160) COLLATE public.nocase,
    plepd_est_trip_cost character varying(160) COLLATE public.nocase,
    plepd_act_trip_cost character varying(160) COLLATE public.nocase,
    plepd_ofc_col_quantity numeric,
    plepd_updated_by character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_plepd_execution_plan_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_plepd_execution_plan_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_plepd_execution_plan_details
    ADD CONSTRAINT raw_tms_plepd_execution_plan_details_pkey PRIMARY KEY (raw_id);