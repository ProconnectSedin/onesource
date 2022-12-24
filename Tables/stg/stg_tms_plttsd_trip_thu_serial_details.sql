CREATE TABLE stg.stg_tms_plttsd_trip_thu_serial_details (
    plttsd_ouinstance integer NOT NULL,
    plttsd_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    plttsd_plan_line_id character varying(512) NOT NULL COLLATE public.nocase,
    plttsd_thu_line_id character varying(512) NOT NULL COLLATE public.nocase,
    plttsd_serial_line_id character varying(512) NOT NULL COLLATE public.nocase,
    plttsd_serial character varying(160) COLLATE public.nocase,
    plttsd_serial_qty numeric,
    plttsd_serial_wei numeric,
    plttsd_serial_vol numeric,
    plttsd_created_by character varying(160) COLLATE public.nocase,
    plttsd_created_date timestamp without time zone,
    plttsd_modified_by character varying(160) COLLATE public.nocase,
    plttsd_modified_date timestamp without time zone,
    plttsd_time_stamp integer,
    plttsd_dispatch character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);