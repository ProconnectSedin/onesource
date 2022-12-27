CREATE TABLE raw.raw_wms_stock_bin_history_dtl (
    raw_id bigint NOT NULL,
    wms_stock_ou integer NOT NULL,
    wms_stock_date timestamp without time zone NOT NULL,
    wms_stock_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_bin character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_bin_type character varying(80) COLLATE public.nocase,
    wms_stock_customer character varying(72) COLLATE public.nocase,
    wms_stock_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_stock_opening_bal numeric,
    wms_stock_in_qty numeric,
    wms_stock_out_qty numeric,
    wms_stock_bin_qty numeric,
    wms_stock_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_stock_su_opening_bal numeric,
    wms_stock_su_count_qty_in numeric,
    wms_stock_su_count_qty_out numeric,
    wms_stock_su_count_qty_bal numeric,
    wms_stock_su character varying(40) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    wms_stock_thu_opening_bal numeric,
    wms_stock_thu_count_qty_in numeric,
    wms_stock_thu_count_qty_out numeric,
    wms_stock_thu_count_qty_bal numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_bin_history_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_bin_history_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_bin_history_dtl
    ADD CONSTRAINT raw_wms_stock_bin_history_dtl_pkey PRIMARY KEY (raw_id);