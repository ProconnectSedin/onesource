CREATE TABLE raw.raw_tms_pltpo_trip_odo_details (
    raw_id bigint NOT NULL,
    plpto_ouinstance integer NOT NULL,
    plpto_guid character varying(512) NOT NULL COLLATE public.nocase,
    plpto_plan_run_no character varying(72) NOT NULL COLLATE public.nocase,
    plpto_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    plpto_trip_plan_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plpto_bk_req_id character varying(72) COLLATE public.nocase,
    plpto_bk_leg_no character varying(72) COLLATE public.nocase,
    plpto_odo_state character varying(160) COLLATE public.nocase,
    plpto_odo_reading numeric,
    plpto_odo_uom character varying(160) COLLATE public.nocase,
    plpto_created_by character varying(120) COLLATE public.nocase,
    plpto_created_date timestamp without time zone,
    plpto_last_modified_by character varying(120) COLLATE public.nocase,
    plpto_last_modified_date timestamp without time zone,
    plpto_timestamp integer,
    plpto_trip_plan_seq integer,
    plpto_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_pltpo_trip_odo_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_pltpo_trip_odo_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_pltpo_trip_odo_details
    ADD CONSTRAINT raw_tms_pltpo_trip_odo_details_pkey PRIMARY KEY (raw_id);