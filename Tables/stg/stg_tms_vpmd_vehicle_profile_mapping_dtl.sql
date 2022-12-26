CREATE TABLE stg.stg_tms_vpmd_vehicle_profile_mapping_dtl (
    vpmd_ouinstance integer NOT NULL,
    vpmd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vpmd_division character varying(160) COLLATE public.nocase,
    vpmd_location character varying(160) COLLATE public.nocase,
    vpmd_user character varying(160) COLLATE public.nocase,
    vpmd_role character varying(160) COLLATE public.nocase,
    vpmd_guid character varying(512) NOT NULL COLLATE public.nocase,
    vpmd_creation_date timestamp without time zone,
    vpmd_created_by character varying(120) COLLATE public.nocase,
    vpmd_last_modified_date timestamp without time zone,
    vpmd_last_modified_by character varying(120) COLLATE public.nocase,
    vpmd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);