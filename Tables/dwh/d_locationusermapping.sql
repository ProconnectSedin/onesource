CREATE TABLE dwh.d_locationusermapping (
    loc_user_mapping_key bigint NOT NULL,
    loc_ou integer,
    loc_code character varying(20) COLLATE public.nocase,
    loc_lineno integer,
    loc_user_name character varying(60) COLLATE public.nocase,
    loc_user_admin integer,
    loc_user_planner integer,
    loc_user_executor integer,
    loc_user_controller integer,
    loc_user_default integer,
    loc_status character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);