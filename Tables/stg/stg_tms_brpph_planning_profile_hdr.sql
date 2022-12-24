CREATE TABLE stg.stg_tms_brpph_planning_profile_hdr (
    brpph_ouinstance integer NOT NULL,
    brpph_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    brpph_default_profile integer,
    brpph_profile_desc character varying(1020) COLLATE public.nocase,
    brpph_status character varying(160) COLLATE public.nocase,
    brpph_profile_division character varying(40) COLLATE public.nocase,
    brpph_profile_location character varying(80) COLLATE public.nocase,
    brpph_profile_temp_controlled character(4) COLLATE public.nocase,
    brpph_timestamp integer,
    brpph_created_by character varying(120) COLLATE public.nocase,
    brpph_created_date timestamp without time zone,
    brpph_last_modified_by character varying(120) COLLATE public.nocase,
    brpph_last_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);