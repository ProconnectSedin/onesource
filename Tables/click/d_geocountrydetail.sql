CREATE TABLE click.d_geocountrydetail (
    geo_country_key bigint NOT NULL,
    geo_country_code character varying(80) COLLATE public.nocase,
    geo_country_ou integer,
    geo_country_lineno integer,
    geo_country_desc character varying(510) COLLATE public.nocase,
    geo_country_timezn character varying(510) COLLATE public.nocase,
    geo_country_status character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);