CREATE TABLE stg.stg_tms_vdvps_vehicle_profile_settings (
    vdvps_ouinstance integer NOT NULL,
    vdvps_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vdvps_line_id character varying(512) NOT NULL COLLATE public.nocase,
    vdvps_param_code character varying(32) NOT NULL COLLATE public.nocase,
    vdvps_param_priority integer,
    vdvps_created_by character varying(120) COLLATE public.nocase,
    vdvps_created_date timestamp without time zone,
    vdvps_last_modified_by character varying(120) COLLATE public.nocase,
    vdvps_last_modified_date timestamp without time zone,
    vdvps_timestamp integer,
    vdvps_param_operator character varying(160) COLLATE public.nocase,
    vdvps_param_value1 character varying(1020) COLLATE public.nocase,
    vdvps_param_value2 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);