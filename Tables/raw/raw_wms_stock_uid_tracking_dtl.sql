CREATE TABLE raw.raw_wms_stock_uid_tracking_dtl (
    raw_id bigint NOT NULL,
    wms_stk_ou integer NOT NULL,
    wms_stk_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_bin character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_bin_type character varying(80) NOT NULL COLLATE public.nocase,
    wms_stk_staging_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_stage character varying(160) NOT NULL COLLATE public.nocase,
    wms_stk_customer character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_uid_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_stk_su character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_from_date timestamp without time zone NOT NULL,
    wms_stk_to_date timestamp without time zone,
    wms_stk_from_tran_type character varying(100) COLLATE public.nocase,
    wms_stk_to_tran_type character varying(100) COLLATE public.nocase,
    wms_stk_from_tran_no character varying(72) COLLATE public.nocase,
    wms_stk_to_tran_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_uid_tracking_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_uid_tracking_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_uid_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_uid_tracking_dtl_pkey PRIMARY KEY (raw_id);