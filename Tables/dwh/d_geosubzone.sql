CREATE TABLE dwh.d_geosubzone (
    geo_sub_zone_key bigint NOT NULL,
    geo_sub_zone character varying(80) COLLATE public.nocase,
    geo_sub_zone_ou integer,
    geo_sub_zone_desc character varying(510) COLLATE public.nocase,
    geo_sub_zone_stat character varying(20) COLLATE public.nocase,
    geo_sub_zone_created_by character varying(60) COLLATE public.nocase,
    geo_sub_zone_created_date timestamp without time zone,
    geo_sub_zone_modified_by character varying(60) COLLATE public.nocase,
    geo_sub_zone_modified_date timestamp without time zone,
    geo_sub_zone_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);