CREATE TABLE click.d_georegion (
    geo_reg_key bigint NOT NULL,
    geo_reg character varying(80) COLLATE public.nocase,
    geo_reg_ou integer,
    geo_reg_desc character varying(510) COLLATE public.nocase,
    geo_reg_stat character varying(20) COLLATE public.nocase,
    geo_reg_rsn character varying(80) COLLATE public.nocase,
    geo_reg_created_by character varying(60) COLLATE public.nocase,
    geo_reg_created_date timestamp without time zone,
    geo_reg_modified_by character varying(60) COLLATE public.nocase,
    geo_reg_modified_date timestamp without time zone,
    geo_reg_timestamp integer,
    geo_reg_userdefined1 character varying(510) COLLATE public.nocase,
    geo_reg_userdefined2 character varying(510) COLLATE public.nocase,
    geo_reg_userdefined3 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_georegion
    ADD CONSTRAINT d_georegion_pkey PRIMARY KEY (geo_reg_key);

ALTER TABLE ONLY click.d_georegion
    ADD CONSTRAINT d_georegion_ukey UNIQUE (geo_reg, geo_reg_ou);