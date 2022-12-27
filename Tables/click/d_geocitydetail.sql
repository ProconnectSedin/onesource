CREATE TABLE click.d_geocitydetail (
    geo_city_key bigint NOT NULL,
    geo_country_code character varying(80) COLLATE public.nocase,
    geo_state_code character varying(80) COLLATE public.nocase,
    geo_city_code character varying(80) COLLATE public.nocase,
    geo_city_ou integer,
    geo_city_lineno integer,
    geo_city_desc character varying(510) COLLATE public.nocase,
    geo_city_timezn character varying(510) COLLATE public.nocase,
    geo_city_status character varying(20) COLLATE public.nocase,
    geo_city_rsn character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_pkey PRIMARY KEY (geo_city_key);

ALTER TABLE ONLY click.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_ukey UNIQUE (geo_city_code, geo_city_ou, geo_country_code, geo_state_code, geo_city_lineno);