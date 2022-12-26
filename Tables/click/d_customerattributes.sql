CREATE TABLE click.d_customerattributes (
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