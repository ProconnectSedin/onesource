CREATE TABLE stg.stg_tms_pltpo_trip_odo_details (
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

ALTER TABLE ONLY stg.stg_tms_pltpo_trip_odo_details
    ADD CONSTRAINT pk_tms_pltpo_trip_odo_details PRIMARY KEY (plpto_ouinstance, plpto_guid);