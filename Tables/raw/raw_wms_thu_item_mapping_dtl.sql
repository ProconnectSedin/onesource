CREATE TABLE raw.raw_wms_thu_item_mapping_dtl (
    raw_id bigint NOT NULL,
    wms_thu_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_thu_ou integer NOT NULL,
    wms_thu_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_thu_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_thu_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_itm_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_qty numeric,
    wms_thu_created_by character varying(120) COLLATE public.nocase,
    wms_thu_created_date timestamp without time zone,
    wms_thu_modified_by character varying(120) COLLATE public.nocase,
    wms_thu_modified_date timestamp without time zone,
    wms_thu_ser_no character varying(112) COLLATE public.nocase,
    wms_thu_serial_no2 character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_thu_item_mapping_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_thu_item_mapping_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_thu_item_mapping_dtl
    ADD CONSTRAINT raw_wms_thu_item_mapping_dtl_pkey PRIMARY KEY (raw_id);