CREATE TABLE stg.stg_wms_geo_region_dtl (
    wms_geo_reg character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_reg_ou integer NOT NULL,
    wms_geo_reg_lineno integer NOT NULL,
    wms_geo_reg_type character varying(32) COLLATE public.nocase,
    wms_geo_reg_type_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_geo_region_dtl
    ADD CONSTRAINT wms_geo_region_dtl_pk PRIMARY KEY (wms_geo_reg, wms_geo_reg_ou, wms_geo_reg_lineno);