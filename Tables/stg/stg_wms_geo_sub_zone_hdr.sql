CREATE TABLE stg.stg_wms_geo_sub_zone_hdr (
    wms_geo_sub_zone character varying(160) NOT NULL COLLATE public.nocase,
    wms_geo_sub_zone_ou integer NOT NULL,
    wms_geo_sub_zone_desc character varying(1020) COLLATE public.nocase,
    wms_geo_sub_zone_stat character varying(32) COLLATE public.nocase,
    wms_geo_sub_zone_rsn character varying(160) COLLATE public.nocase,
    wms_geo_sub_zone_created_by character varying(120) COLLATE public.nocase,
    wms_geo_sub_zone_created_date timestamp without time zone,
    wms_geo_sub_zone_modified_by character varying(120) COLLATE public.nocase,
    wms_geo_sub_zone_modified_date timestamp without time zone,
    wms_geo_sub_zone_timestamp integer,
    wms_geo_sub_zone_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_geo_sub_zone_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_geo_sub_zone_userdefined3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);