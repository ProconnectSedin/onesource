CREATE TABLE stg.stg_tms_plttd_trip_thu_details (
    plttd_ouinstance integer NOT NULL,
    plttd_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    plttd_trip_plan_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plttd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    plttd_thu_qty numeric,
    plttd_thu_weight numeric,
    plttd_thu_vol numeric,
    plttd_created_by character varying(120) COLLATE public.nocase,
    plttd_created_date character varying(100) COLLATE public.nocase,
    plttd_modified_by character varying(120) COLLATE public.nocase,
    plttd_modified_date character varying(100) COLLATE public.nocase,
    plttd_timestamp integer,
    plttd_dispatch_doc_no character varying(1020) COLLATE public.nocase,
    plttd_thu_id character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_tms_plttd_trip_thu_details_key_idx2 ON stg.stg_tms_plttd_trip_thu_details USING btree (plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_dispatch_doc_no);