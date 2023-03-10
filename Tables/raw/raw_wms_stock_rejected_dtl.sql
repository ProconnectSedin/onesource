CREATE TABLE raw.raw_wms_stock_rejected_dtl (
    raw_id bigint NOT NULL,
    wms_rejstk_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_rejstk_ou integer NOT NULL,
    wms_rejstk_gr_no character varying(72) COLLATE public.nocase,
    wms_rejstk_item_code character varying(128) COLLATE public.nocase,
    wms_rejstk_gr_line_no integer NOT NULL,
    wms_rejstk_rejected_qty numeric,
    wms_rejstk_created_by character varying(120) COLLATE public.nocase,
    wms_rejstk_created_date timestamp without time zone,
    wms_rejstk_modified_by character varying(120) COLLATE public.nocase,
    wms_rejstk_modified_date timestamp without time zone,
    wms_rejstk_staging_id character varying(72) COLLATE public.nocase,
    wms_rejstk_line_no integer NOT NULL,
    wms_rejstk_lot_no character varying(112) COLLATE public.nocase,
    wms_stk_sts character varying(32) COLLATE public.nocase,
    wms_rejstk_gr_exec_no character varying(72) COLLATE public.nocase,
    wms_rejstk_thuid character varying(160) COLLATE public.nocase,
    wms_rejstk_thu_ser_no character varying(112) COLLATE public.nocase,
    wms_rejstk_thuid_2 character varying(160) COLLATE public.nocase,
    wms_rejstk_thu_ser_no_2 character varying(112) COLLATE public.nocase,
    wms_rejstk_su1_conv_flg character varying(48) COLLATE public.nocase,
    wms_rejstk_su2_conv_flg character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_rejected_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_rejected_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_rejected_dtl
    ADD CONSTRAINT raw_wms_stock_rejected_dtl_pkey PRIMARY KEY (raw_id);