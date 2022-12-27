CREATE TABLE raw.raw_wms_stock_uid_item_tracking_dtl (
    raw_id bigint NOT NULL,
    wms_stk_ou integer NOT NULL,
    wms_stk_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_stk_customer character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_date timestamp without time zone NOT NULL,
    wms_stk_uid_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_su character varying(40) COLLATE public.nocase,
    wms_stk_thu_id character varying(160) COLLATE public.nocase,
    wms_stk_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_stk_opn_bal numeric,
    wms_stk_received numeric,
    wms_stk_issued numeric,
    wms_stk_cls_bal numeric,
    wms_stk_write_off_qty numeric,
    wms_uid2serialno character varying(112) COLLATE public.nocase,
    wms_su2 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_uid_item_tracking_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_uid_item_tracking_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_uid_item_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_uid_item_tracking_dtl_pkey PRIMARY KEY (raw_id);