CREATE TABLE dwh.d_customerattributes (
    wms_cust_attr_key bigint NOT NULL,
    wms_cust_attr_cust_code character varying(36) COLLATE public.nocase,
    wms_cust_attr_lineno integer,
    wms_cust_attr_ou integer,
    wms_cust_attr_typ character varying(16) COLLATE public.nocase,
    wms_cust_attr_apl character varying(16) COLLATE public.nocase,
    wms_cust_attr_value character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerattributes ALTER COLUMN wms_cust_attr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerattributes_wms_cust_attr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerattributes
    ADD CONSTRAINT d_customerattributes_pkey PRIMARY KEY (wms_cust_attr_key);

ALTER TABLE ONLY dwh.d_customerattributes
    ADD CONSTRAINT d_customerattributes_ukey UNIQUE (wms_cust_attr_cust_code, wms_cust_attr_lineno, wms_cust_attr_ou);