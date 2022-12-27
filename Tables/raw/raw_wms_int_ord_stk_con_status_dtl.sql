CREATE TABLE raw.raw_wms_int_ord_stk_con_status_dtl (
    raw_id bigint NOT NULL,
    wms_in_ord_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_in_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_in_ord_lineno integer NOT NULL,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_item character varying(128) COLLATE public.nocase,
    wms_in_ord_status_from character varying(32) COLLATE public.nocase,
    wms_in_ord_status_to character varying(32) COLLATE public.nocase,
    wms_in_ord_customer_item_code character varying(128) COLLATE public.nocase,
    wms_in_ord_qty_uom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_int_ord_stk_con_status_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_int_ord_stk_con_status_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_int_ord_stk_con_status_dtl
    ADD CONSTRAINT raw_wms_int_ord_stk_con_status_dtl_pkey PRIMARY KEY (raw_id);