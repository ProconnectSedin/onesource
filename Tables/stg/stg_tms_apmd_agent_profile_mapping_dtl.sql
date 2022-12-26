CREATE TABLE stg.stg_tms_apmd_agent_profile_mapping_dtl (
    apmd_ouinstance integer NOT NULL,
    apmd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    apmd_division character varying(160) COLLATE public.nocase,
    apmd_location character varying(160) COLLATE public.nocase,
    apmd_user character varying(160) COLLATE public.nocase,
    apmd_role character varying(160) COLLATE public.nocase,
    apmd_guid character varying(512) NOT NULL COLLATE public.nocase,
    apmd_creation_date timestamp without time zone,
    apmd_created_by character varying(120) COLLATE public.nocase,
    apmd_last_modified_date timestamp without time zone,
    apmd_last_modified_by character varying(120) COLLATE public.nocase,
    apmd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);