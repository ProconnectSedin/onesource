CREATE TABLE dwh.d_geosuburbdetail (
    geo_state_key bigint NOT NULL,
    geo_country_code character varying(80) COLLATE public.nocase,
    geo_state_code character varying(80) COLLATE public.nocase,
    geo_city_code character varying(80) COLLATE public.nocase,
    geo_postal_code character varying(80) COLLATE public.nocase,
    geo_suburb_code character varying(80) COLLATE public.nocase,
    geo_suburb_ou character varying(80) COLLATE public.nocase,
    geo_suburb_lineno integer,
    geo_suburb_desc character varying(510) COLLATE public.nocase,
    geo_suburb_status character varying(510) COLLATE public.nocase,
    geo_suburb_rsn character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_geosuburbdetail ALTER COLUMN geo_state_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_geosuburbdetail_geo_state_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY dwh.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_ukey UNIQUE (geo_country_code, geo_state_code, geo_city_code, geo_postal_code, geo_suburb_code, geo_suburb_ou, geo_suburb_lineno);