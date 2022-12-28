-- Table: click.d_outboundtat

-- DROP TABLE IF EXISTS click.d_outboundtat;

CREATE TABLE IF NOT EXISTS click.d_outboundtat
(
    obd_tat_key bigint NOT NULL,
    loc_key bigint NOT NULL,
    id integer,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    ordertype character varying(20) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    processtat character varying(50) COLLATE public.nocase,
    picktat character varying(30) COLLATE public.nocase,
    packtat character varying(30) COLLATE public.nocase,
    disptat character varying(30) COLLATE public.nocase,
    deltat character varying(30) COLLATE public.nocase,
    picktat1 integer,
    packtat1 integer,
    disptat1 integer,
    deltat1 integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_outboundtat_pkey PRIMARY KEY (obd_tat_key),
    CONSTRAINT d_outboundtat_loc_key_fkey FOREIGN KEY (loc_key)
        REFERENCES click.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.d_outboundtat
    OWNER to proconnect;