CREATE TABLE stg.stg_tms_pletd_exec_thu_details (
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

CREATE INDEX stg_tms_pletd_exec_thu_details_idx ON stg.stg_tms_pletd_exec_thu_details USING btree (pletd_ouinstance, pletd_execution_plan_id, pletd_line_no);

CREATE INDEX stg_tms_pletd_exec_thu_details_key_idx2 ON stg.stg_tms_pletd_exec_thu_details USING btree (pletd_ouinstance, pletd_execution_plan_id, pletd_line_no, pletd_dispatch_docno, pletd_thu_line_no);