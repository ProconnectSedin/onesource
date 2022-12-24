CREATE TABLE click.d_customerlocdiv (
    wms_customer_key bigint NOT NULL,
    wms_customer_id character varying(36) COLLATE public.nocase,
    wms_customer_ou integer,
    wms_customer_lineno integer,
    wms_customer_type character varying(16) COLLATE public.nocase,
    wms_customer_code character varying(20) COLLATE public.nocase,
    wms_customer_itm_val_contract integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);