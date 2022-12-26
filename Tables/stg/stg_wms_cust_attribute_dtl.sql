CREATE TABLE stg.stg_wms_cust_attribute_dtl (
    wms_cust_attr_cust_code character varying(72) NOT NULL COLLATE public.nocase,
    wms_cust_attr_lineno integer NOT NULL,
    wms_cust_attr_ou integer NOT NULL,
    wms_cust_attr_typ character varying(32) COLLATE public.nocase,
    wms_cust_attr_apl character varying(32) COLLATE public.nocase,
    wms_cust_attr_value character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);