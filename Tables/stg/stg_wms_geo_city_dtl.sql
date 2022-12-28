CREATE TABLE stg.stg_wms_geo_city_dtl (
    wms_geo_country_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_state_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_city_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_city_ou integer NOT NULL,
    wms_geo_city_lineno integer NOT NULL,
    wms_geo_city_desc character varying(1020) COLLATE public.nocase,
    wms_geo_city_timezn character varying(1020) COLLATE public.nocase,
    wms_geo_city_status character varying(32) COLLATE public.nocase,
    wms_geo_city_rsn character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_geo_city_dtl
    ADD CONSTRAINT wms_geo_city_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_city_ou, wms_geo_city_lineno);