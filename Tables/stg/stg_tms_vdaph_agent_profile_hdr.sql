CREATE TABLE stg.stg_tms_vdaph_agent_profile_hdr (
    vdaph_ouinstance integer NOT NULL,
    vdaph_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vdaph_active_profile_run_no character varying(72) COLLATE public.nocase,
    vdaph_active_profile_run_date timestamp without time zone,
    vdaph_default_profile character(4) COLLATE public.nocase,
    vdaph_profile_desc character varying(1020) COLLATE public.nocase,
    vdaph_status character varying(160) COLLATE public.nocase,
    vdaph_profile_division character varying(40) COLLATE public.nocase,
    vdaph_profile_location character varying(40) COLLATE public.nocase,
    vdaph_created_by character varying(120) COLLATE public.nocase,
    vdaph_created_date timestamp without time zone,
    vdaph_last_modified_by character varying(120) COLLATE public.nocase,
    vdaph_last_modified_date timestamp without time zone,
    vdaph_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);