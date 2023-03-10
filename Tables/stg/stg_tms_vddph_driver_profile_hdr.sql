CREATE TABLE stg.stg_tms_vddph_driver_profile_hdr (
    vddph_ouinstance integer NOT NULL,
    vddph_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vddph_active_profile_run_no character varying(72) COLLATE public.nocase,
    vddph_active_profile_run_date timestamp without time zone,
    vddph_default_profile character(4) COLLATE public.nocase,
    vddph_profile_desc character varying(1020) COLLATE public.nocase,
    vddph_status character varying(160) COLLATE public.nocase,
    vddph_home_location character varying(160) COLLATE public.nocase,
    vddph_attached_to_location character(4) COLLATE public.nocase,
    vddph_attached_to_vehicle character(4) COLLATE public.nocase,
    vddph_shift_preference character(4) COLLATE public.nocase,
    vddph_shift_start_time_pref character varying(160) COLLATE public.nocase,
    vddph_shift_start_time_from character varying(48) COLLATE public.nocase,
    vddph_shift_start_time_to character varying(48) COLLATE public.nocase,
    vddph_shift_end_time_pref character varying(160) COLLATE public.nocase,
    vddph_shift_end_time_from character varying(48) COLLATE public.nocase,
    vddph_shift_end_time_to character varying(48) COLLATE public.nocase,
    vddph_max_cont_drive_hrs character varying(160) COLLATE public.nocase,
    vddph_max_cont_drive_from integer,
    vddph_max_cont_drive_to integer,
    vddph_hrs_limit character varying(160) COLLATE public.nocase,
    vddph_hrs_limit_from integer,
    vddph_hrs_limit_to integer,
    vddph_leg_preferance character(4) COLLATE public.nocase,
    vddph_preferred_leg character varying(72) COLLATE public.nocase,
    vdvph_profile_division character varying(40) COLLATE public.nocase,
    vdvph_profile_location character varying(40) COLLATE public.nocase,
    vddph_created_by character varying(120) COLLATE public.nocase,
    vddph_created_date timestamp without time zone,
    vddph_last_modified_by character varying(120) COLLATE public.nocase,
    vddph_last_modified_date timestamp without time zone,
    vddph_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);