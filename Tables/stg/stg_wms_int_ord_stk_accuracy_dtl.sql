CREATE TABLE stg.stg_wms_int_ord_stk_accuracy_dtl (
    wms_in_ord_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_in_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_in_ord_lineno integer NOT NULL,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_item character varying(128) COLLATE public.nocase,
    wms_in_ord_customer_item_code character varying(128) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_int_ord_stk_accuracy_dtl
    ADD CONSTRAINT wms_int_ord_stk_accuracy_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);