CREATE TABLE stg.stg_tms_tlced_trip_log_custom_event_details (
    tlecd_ouinstance integer,
    tlecd_trip_plan_id character varying(72) COLLATE public.nocase,
    tlecd_reported_by character varying(160) COLLATE public.nocase,
    tlecd_bkreq character varying(160) COLLATE public.nocase,
    tlecd_event character varying(160) COLLATE public.nocase,
    tlecd_event_dtl character varying(160) COLLATE public.nocase,
    tlecd_bkreq_dtl character varying(160) COLLATE public.nocase,
    tlecd_actual_datetime timestamp without time zone,
    tlecd_remarks character varying(160) COLLATE public.nocase,
    tlecd_created_date character varying(100) COLLATE public.nocase,
    tlecd_created_by character varying(120) COLLATE public.nocase,
    tlecd_modified_date timestamp without time zone,
    tlecd_modified_by character varying(120) COLLATE public.nocase,
    tlecd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);