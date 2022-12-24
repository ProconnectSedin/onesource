CREATE TABLE stg.stg_tms_brpps_planning_profile_settings (
    brpps_ouinstance integer NOT NULL,
    brpps_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    brpps_param_code character varying(60) NOT NULL COLLATE public.nocase,
    brpps_line_id character varying(512) COLLATE public.nocase,
    brpps_param_value character varying(1020) COLLATE public.nocase,
    brpps_param_priority integer,
    brpps_created_by character varying(120) COLLATE public.nocase,
    brpps_created_date timestamp without time zone,
    brpps_last_modified_by character varying(120) COLLATE public.nocase,
    brpps_last_modified_date timestamp without time zone,
    brpps_timestamp integer,
    brpps_param_value2 character varying(1020) COLLATE public.nocase,
    brpps_param_operator character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);