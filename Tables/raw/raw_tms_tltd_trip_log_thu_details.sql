CREATE TABLE raw.raw_tms_tltd_trip_log_thu_details (
    raw_id bigint NOT NULL,
    tltd_ouinstance integer NOT NULL,
    tltd_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tltd_trip_plan_line_id character varying(512) NOT NULL COLLATE public.nocase,
    tltd_dispatch_doc_no character varying(72) COLLATE public.nocase,
    tltd_thu_line_no character varying(512) COLLATE public.nocase,
    tltd_thu_id character varying(160) COLLATE public.nocase,
    tltd_class_of_stores character varying(160) COLLATE public.nocase,
    tltd_planned_qty numeric,
    tltd_thu_actual_qty numeric,
    tltd_damaged_qty numeric,
    tltd_vendor_id character varying(72) COLLATE public.nocase,
    tltd_vendor_thu_type character varying(160) COLLATE public.nocase,
    tltd_vendor_thu_id character varying(160) COLLATE public.nocase,
    tltd_vendor_doc_no character varying(160) COLLATE public.nocase,
    tltd_vendor_ac_no character varying(160) COLLATE public.nocase,
    tltd_cha_id character varying(160) COLLATE public.nocase,
    tltd_created_date character varying(100) COLLATE public.nocase,
    tltd_created_by character varying(120) COLLATE public.nocase,
    tltd_modified_date character varying(100) COLLATE public.nocase,
    tltd_modified_by character varying(120) COLLATE public.nocase,
    tltd_timestamp integer,
    tltd_transfer_type character varying(160) COLLATE public.nocase,
    tltd_remarks character varying(160) COLLATE public.nocase,
    tltd_trip_sequence integer,
    tltd_thu_weight numeric,
    tltd_rsncode_damage character varying(160) COLLATE public.nocase,
    tltd_thu_weight_uom character varying(60) COLLATE public.nocase,
    tltd_reasoncode_remarks character varying(1020) COLLATE public.nocase,
    tltd_damaged_reasoncode character varying(160) COLLATE public.nocase,
    tltd_returned_reasoncode character varying(160) COLLATE public.nocase,
    tltd_actual_planned_mismatch_reason character varying(160) COLLATE public.nocase,
    tltd_actual_pallet_space integer,
    tltd_returned_qty integer,
    tltd_planned_palletspace integer,
    tltd_actual_palletspace integer,
    tltd_volume numeric,
    tltd_volume_uom character varying(60) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tltd_trip_log_thu_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tltd_trip_log_thu_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tltd_trip_log_thu_details
    ADD CONSTRAINT raw_tms_tltd_trip_log_thu_details_pkey PRIMARY KEY (raw_id);