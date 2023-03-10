CREATE TABLE raw.raw_tms_plpd_planning_details (
    raw_id bigint NOT NULL,
    plpd_ouinstance integer NOT NULL,
    plpd_plan_run_no character varying(72) NOT NULL COLLATE public.nocase,
    plpd_doc_id character varying(72) COLLATE public.nocase,
    plpd_doc_type character varying(160) COLLATE public.nocase,
    plpd_from_location character varying(160) COLLATE public.nocase,
    plpd_to_location character varying(160) COLLATE public.nocase,
    plpd_leg_no character varying(72) COLLATE public.nocase,
    plpd_leg_behaviour character varying(160) COLLATE public.nocase,
    plpd_execution_plan character varying(72) COLLATE public.nocase,
    plpd_planning_sel_profile character varying(72) COLLATE public.nocase,
    plpd_planning_cutoftime character varying(160) COLLATE public.nocase,
    plpd_created_by character varying(120) COLLATE public.nocase,
    plpd_created_date timestamp without time zone,
    plpd_last_modified_by character varying(120) COLLATE public.nocase,
    plpd_last_modified_date timestamp without time zone,
    plpd_timestamp integer,
    plpd_failure_reason character varying(16000) COLLATE public.nocase,
    plpd_customercode character varying(160) COLLATE public.nocase,
    plpd_customer_name character varying(1020) COLLATE public.nocase,
    plpd_trip_id character varying(160) COLLATE public.nocase,
    plpd_trip_status character varying(160) COLLATE public.nocase,
    plpd_thu character varying(160) COLLATE public.nocase,
    plpd_qty numeric,
    plpd_balance_qty numeric,
    plpd_planned_qty numeric,
    plpd_ship_from_desc character varying(1020) COLLATE public.nocase,
    plpd_from_postcode character varying(160) COLLATE public.nocase,
    plpd_from_suburb character varying(160) COLLATE public.nocase,
    plpd_to_desc character varying(1020) COLLATE public.nocase,
    plpd_to_postcode character varying(160) COLLATE public.nocase,
    plpd_to_suburb character varying(160) COLLATE public.nocase,
    plpd_pickup_date timestamp without time zone,
    plpd_pickup_timeslot character varying(160) COLLATE public.nocase,
    plpd_delivery_date timestamp without time zone,
    plpd_delivery_timeslot character varying(160) COLLATE public.nocase,
    plpd_volume numeric,
    plpd_palletspace numeric,
    plpd_grossweight numeric,
    plpd_special_instruction character varying(1020) COLLATE public.nocase,
    plpd_plan_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_plpd_planning_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_plpd_planning_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_plpd_planning_details
    ADD CONSTRAINT raw_tms_plpd_planning_details_pkey PRIMARY KEY (raw_id);