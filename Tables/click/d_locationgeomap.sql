CREATE TABLE click.d_locationgeomap (
    loc_geo_key bigint NOT NULL,
    loc_ou integer,
    loc_code character varying(20) COLLATE public.nocase,
    loc_geo_lineno integer,
    loc_geography character varying(80) COLLATE public.nocase,
    loc_geo_type character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_pkey PRIMARY KEY (loc_geo_key);

ALTER TABLE ONLY click.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_ukey UNIQUE (loc_ou, loc_code, loc_geo_lineno);