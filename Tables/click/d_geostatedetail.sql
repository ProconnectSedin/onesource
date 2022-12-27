CREATE TABLE click.d_geostatedetail (
    geo_state_key bigint NOT NULL,
    geo_country_code character varying(80) NOT NULL COLLATE public.nocase,
    geo_state_code character varying(80) COLLATE public.nocase,
    geo_state_ou integer,
    geo_state_lineno integer,
    geo_state_desc character varying(510) COLLATE public.nocase,
    geo_state_timezn character varying(510) COLLATE public.nocase,
    geo_state_status character varying(20) COLLATE public.nocase,
    geo_state_rsn character varying(510) COLLATE public.nocase,
    ge_holidays character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY click.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_ukey UNIQUE (geo_state_code, geo_state_ou, geo_country_code, geo_state_lineno);