CREATE TABLE stg.stg_wms_goodsreceipt_plan_checklist_dtl (
    wms_disp_location character varying(40) COLLATE public.nocase,
    wms_plan_no character varying(72) COLLATE public.nocase,
    wms_disp_ou integer,
    wms_disp_pln_lineno integer,
    wms_disp_chk_lineno integer,
    wms_disp_instructions character varying(1020) COLLATE public.nocase,
    wms_disp_checklist integer,
    wms_dispatch_emp_id character varying(80) COLLATE public.nocase,
    wms_dispatch_insp_datetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);