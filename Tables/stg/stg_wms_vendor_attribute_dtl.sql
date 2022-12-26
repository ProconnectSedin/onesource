CREATE TABLE stg.stg_wms_vendor_attribute_dtl (
    wms_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_vendor_ou integer NOT NULL,
    wms_vendor_lineno integer NOT NULL,
    wms_vendor_att_type character varying(1020) COLLATE public.nocase,
    wms_vendor_att_applicab character varying(1020) COLLATE public.nocase,
    wms_vendor_att_value character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);