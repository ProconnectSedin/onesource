CREATE TABLE dwh.d_tmsdeliverytat (
    tms_dly_tat_key bigint NOT NULL,
    agent_code character varying(50) COLLATE public.nocase,
    shipfrom_place character varying(100) COLLATE public.nocase,
    shipfrom_pincode character varying(40),
    shipto_place character varying(100) COLLATE public.nocase,
    shipto_pincode character varying(40),
    ship_mode character varying(40),
    tat integer,
    tat_uom character varying(40),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);