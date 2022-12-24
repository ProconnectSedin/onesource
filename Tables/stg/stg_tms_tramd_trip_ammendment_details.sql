CREATE TABLE stg.stg_tms_tramd_trip_ammendment_details (
    tramd_ouinstance integer,
    tramd_trip character varying(160) COLLATE public.nocase,
    tramd_reference_doc character varying(160) COLLATE public.nocase,
    tramd_ammendment_count integer,
    tramd_trip_privious_status character varying(160) COLLATE public.nocase,
    tramd_trip_current_status character varying(160) COLLATE public.nocase,
    tramd_created_by character varying(160) COLLATE public.nocase,
    tramd_created_date timestamp without time zone,
    tramd_pri_sta_modified_by character varying(160) COLLATE public.nocase,
    tramd_pri_sta_modified_date timestamp without time zone,
    tramd_version_guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);