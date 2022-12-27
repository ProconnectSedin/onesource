CREATE TABLE stg.stg_wms_loading_plan_dtl (
    wms_loading_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loading_ld_sheet_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_loading_ld_sheet_ou integer NOT NULL,
    wms_loading_ld_sheet_lineno integer NOT NULL,
    wms_loading_dock_no character varying(72) COLLATE public.nocase,
    wms_loading_mhe character varying(120) COLLATE public.nocase,
    wms_loading_employee character varying(80) COLLATE public.nocase,
    wms_loading_ready_load integer,
    wms_loading_lsp character varying(64) COLLATE public.nocase,
    wms_loading_actual_lsp character varying(64) COLLATE public.nocase,
    wms_loading_remarks character varying(1020) COLLATE public.nocase,
    wms_loading_thu_id character varying(160) COLLATE public.nocase,
    wms_loading_ship_point character varying(72) COLLATE public.nocase,
    wms_loading_disp_doc_type character varying(32) COLLATE public.nocase,
    wms_loading_disp_doc_no character varying(72) COLLATE public.nocase,
    wms_loading_thu_desc character varying(1020) COLLATE public.nocase,
    wms_loading_thu_class character varying(160) COLLATE public.nocase,
    wms_loading_thu_sr_no character varying(112) COLLATE public.nocase,
    wms_loading_thu_acc character varying(280) COLLATE public.nocase,
    wms_loading_disp_doc_date timestamp without time zone,
    wms_loading_manifest_no character varying(72) COLLATE public.nocase,
    wms_loading_loading_status character varying(32) COLLATE public.nocase,
    wms_loading_pal_qty numeric,
    wms_loading_tran_typ character varying(32) COLLATE public.nocase,
    wms_loading_ven_thuid character varying(160) COLLATE public.nocase,
    wms_loading_so_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_loading_plan_dtl
    ADD CONSTRAINT wms_loading_plan_dtl_pk PRIMARY KEY (wms_loading_loc_code, wms_loading_ld_sheet_no, wms_loading_ld_sheet_ou, wms_loading_ld_sheet_lineno);