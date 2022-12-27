CREATE TABLE dwh.d_customerportalusermap (
    customer_key bigint NOT NULL,
    customer_id character varying(36) COLLATE public.nocase,
    customer_ou integer,
    customer_lineno integer,
    customer_user_id character varying(80) COLLATE public.nocase,
    customer_role character varying(80) COLLATE public.nocase,
    customer_wms integer,
    customer_tms integer,
    customer_addl_custmap character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerportalusermap ALTER COLUMN customer_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerportalusermap_customer_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY dwh.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_ukey UNIQUE (customer_id, customer_ou, customer_lineno);