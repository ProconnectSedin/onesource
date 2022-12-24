CREATE TABLE stg.stg_wms_stock_su_bal_dtl (
    wms_stk_ou integer NOT NULL,
    wms_stk_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_customer character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_date timestamp without time zone NOT NULL,
    wms_stk_su character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_su_opn_bal numeric,
    wms_stk_su_received numeric,
    wms_stk_su_issued numeric,
    wms_stk_su_cls_bal numeric,
    wms_stk_su_peak_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);