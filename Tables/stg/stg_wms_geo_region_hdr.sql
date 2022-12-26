CREATE TABLE stg.stg_wms_geo_region_hdr (
    wms_geo_reg character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_reg_ou integer NOT NULL,
    wms_geo_reg_desc character varying(1020) COLLATE public.nocase,
    wms_geo_reg_stat character varying(32) COLLATE public.nocase,
    wms_geo_reg_rsn character varying(160) COLLATE public.nocase,
    wms_geo_reg_created_by character varying(120) COLLATE public.nocase,
    wms_geo_reg_created_date timestamp without time zone,
    wms_geo_reg_modified_by character varying(120) COLLATE public.nocase,
    wms_geo_reg_modified_date timestamp without time zone,
    wms_geo_reg_timestamp integer,
    wms_geo_reg_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_geo_reg_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_geo_reg_userdefined3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);