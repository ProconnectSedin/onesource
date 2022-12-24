CREATE TABLE stg.stg_wms_geo_country_dtl (
    wms_geo_country_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_country_ou integer NOT NULL,
    wms_geo_country_lineno integer NOT NULL,
    wms_geo_country_desc character varying(1020) COLLATE public.nocase,
    wms_geo_country_timezn character varying(1020) COLLATE public.nocase,
    wms_geo_country_status character varying(32) COLLATE public.nocase,
    wms_geo_country_rsn character varying(1020) COLLATE public.nocase,
    wms_geo_currency character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);