CREATE TABLE stg.stg_wms_stock_lot_tracking_dtl (
    wms_stk_ou integer NOT NULL,
    wms_stk_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_stk_customer character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_date timestamp without time zone NOT NULL,
    wms_stk_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_opn_bal numeric,
    wms_stk_received numeric,
    wms_stk_issued numeric,
    wms_stk_cls_bal numeric,
    wms_stk_write_off_qty numeric,
    wms_stk_stock_status character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stock_lot_tracking_dtl
    ADD CONSTRAINT wms_stock_lot_tracking_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_item, wms_stk_customer, wms_stk_date, wms_stk_lot_no);