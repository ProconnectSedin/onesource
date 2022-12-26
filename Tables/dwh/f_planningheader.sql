CREATE TABLE dwh.f_planningheader (
    plph_hdr_key bigint NOT NULL,
    plph_loc_key bigint NOT NULL,
    plph_ouinstance integer,
    plph_plan_run_no character varying(40) COLLATE public.nocase,
    plph_status character varying(80) COLLATE public.nocase,
    plph_description character varying(1000) COLLATE public.nocase,
    plph_planning_profile_no character varying(80) COLLATE public.nocase,
    plph_plan_location_no character varying(80) COLLATE public.nocase,
    plph_created_by character varying(60) COLLATE public.nocase,
    plph_created_date timestamp without time zone,
    plph_last_modified_by character varying(60) COLLATE public.nocase,
    plph_last_modified_date timestamp without time zone,
    plph_plan_mode character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);