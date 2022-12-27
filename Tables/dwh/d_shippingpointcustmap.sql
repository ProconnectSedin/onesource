CREATE TABLE dwh.d_shippingpointcustmap (
    shp_pt_cus_key bigint NOT NULL,
    shp_pt_ou integer,
    shp_pt_id character varying(36) COLLATE public.nocase,
    shp_pt_lineno integer,
    shp_pt_cusid character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_shippingpointcustmap ALTER COLUMN shp_pt_cus_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_shippingpointcustmap_shp_pt_cus_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_pkey PRIMARY KEY (shp_pt_cus_key);

ALTER TABLE ONLY dwh.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_ukey UNIQUE (shp_pt_ou, shp_pt_id, shp_pt_lineno);