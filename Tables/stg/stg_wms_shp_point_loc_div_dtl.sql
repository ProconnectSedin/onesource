CREATE TABLE stg.stg_wms_shp_point_loc_div_dtl (
    wms_shp_pt_ou integer NOT NULL,
    wms_shp_pt_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_shp_pt_lineno integer NOT NULL,
    wms_shp_pt_type character varying(32) COLLATE public.nocase,
    wms_shp_pt_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);