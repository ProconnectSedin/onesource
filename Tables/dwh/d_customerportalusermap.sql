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