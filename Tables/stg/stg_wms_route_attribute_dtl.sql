CREATE TABLE stg.stg_wms_route_attribute_dtl (
    wms_route_attr_route_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_route_attr_ou integer NOT NULL,
    wms_route_attr_lineno integer NOT NULL,
    wms_route_attr_typ character varying(1020) COLLATE public.nocase,
    wms_route_attr_apl character varying(1020) COLLATE public.nocase,
    wms_route_attr_value character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);