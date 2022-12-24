CREATE TABLE stg.stg_tms_vddpd_driver_profile_details (
    vddpd_ouinstance integer NOT NULL,
    vddpd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vddpd_driver_line_no integer NOT NULL,
    vddpd_driver_id character varying(160) NOT NULL COLLATE public.nocase,
    vddpd_profile_run_no character varying(72) NOT NULL COLLATE public.nocase,
    vddpd_current_location character varying(64) COLLATE public.nocase,
    vddpd_home_location character varying(64) COLLATE public.nocase,
    vddpd_latitude integer,
    vddpd_longitude integer,
    vddpd_current_status character varying(32) COLLATE public.nocase,
    vddpd_manual_source character(4) COLLATE public.nocase,
    vddpd_profile_source character(4) COLLATE public.nocase,
    vddpd_created_by character varying(120) COLLATE public.nocase,
    vddpd_created_date timestamp without time zone,
    vddpd_guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);