CREATE TABLE stg.stg_wms_stock_inprocess_tracking_serial_dtl (
    wms_stk_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_ou integer NOT NULL,
    wms_stk_line_no integer NOT NULL,
    wms_stk_serial_line_no integer NOT NULL,
    wms_stk_su character varying(40) COLLATE public.nocase,
    wms_stk_thu_id character varying(160) COLLATE public.nocase,
    wms_stk_su_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_quantity numeric,
    wms_stk_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_stock_status character varying(160) COLLATE public.nocase,
    wms_stk_warranty_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_customer_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_3pl_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_thu_id_2 character varying(160) COLLATE public.nocase,
    wms_stk_thu_serial_no_2 character varying(112) COLLATE public.nocase,
    wms_stk_gr_staging character varying(72) COLLATE public.nocase,
    wms_stk_su2 character varying(40) COLLATE public.nocase,
    wms_stk_su_serial_no2 character varying(112) COLLATE public.nocase,
    wms_stk_su1_conv_flg character varying(32) COLLATE public.nocase,
    wms_stk_su2_conv_flg character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_stock_inprocess_tracking_serial_dtl_chk CHECK ((wms_stk_quantity >= (0)::numeric))
);

ALTER TABLE ONLY stg.stg_wms_stock_inprocess_tracking_serial_dtl
    ADD CONSTRAINT wms_stock_inprocess_tracking_serial_dtl_pk PRIMARY KEY (wms_stk_loc_code, wms_stk_ou, wms_stk_serial_line_no);