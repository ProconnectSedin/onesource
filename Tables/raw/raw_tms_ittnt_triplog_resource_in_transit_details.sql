CREATE TABLE raw.raw_tms_ittnt_triplog_resource_in_transit_details (
    raw_id bigint NOT NULL,
    in_transit_ouinstance character varying(72) NOT NULL COLLATE public.nocase,
    in_transit_line_no character varying(512) NOT NULL COLLATE public.nocase,
    in_transit_trip_log character varying(72) NOT NULL COLLATE public.nocase,
    in_transit_latitude character varying(1020) COLLATE public.nocase,
    in_transit_longitude character varying(1020) COLLATE public.nocase,
    in_transit_geo_info character varying(160) COLLATE public.nocase,
    in_transit_date_time timestamp without time zone,
    in_transit_created_by character varying(120) COLLATE public.nocase,
    in_transit_created_date timestamp without time zone,
    in_transit_modified_date timestamp without time zone,
    in_transit_modified_by character varying(120) COLLATE public.nocase,
    in_transit_timestamp integer,
    in_transit_event character varying(160) COLLATE public.nocase,
    in_transit_leg_no integer,
    in_transit_driverid character varying(160) COLLATE public.nocase,
    in_transit_vehicle_speed numeric,
    in_transit_vehicle_idle_time character varying(100) COLLATE public.nocase,
    in_transit_vehicle_eta_time character varying(100) COLLATE public.nocase,
    in_transit_odo_reading numeric,
    in_transit_advance_create_flag character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_ittnt_triplog_resource_in_transit_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_ittnt_triplog_resource_in_transit_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_ittnt_triplog_resource_in_transit_details
    ADD CONSTRAINT raw_tms_ittnt_triplog_resource_in_transit_details_pkey PRIMARY KEY (raw_id);