CREATE TABLE stg.stg_wms_goodsreceipt_rules_checklist_dtl (
    wms_disp_location character varying(40) COLLATE public.nocase,
    wms_disp_ou integer,
    wms_disp_chk_lineno character varying(120) COLLATE public.nocase,
    wms_disp_instructions character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);