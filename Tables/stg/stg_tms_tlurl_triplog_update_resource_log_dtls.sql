CREATE TABLE stg.stg_tms_tlurl_triplog_update_resource_log_dtls (
    tlurl_ouinstance integer NOT NULL,
    tlurl_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tlurl_resource_id character varying(160) COLLATE public.nocase,
    tlurl_resource_type character varying(160) COLLATE public.nocase,
    tlurl_effective_from_date_time timestamp without time zone,
    tlurl_effective_to_date_time timestamp without time zone,
    tlurl_created_by character varying(120) COLLATE public.nocase,
    tlurl_created_date timestamp without time zone,
    tlurl_modified_by character varying(120) COLLATE public.nocase,
    tlurl_modified_date timestamp without time zone,
    tlurl_timestamp integer,
    tlurl_vendor_ref_no character varying(160) COLLATE public.nocase,
    tlurl_license_plate_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);