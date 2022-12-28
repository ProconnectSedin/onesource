CREATE TABLE raw.raw_tms_pletd_exec_thu_details (
    raw_id bigint NOT NULL,
    pletd_ouinstance integer NOT NULL,
    pletd_execution_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    pletd_line_no character varying(512) NOT NULL COLLATE public.nocase,
    pletd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    pletd_thu_available_qty numeric,
    pletd_thu_draft_qty numeric,
    pletd_thu_confirmed_qty numeric,
    pletd_thu_available_weight numeric,
    pletd_thu_draft_weight numeric,
    pletd_thu_confirmed_weight numeric,
    pletd_thu_available_volume numeric,
    pletd_thu_draft_volume numeric,
    pletd_thu_confirmed_volume numeric,
    pletd_created_by character varying(120) COLLATE public.nocase,
    pletd_created_date character varying(100) COLLATE public.nocase,
    pletd_modified_by character varying(120) COLLATE public.nocase,
    pletd_modified_date character varying(100) COLLATE public.nocase,
    pletd_updated_by character varying(1020) COLLATE public.nocase,
    pletd_timestamp integer,
    pletd_initiated_qty numeric,
    pletd_executed_qty numeric,
    pletd_dispatch_docno character varying(1020) COLLATE public.nocase,
    pletd_thu_id character varying(1020) COLLATE public.nocase,
    pletd_weight numeric,
    pletd_weight_uom character varying(160) COLLATE public.nocase,
    pletd_volume numeric,
    pletd_volume_uom character varying(160) COLLATE public.nocase,
    pletd_pallet integer,
    pletd_thu_qty numeric,
    pletd_pickup_shotclosure_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_pletd_exec_thu_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_pletd_exec_thu_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_pletd_exec_thu_details
    ADD CONSTRAINT raw_tms_pletd_exec_thu_details_pkey PRIMARY KEY (raw_id);