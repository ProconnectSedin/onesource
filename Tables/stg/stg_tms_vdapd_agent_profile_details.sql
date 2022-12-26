CREATE TABLE stg.stg_tms_vdapd_agent_profile_details (
    vdapd_ouinstance integer NOT NULL,
    vdapd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vdapd_agent_id character varying(160) NOT NULL COLLATE public.nocase,
    vdapd_agent_line_no integer,
    vdapd_profile_run_no character varying(72) NOT NULL COLLATE public.nocase,
    vdapd_current_status character varying(32) COLLATE public.nocase,
    vdapd_manual_source character(4) COLLATE public.nocase,
    vdapd_profile_source character(4) COLLATE public.nocase,
    vdapd_created_by character varying(120) COLLATE public.nocase,
    vdapd_created_date timestamp without time zone,
    vdapd_guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);