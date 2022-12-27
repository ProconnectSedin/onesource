CREATE TABLE raw.raw_wms_shp_point_cusmap_dtl (
    raw_id bigint NOT NULL,
    wms_shp_pt_ou integer NOT NULL,
    wms_shp_pt_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_shp_pt_lineno integer NOT NULL,
    wms_shp_pt_cusid character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_shp_point_cusmap_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_shp_point_cusmap_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_shp_point_cusmap_dtl
    ADD CONSTRAINT raw_wms_shp_point_cusmap_dtl_pkey PRIMARY KEY (raw_id);