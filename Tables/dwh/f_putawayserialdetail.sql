CREATE TABLE dwh.f_putawayserialdetail (
    pway_serial_dtl_key bigint NOT NULL,
    pway_pln_dtl_key bigint NOT NULL,
    pway_serial_dtl_loc_key bigint NOT NULL,
    pway_serial_dtl_zone_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_lineno integer,
    pway_itm_lineno integer,
    pway_zone character varying(20) COLLATE public.nocase,
    pway_bin character varying(20) COLLATE public.nocase,
    pway_serialno character varying(60) COLLATE public.nocase,
    pway_lotno character varying(60) COLLATE public.nocase,
    pway_cust_sno character varying(60) COLLATE public.nocase,
    pway_3pl_sno character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);