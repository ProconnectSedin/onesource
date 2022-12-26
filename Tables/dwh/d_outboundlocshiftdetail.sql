CREATE TABLE dwh.d_outboundlocshiftdetail (
    obd_loc_dtl_key bigint NOT NULL,
    obd_loc_sht_key bigint NOT NULL,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    days integer,
    openingtime time without time zone,
    closingtime time without time zone,
    cutofftime time without time zone,
    weeks character varying(9) COLLATE public.nocase,
    ordertype character varying(20) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);