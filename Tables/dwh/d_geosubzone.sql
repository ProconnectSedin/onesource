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

ALTER TABLE dwh.d_geosubzone ALTER COLUMN geo_sub_zone_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_geosubzone_geo_sub_zone_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_geosubzone
    ADD CONSTRAINT d_geosubzone_pkey PRIMARY KEY (geo_sub_zone_key);

ALTER TABLE ONLY dwh.d_geosubzone
    ADD CONSTRAINT d_geosubzone_ukey UNIQUE (geo_sub_zone, geo_sub_zone_ou);