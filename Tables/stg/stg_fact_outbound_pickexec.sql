CREATE TABLE stg.stg_fact_outbound_pickexec (
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    oub_ou integer NOT NULL,
    oub_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    pick_pln_no character varying(72) COLLATE public.nocase,
    pick_pln_date timestamp without time zone,
    pick_pln_status character varying(32) COLLATE public.nocase,
    pick_lineno integer,
    pick_so_qty numeric,
    pick_item_batch_no character varying(112) COLLATE public.nocase,
    pick_item_sr_no character varying(112) COLLATE public.nocase,
    pick_plan_qty numeric,
    pick_zone character varying(40) COLLATE public.nocase,
    pick_bin character varying(72) COLLATE public.nocase,
    pick_bin_qty numeric,
    pick_su character varying(40) COLLATE public.nocase,
    pick_su_serial_no character varying(112) COLLATE public.nocase,
    pick_pln_lot_no character varying(112) COLLATE public.nocase,
    pick_allc_line_no integer,
    pick_su_type character varying(32) COLLATE public.nocase,
    pick_thu_id character varying(160) COLLATE public.nocase,
    pick_rqs_confirm integer,
    pick_allocated_qty numeric,
    pick_thu_serial_no character varying(112) COLLATE public.nocase,
    pick_cons character varying(160) COLLATE public.nocase,
    pick_staging_id character varying(72) COLLATE public.nocase,
    pick_source_thu_id character varying(160) COLLATE public.nocase,
    pick_source_thu_serial_no character varying(160) COLLATE public.nocase,
    pick_cross_dk_staging_id character varying(72) COLLATE public.nocase,
    pick_stock_status character varying(160) COLLATE public.nocase,
    pick_box_thu_id character varying(160) COLLATE public.nocase,
    pick_box_no character varying(72) COLLATE public.nocase,
    pick_employee character varying(160) COLLATE public.nocase,
    pick_mhe character varying(120) COLLATE public.nocase,
    pick_source_stage character varying(1020) COLLATE public.nocase,
    pick_source_docno character varying(72) COLLATE public.nocase,
    pick_pln_created_by character varying(120) COLLATE public.nocase,
    pick_pln_created_date timestamp without time zone,
    pick_pln_modified_by character varying(120) COLLATE public.nocase,
    pick_pln_modified_date timestamp without time zone,
    pick_pln_userdefined1 character varying(1020) COLLATE public.nocase,
    pick_pln_userdefined2 character varying(1020) COLLATE public.nocase,
    pick_pln_userdefined3 character varying(1020) COLLATE public.nocase,
    pick_output_pln character varying(32) COLLATE public.nocase,
    pick_completed_flag character varying(32) COLLATE public.nocase,
    pick_exec_no character varying(72) COLLATE public.nocase,
    pick_sch_lineno integer,
    pick_so_line_no integer,
    pick_item_code character varying(240) COLLATE public.nocase,
    pick_lot_no character varying(240) COLLATE public.nocase,
    pick_qty numeric,
    pick_reason_code character varying(160) COLLATE public.nocase,
    pick_exec_date timestamp without time zone,
    pick_exec_status character varying(32) COLLATE public.nocase,
    pick_exec_start_date timestamp without time zone,
    pick_exec_end_date timestamp without time zone,
    pick_exec_created_by character varying(120) COLLATE public.nocase,
    pick_exec_created_date timestamp without time zone,
    pick_exec_modified_by character varying(120) COLLATE public.nocase,
    pick_exec_modified_date timestamp without time zone,
    pick_exec_userdefined1 character varying(1020) COLLATE public.nocase,
    pick_exec_userdefined2 character varying(1020) COLLATE public.nocase,
    pick_exec_userdefined3 character varying(1020) COLLATE public.nocase,
    pick_steps character varying(80) COLLATE public.nocase,
    pick_gen_from character varying(32) COLLATE public.nocase,
    pick_pln_type character varying(32) COLLATE public.nocase,
    pick_zone_pickby character varying(32) COLLATE public.nocase,
    pick_reset_flg character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_fact_outbound_pickexec
    ADD CONSTRAINT pk__fact_out__4cd9458e837df774 PRIMARY KEY (refkey);