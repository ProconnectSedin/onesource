CREATE TABLE stg.stg_wms_loc_location_geo_dtl (
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_geo_lineno integer NOT NULL,
    wms_loc_geography character varying(160) COLLATE public.nocase,
    wms_loc_geo_type character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_loc_location_geo_dtl
    ADD CONSTRAINT wms_loc_location_geo_dtl_pk PRIMARY KEY (wms_loc_ou, wms_loc_code, wms_loc_geo_lineno);