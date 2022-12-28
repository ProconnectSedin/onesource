CREATE TABLE dwh.d_customerlocation (
    loc_cust_key bigint NOT NULL,
    loc_ou integer,
    loc_code character varying(20) COLLATE public.nocase,
    loc_lineno integer,
    loc_cust_code character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerlocation ALTER COLUMN loc_cust_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerlocation_loc_cust_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerlocation
    ADD CONSTRAINT d_customerlocation_pkey PRIMARY KEY (loc_cust_key);

ALTER TABLE ONLY dwh.d_customerlocation
    ADD CONSTRAINT d_customerlocation_ukey UNIQUE (loc_ou, loc_code, loc_lineno);