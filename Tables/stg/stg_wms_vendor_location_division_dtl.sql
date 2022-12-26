CREATE TABLE stg.stg_wms_vendor_location_division_dtl (
    wms_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_vendor_ou integer NOT NULL,
    wms_vendor_lineno integer NOT NULL,
    wms_vendor_type character varying(32) COLLATE public.nocase,
    wms_vendor_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);