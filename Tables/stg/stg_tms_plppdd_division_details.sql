CREATE TABLE stg.stg_tms_plppdd_division_details (
    plppdd_ouinstance integer NOT NULL,
    plppd_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    plppd_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plppd_division_id character varying(160) COLLATE public.nocase,
    plppd_location_id character varying(160) COLLATE public.nocase,
    plpptd_created_by character varying(120) COLLATE public.nocase,
    plpptd_created_date timestamp without time zone,
    plpptd_last_modified_by character varying(120) COLLATE public.nocase,
    plpptd_last_modified_date timestamp without time zone,
    plpph_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);