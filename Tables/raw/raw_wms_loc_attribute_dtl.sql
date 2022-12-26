CREATE TABLE raw.raw_wms_loc_attribute_dtl (
    raw_id bigint NOT NULL,
    wms_loc_attr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_attr_lineno integer NOT NULL,
    wms_loc_attr_ou integer NOT NULL,
    wms_loc_attr_typ character varying(160) COLLATE public.nocase,
    wms_loc_attr_apl character varying(32) COLLATE public.nocase,
    wms_loc_attr_value character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);