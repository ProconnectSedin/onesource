CREATE TABLE stg.stg_wms_geo_suburb_dtl (
    wms_geo_country_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_state_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_city_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_postal_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_suburb_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_suburb_ou integer NOT NULL,
    wms_geo_suburb_lineno integer NOT NULL,
    wms_geo_suburb_desc character varying(1020) COLLATE public.nocase,
    wms_geo_suburb_status character varying(32) COLLATE public.nocase,
    wms_geo_suburb_rsn character varying(160) COLLATE public.nocase,
    wms_geo_suburb_lantitude character varying(160) COLLATE public.nocase,
    wms_geo_suburb_longitude character varying(160) COLLATE public.nocase,
    wms_geo_suburb_geo_fen_name character varying(160) COLLATE public.nocase,
    wms_geo_suburb_geo_fen_range numeric,
    wms_geo_suburb_range_uom character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_geo_suburb_dtl
    ADD CONSTRAINT wms_geo_suburb_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_postal_code, wms_geo_suburb_code, wms_geo_suburb_ou, wms_geo_suburb_lineno);