CREATE TABLE stg.stg_wms_shp_point_cusmap_dtl (
    wms_shp_pt_ou integer NOT NULL,
    wms_shp_pt_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_shp_pt_lineno integer NOT NULL,
    wms_shp_pt_cusid character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);