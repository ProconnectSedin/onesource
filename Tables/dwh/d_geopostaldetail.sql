CREATE TABLE dwh.d_geopostaldetail (
    geo_postal_key bigint NOT NULL,
    geo_country_code character varying(80) COLLATE public.nocase,
    geo_state_code character varying(80) COLLATE public.nocase,
    geo_city_code character varying(80) COLLATE public.nocase,
    geo_postal_code character varying(80) COLLATE public.nocase,
    geo_postal_ou integer,
    geo_postal_lineno integer,
    geo_postal_desc character varying(510) COLLATE public.nocase,
    geo_postal_status character varying(20) COLLATE public.nocase,
    geo_postal_rsn character varying(510) COLLATE public.nocase,
    geo_postal_lantitude character varying(80) COLLATE public.nocase,
    geo_postal_longitude character varying(80) COLLATE public.nocase,
    geo_postal_geo_fen_name character varying(80) COLLATE public.nocase,
    geo_postal_geo_fen_range numeric,
    geo_postal_range_uom character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_geopostaldetail ALTER COLUMN geo_postal_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_geopostaldetail_geo_postal_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_pkey PRIMARY KEY (geo_postal_key);

ALTER TABLE ONLY dwh.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_ukey UNIQUE (geo_postal_code, geo_postal_ou, geo_country_code, geo_state_code, geo_city_code, geo_postal_lineno);