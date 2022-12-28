CREATE TABLE raw.raw_wms_item_supplier_dtl (
    raw_id bigint NOT NULL,
    wms_itm_ou integer NOT NULL,
    wms_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_itm_lineno integer NOT NULL,
    wms_itm_supp_code character varying(64) COLLATE public.nocase,
    wms_item_source character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_item_supplier_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_item_supplier_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_item_supplier_dtl
    ADD CONSTRAINT raw_wms_item_supplier_dtl_pkey PRIMARY KEY (raw_id);