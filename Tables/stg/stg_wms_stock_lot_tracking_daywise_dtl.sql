CREATE TABLE stg.stg_wms_stock_lot_tracking_daywise_dtl (
    wms_stk_ou integer NOT NULL,
    wms_stk_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_stk_customer character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_date timestamp without time zone NOT NULL,
    wms_stk_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_stock_status character varying(160) NOT NULL COLLATE public.nocase,
    wms_stk_opn_bal numeric,
    wms_stk_received numeric,
    wms_stk_issued numeric,
    wms_stk_cls_bal numeric,
    wms_stk_write_off_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);