CREATE TABLE dwh.d_locattribute (
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

ALTER TABLE dwh.d_locattribute ALTER COLUMN loc_attr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_locattribute_loc_attr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_locattribute
    ADD CONSTRAINT d_locattribute_pkey PRIMARY KEY (loc_attr_key);

ALTER TABLE ONLY dwh.d_locattribute
    ADD CONSTRAINT d_locattribute_ukey UNIQUE (loc_attr_loc_code, loc_attr_lineno, loc_attr_ou);