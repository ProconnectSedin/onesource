CREATE TABLE stg.stg_wms_int_ord_stk_con_quantity_dtl (
    wms_in_ord_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_in_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_in_ord_lineno integer NOT NULL,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_item character varying(128) COLLATE public.nocase,
    wms_in_ord_qty_from numeric,
    wms_in_ord_qty_to numeric,
    wms_in_ord_customer_item_code character varying(128) COLLATE public.nocase,
    wms_in_ord_writeoff_qty numeric,
    wms_in_ord_uom character varying(40) COLLATE public.nocase,
    wms_in_ord_mas_qty_to numeric,
    wms_in_ord_mas_qty_frm numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_int_ord_stk_con_quantity_dtl
    ADD CONSTRAINT wms_int_ord_stk_con_quantity_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);