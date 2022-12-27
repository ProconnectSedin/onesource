CREATE TABLE raw.raw_tms_plttd_trip_thu_details (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_tms_plttd_trip_thu_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_plttd_trip_thu_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_plttd_trip_thu_details
    ADD CONSTRAINT raw_tms_plttd_trip_thu_details_pkey PRIMARY KEY (raw_id);