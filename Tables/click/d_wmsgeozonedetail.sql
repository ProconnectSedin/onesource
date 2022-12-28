CREATE TABLE click.d_wmsgeozonedetail (
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

ALTER TABLE ONLY click.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY click.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_ukey UNIQUE (geo_zone, geo_zone_ou, geo_zone_lineno, geo_zone_type_code);