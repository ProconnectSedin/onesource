CREATE TABLE dwh.d_companycurrencymap (
    d_companycurrencymap_key bigint NOT NULL,
    serial_no integer,
    company_code character varying(20) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    map_status character varying(50) COLLATE public.nocase,
    effective_from timestamp without time zone,
    map_by character varying(60) COLLATE public.nocase,
    map_date timestamp without time zone,
    currency_flag character varying(30) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);