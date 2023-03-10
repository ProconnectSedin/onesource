CREATE TABLE IF NOT EXISTS dwh.f_sintcddtl
(
    f_sin_tcd_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE pg_catalog."default",
    tran_ou integer,
    tran_no character varying(36) COLLATE pg_catalog."default",
    line_no integer,
    item_tcd_code character varying(64) COLLATE pg_catalog."default",
    tcd_version integer,
    item_tcd_var character varying(64) COLLATE pg_catalog."default",
    "timestamp" integer,
    item_type character varying(10) COLLATE pg_catalog."default",
    tcd_level character varying(10) COLLATE pg_catalog."default",
    tcd_rate numeric(20,2),
    taxable_amount numeric(20,2),
    tcd_amount numeric(20,2),
    tcd_currency character varying(10) COLLATE pg_catalog."default",
    base_amount numeric(20,2),
    cost_center character varying(20) COLLATE pg_catalog."default",
    tms_flag character varying(10) COLLATE pg_catalog."default",
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sintcddtl_pkey PRIMARY KEY (f_sin_tcd_dtl_key),
    CONSTRAINT f_sintcddtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, item_tcd_code, tcd_version, item_tcd_var)
)
