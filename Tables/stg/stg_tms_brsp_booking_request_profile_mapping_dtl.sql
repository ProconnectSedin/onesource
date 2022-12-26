CREATE TABLE stg.stg_tms_brsp_booking_request_profile_mapping_dtl (
    brsp_ouinstance integer NOT NULL,
    brsp_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    brsp_division character varying(160) COLLATE public.nocase,
    brsp_location character varying(160) COLLATE public.nocase,
    brsp_user character varying(160) COLLATE public.nocase,
    brsp_role character varying(160) COLLATE public.nocase,
    brsp_guid character varying(512) NOT NULL COLLATE public.nocase,
    brsp_creation_date timestamp without time zone,
    brsp_created_by character varying(120) COLLATE public.nocase,
    brsp_last_modified_date timestamp without time zone,
    brsp_last_modified_by character varying(120) COLLATE public.nocase,
    brsp_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);