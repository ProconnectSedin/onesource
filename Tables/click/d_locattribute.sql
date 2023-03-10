CREATE TABLE click.d_locattribute (
    loc_attr_key bigint NOT NULL,
    loc_attr_loc_code character varying(20) COLLATE public.nocase,
    loc_attr_lineno integer,
    loc_attr_ou integer,
    loc_attr_typ character varying(80) COLLATE public.nocase,
    loc_attr_apl character varying(16) COLLATE public.nocase,
    loc_attr_value character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_locattribute
    ADD CONSTRAINT d_locattribute_pkey PRIMARY KEY (loc_attr_key);

ALTER TABLE ONLY click.d_locattribute
    ADD CONSTRAINT d_locattribute_ukey UNIQUE (loc_attr_loc_code, loc_attr_lineno, loc_attr_ou);