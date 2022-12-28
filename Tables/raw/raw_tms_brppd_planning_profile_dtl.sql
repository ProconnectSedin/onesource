CREATE TABLE raw.raw_tms_brppd_planning_profile_dtl (
    raw_id bigint NOT NULL,
    brppd_ouinstance integer NOT NULL,
    brppd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    brppd_br_id character varying(160) NOT NULL COLLATE public.nocase,
    brppd_direct_entry character(4) COLLATE public.nocase,
    brppd_auto_entry character(4) COLLATE public.nocase,
    brppd_created_by character varying(120) COLLATE public.nocase,
    brppd_created_date timestamp without time zone,
    brppd_priority integer,
    brppd_param_priority character varying(160) COLLATE public.nocase,
    brppd_customer_id character varying(160) COLLATE public.nocase,
    brppd_customer_name character varying(1020) COLLATE public.nocase,
    brppd_execution_plan character varying(160) COLLATE public.nocase,
    brppd_ship_from_id character varying(160) COLLATE public.nocase,
    brppd_ship_from_desc character varying(1020) COLLATE public.nocase,
    brppd_ship_from_postal character varying(160) COLLATE public.nocase,
    brppd_ship_from_suburb character varying(160) COLLATE public.nocase,
    brppd_ship_to_id character varying(160) COLLATE public.nocase,
    brppd_ship_to_desc character varying(1020) COLLATE public.nocase,
    brppd_ship_to_postal character varying(160) COLLATE public.nocase,
    brppd_ship_to_suburb character varying(160) COLLATE public.nocase,
    brppd_pickup_date timestamp without time zone,
    brppd_pickup_timeslot character varying(160) COLLATE public.nocase,
    brppd_delivery_date timestamp without time zone,
    brppd_delivery_timeslot character varying(160) COLLATE public.nocase,
    brppd_booking_request_qty numeric,
    brppd_booking_request_vol numeric,
    brppd_booking_request_wei numeric,
    brppd_booking_request_pallet integer,
    brppd_cutoff_time_pick character varying(160) COLLATE public.nocase,
    brppd_cutoff_time_delivery character varying(160) COLLATE public.nocase,
    brppd_last_modified_by character varying(120) COLLATE public.nocase,
    brppd_last_modified_date timestamp without time zone,
    brppd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_brppd_planning_profile_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_brppd_planning_profile_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_brppd_planning_profile_dtl
    ADD CONSTRAINT raw_tms_brppd_planning_profile_dtl_pkey PRIMARY KEY (raw_id);