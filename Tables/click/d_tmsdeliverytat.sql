-- Table: click.d_tmsdeliverytat

-- DROP TABLE IF EXISTS click.d_tmsdeliverytat;

CREATE TABLE IF NOT EXISTS click.d_tmsdeliverytat
(
    tms_dly_tat_key bigint NOT NULL,
    agent_code character varying(50) COLLATE public.nocase,
    shipfrom_place character varying(100) COLLATE public.nocase,
    shipfrom_pincode character varying(40) COLLATE pg_catalog."default",
    shipto_place character varying(100) COLLATE public.nocase,
    shipto_pincode character varying(40) COLLATE pg_catalog."default",
    ship_mode character varying(40) COLLATE pg_catalog."default",
    tat integer,
    tat_uom character varying(40) COLLATE pg_catalog."default",
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_tmsdeliverytat_pkey PRIMARY KEY (tms_dly_tat_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.d_tmsdeliverytat
    OWNER to proconnect;