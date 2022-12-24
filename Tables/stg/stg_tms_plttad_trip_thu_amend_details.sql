CREATE TABLE stg.stg_tms_plttad_trip_thu_amend_details (
    plttad_ouinstance integer,
    plttad_trip_plan_id character varying(160) COLLATE public.nocase,
    plttad_trip_plan_line_no character varying(512) COLLATE public.nocase,
    plttad_thu_line_no character varying(512) COLLATE public.nocase,
    plttad_thu_qty numeric,
    plttad_thu_weight numeric,
    plttad_thu_vol integer,
    plttad_created_by character varying(120) COLLATE public.nocase,
    plttad_created_date character varying(100) COLLATE public.nocase,
    plttad_modified_by character varying(120) COLLATE public.nocase,
    plttad_modified_date character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);