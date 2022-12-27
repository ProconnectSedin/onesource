CREATE TABLE raw.raw_wms_cust_attribute_dtl (
    raw_id bigint NOT NULL,
    wms_cust_attr_cust_code character varying(72) NOT NULL COLLATE public.nocase,
    wms_cust_attr_lineno integer NOT NULL,
    wms_cust_attr_ou integer NOT NULL,
    wms_cust_attr_typ character varying(32) COLLATE public.nocase,
    wms_cust_attr_apl character varying(32) COLLATE public.nocase,
    wms_cust_attr_value character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_cust_attribute_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_cust_attribute_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_cust_attribute_dtl
    ADD CONSTRAINT raw_wms_cust_attribute_dtl_pkey PRIMARY KEY (raw_id);