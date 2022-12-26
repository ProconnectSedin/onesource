CREATE TABLE click.d_shippingpointcustmap (
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