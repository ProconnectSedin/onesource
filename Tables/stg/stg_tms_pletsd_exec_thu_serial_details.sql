CREATE TABLE stg.stg_tms_pletsd_exec_thu_serial_details (
    pletsd_ouinstance integer,
    pletsd_execution_plan_id character varying(160) COLLATE public.nocase,
    pletsd_line_no character varying(512) COLLATE public.nocase,
    pletsd_thu_line_no character varying(512) COLLATE public.nocase,
    pletsd_serial_line_no character varying(512) COLLATE public.nocase,
    pletsd_serial character varying(160) COLLATE public.nocase,
    pletsd_serial_available_qty numeric,
    pletsd_serial_draft_qty numeric,
    pletsd_serial_confirmed_qty numeric,
    pletsd_serail_available_weight numeric,
    pletsd_serial_draft_weight numeric,
    pletsd_serial_confirmed_weight numeric,
    pletsd_serial_available_volume numeric,
    pletsd_serial_draft_volume numeric,
    pletsd_serial_confirmed_volume numeric,
    pletsd_created_by character varying(120) COLLATE public.nocase,
    pletsd_created_date character varying(100) COLLATE public.nocase,
    pletsd_modified_by character varying(120) COLLATE public.nocase,
    pletsd_modified_date character varying(100) COLLATE public.nocase,
    pletsd_timestamp integer,
    pletsd_serial_initiated_qty numeric,
    pletsd_serial_executed_qty numeric,
    pletsd_serial_initiated_weight numeric,
    pletsd_serial_executed_weight numeric,
    pletsd_serial_initiated_volume numeric,
    pletsd_serial_executed_volume numeric,
    pletsd_serial_dropped_off integer,
    pletsd_serial_dispatch character varying(160) COLLATE public.nocase,
    pletsd_updated_by character varying(1020) COLLATE public.nocase,
    pletsd_picked_shortclosure integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_tms_pletsd_exec_thu_serial_details_key_idx2 ON stg.stg_tms_pletsd_exec_thu_serial_details USING btree (pletsd_ouinstance, pletsd_execution_plan_id, pletsd_line_no, pletsd_thu_line_no, pletsd_serial_line_no);