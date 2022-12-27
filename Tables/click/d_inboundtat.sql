-- Table: click.d_inboundtat

-- DROP TABLE IF EXISTS click.d_inboundtat;

CREATE TABLE IF NOT EXISTS click.d_inboundtat
(
    d_inboundtat_key bigint NOT NULL,
    id integer,
    ou integer,
    locationcode character varying(30) COLLATE public.nocase,
    ordertype character varying(30) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    cutofftime time without time zone,
    processtat character varying(10) COLLATE public.nocase,
    grtat character varying(10) COLLATE public.nocase,
    putawaytat character varying(10) COLLATE public.nocase,
    openingtime time without time zone,
    closingtime time without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    location_key bigint,
    CONSTRAINT d_inboundtat_pkey PRIMARY KEY (d_inboundtat_key),
    CONSTRAINT d_inboundtat_ukey UNIQUE (id, ou, locationcode, ordertype, servicetype)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.d_inboundtat
    OWNER to proconnect;