CREATE TABLE stg.stg_tms_vdaps_agent_pro_settings (
    vdaps_ouinstance integer NOT NULL,
    vdaps_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vdaps_guid character varying(512) NOT NULL COLLATE public.nocase,
    vdaps_priority integer,
    vdaps_created_by character varying(120) COLLATE public.nocase,
    vdaps_created_date timestamp without time zone,
    vdaps_last_modified_by character varying(120) COLLATE public.nocase,
    vdaps_last_modified_date timestamp without time zone,
    vdaps_timestamp integer,
    vdaps_param_code character varying(32) NOT NULL COLLATE public.nocase,
    vdaps_param_operator character varying(160) COLLATE public.nocase,
    vdaps_param_value1 character varying(1020) COLLATE public.nocase,
    vdaps_param_value2 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);