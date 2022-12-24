CREATE TABLE stg.stg_tms_vddps_driver_profile_settings (
    vddps_ouinstance integer NOT NULL,
    vddps_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vddps_line_id character varying(512) NOT NULL COLLATE public.nocase,
    vddps_param_code character varying(160) NOT NULL COLLATE public.nocase,
    vddps_param_priority integer,
    vddps_created_by character varying(120) COLLATE public.nocase,
    vddps_created_date timestamp without time zone,
    vddps_last_modified_by character varying(120) COLLATE public.nocase,
    vddps_last_modified_date timestamp without time zone,
    vddps_timestamp integer,
    vddps_param_operator character varying(160) COLLATE public.nocase,
    vddps_param_value1 character varying(1020) COLLATE public.nocase,
    vddps_param_value2 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);