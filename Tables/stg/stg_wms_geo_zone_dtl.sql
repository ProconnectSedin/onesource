CREATE TABLE stg.stg_wms_geo_zone_dtl (
    wms_geo_zone character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_zone_ou integer NOT NULL,
    wms_geo_zone_lineno integer NOT NULL,
    wms_geo_zone_type character varying(32) COLLATE public.nocase,
    wms_geo_zone_type_code character varying(160) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_geo_zone_dtl
    ADD CONSTRAINT wms_geo_zone_dtl_pkey PRIMARY KEY (wms_geo_zone, wms_geo_zone_ou, wms_geo_zone_lineno, wms_geo_zone_type_code);