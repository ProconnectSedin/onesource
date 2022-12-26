CREATE TABLE stg.stg_tms_tled_trip_log_event_details (
    tled_ouinstance integer NOT NULL,
    tled_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tled_trip_plan_line_no character varying(512) COLLATE public.nocase,
    tled_bkr_id character varying(72) COLLATE public.nocase,
    tled_leg_no character varying(40) COLLATE public.nocase,
    tled_event_id character varying(160) COLLATE public.nocase,
    tled_actual_date_time timestamp without time zone,
    tled_remarks1 character varying(600) COLLATE public.nocase,
    tled_reason_code character varying(160) COLLATE public.nocase,
    tled_reason_description character varying(1020) COLLATE public.nocase,
    tled_remarks2 character varying(1020) COLLATE public.nocase,
    tled_created_date character varying(100) COLLATE public.nocase,
    tled_created_by character varying(120) COLLATE public.nocase,
    tled_modified_date timestamp without time zone,
    tled_modified_by character varying(120) COLLATE public.nocase,
    tled_timestamp integer,
    tled_planned_datetime timestamp without time zone,
    tled_trip_plan_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    tled_event_nod character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);