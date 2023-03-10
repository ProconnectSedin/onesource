CREATE TABLE raw.raw_wms_geo_country_dtl (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_geo_country_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_geo_country_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_geo_country_dtl
    ADD CONSTRAINT raw_wms_geo_country_dtl_pkey PRIMARY KEY (raw_id);