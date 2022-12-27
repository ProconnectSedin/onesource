CREATE TABLE raw.raw_wms_outbound_lot_ser_dtl (
    raw_id bigint NOT NULL,
    wms_oub_lotsl_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_lotsl_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_lotsl_lineno integer NOT NULL,
    wms_oub_item_code character varying(128) COLLATE public.nocase,
    wms_oub_item_lineno integer,
    wms_oub_lotsl_order_qty numeric,
    wms_oub_lotsl_batchno character varying(112) COLLATE public.nocase,
    wms_oub_lotsl_serialno character varying(112) COLLATE public.nocase,
    wms_oub_lotsl_masteruom character varying(40) COLLATE public.nocase,
    wms_oub_refdocno1 character varying(72) COLLATE public.nocase,
    wms_oub_refdocno2 character varying(72) COLLATE public.nocase,
    wms_oub_thu_id character varying(160) COLLATE public.nocase,
    wms_oub_thu_srno character varying(112) COLLATE public.nocase,
    wms_oub_cus_srno character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_outbound_lot_ser_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_outbound_lot_ser_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_outbound_lot_ser_dtl
    ADD CONSTRAINT raw_wms_outbound_lot_ser_dtl_pkey PRIMARY KEY (raw_id);