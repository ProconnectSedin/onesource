CREATE TABLE click.d_geozone (
    geo_zone_key bigint NOT NULL,
    geo_zone character varying(80) COLLATE public.nocase,
    geo_zone_ou integer,
    geo_zone_desc character varying(510) COLLATE public.nocase,
    geo_zone_stat character varying(20) COLLATE public.nocase,
    geo_zone_rsn character varying(80) COLLATE public.nocase,
    geo_zone_created_by character varying(60) COLLATE public.nocase,
    geo_zone_created_date timestamp without time zone,
    geo_zone_modified_by character varying(60) COLLATE public.nocase,
    geo_zone_modified_date timestamp without time zone,
    geo_zone_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);