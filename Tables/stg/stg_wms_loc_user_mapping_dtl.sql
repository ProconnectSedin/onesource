CREATE TABLE stg.stg_wms_loc_user_mapping_dtl (
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_lineno integer NOT NULL,
    wms_loc_user_name character varying(120) COLLATE public.nocase,
    wms_loc_user_admin integer,
    wms_loc_user_planner integer,
    wms_loc_user_executor integer,
    wms_loc_user_controller integer,
    wms_loc_user_default integer,
    wms_loc_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);