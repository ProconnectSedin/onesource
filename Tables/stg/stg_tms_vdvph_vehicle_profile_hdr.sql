CREATE TABLE stg.stg_tms_vdvph_vehicle_profile_hdr (
    vdvph_ouinstance integer NOT NULL,
    vdvph_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    vdvph_active_profile_run_no character varying(72) COLLATE public.nocase,
    vdvph_active_profile_run_date timestamp without time zone,
    vdvph_default_profile character(4) COLLATE public.nocase,
    vdvph_profile_desc character varying(1020) COLLATE public.nocase,
    vdvph_status character varying(160) COLLATE public.nocase,
    vdvph_home_location character varying(160) COLLATE public.nocase,
    vdvph_attached_to_location character(4) COLLATE public.nocase,
    vdvph_cd_from_home_loc_uom character varying(40) COLLATE public.nocase,
    vdvph_min_cd_from_home_loc integer,
    vdvph_max_cd_from_home_loc integer,
    vdvph_cd_from_planning_loc_uom character varying(40) COLLATE public.nocase,
    vdvph_min_cd_from_planning_loc integer,
    vdvph_max_cd_from_planning_loc integer,
    vdvph_driver_attached character(4) COLLATE public.nocase,
    vdvph_allowed_weight_uom character varying(40) COLLATE public.nocase,
    vdvph_min_allowed_weight integer,
    vdvph_max_allowed_weight integer,
    vdvph_profile_division character varying(40) COLLATE public.nocase,
    vdvph_profile_location character varying(40) COLLATE public.nocase,
    vdvph_created_by character varying(120) COLLATE public.nocase,
    vdvph_created_date timestamp without time zone,
    vdvph_last_modified_by character varying(120) COLLATE public.nocase,
    vdvph_last_modified_date timestamp without time zone,
    vdvph_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);