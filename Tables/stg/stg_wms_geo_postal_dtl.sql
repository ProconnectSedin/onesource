CREATE TABLE stg.stg_wms_geo_postal_dtl (
    wms_geo_country_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_state_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_city_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_postal_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_postal_ou integer NOT NULL,
    wms_geo_postal_lineno integer NOT NULL,
    wms_geo_postal_desc character varying(1020) COLLATE public.nocase,
    wms_geo_postal_status character varying(32) COLLATE public.nocase,
    wms_geo_postal_rsn character varying(1020) COLLATE public.nocase,
    wms_geo_postal_lantitude character varying(160) COLLATE public.nocase,
    wms_geo_postal_longitude character varying(160) COLLATE public.nocase,
    wms_geo_postal_geo_fen_name character varying(160) COLLATE public.nocase,
    wms_geo_postal_geo_fen_range numeric,
    wms_geo_postal_range_uom character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_geo_postal_dtl
    ADD CONSTRAINT wms_geo_city_dt_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_postal_code, wms_geo_postal_ou, wms_geo_postal_lineno);