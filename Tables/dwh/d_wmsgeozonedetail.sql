CREATE TABLE dwh.d_wmsgeozonedetail (
    geo_zone_key bigint NOT NULL,
    geo_zone character varying(80) COLLATE public.nocase,
    geo_zone_ou integer,
    geo_zone_lineno integer,
    geo_zone_type character varying(20) COLLATE public.nocase,
    geo_zone_type_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_wmsgeozonedetail ALTER COLUMN geo_zone_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_wmsgeozonedetail_geo_zone_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY dwh.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_ukey UNIQUE (geo_zone, geo_zone_ou, geo_zone_lineno, geo_zone_type_code);