CREATE TABLE raw.raw_wms_loc_location_geo_dtl (
    raw_id bigint NOT NULL,
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_geo_lineno integer NOT NULL,
    wms_loc_geography character varying(160) COLLATE public.nocase,
    wms_loc_geo_type character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loc_location_geo_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loc_location_geo_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loc_location_geo_dtl
    ADD CONSTRAINT raw_wms_loc_location_geo_dtl_pkey PRIMARY KEY (raw_id);