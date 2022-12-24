CREATE TABLE click.d_customerlocation (
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