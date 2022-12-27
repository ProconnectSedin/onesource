-- Table: dwh.d_outboundtat

-- DROP TABLE IF EXISTS dwh.d_outboundtat;

CREATE TABLE IF NOT EXISTS dwh.d_outboundtat
(
    obd_tat_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
        REFERENCES dwh.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_outboundtat
    OWNER to proconnect;
-- Index: d_outboundtat_key_idx

-- DROP INDEX IF EXISTS dwh.d_outboundtat_key_idx;

CREATE INDEX IF NOT EXISTS d_outboundtat_key_idx
    ON dwh.d_outboundtat USING btree
    (loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: d_outboundtat_key_idx1

-- DROP INDEX IF EXISTS dwh.d_outboundtat_key_idx1;

CREATE INDEX IF NOT EXISTS d_outboundtat_key_idx1
    ON dwh.d_outboundtat USING btree
    (ou ASC NULLS LAST, loc_key ASC NULLS LAST, ordertype COLLATE public.nocase ASC NULLS LAST, servicetype COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: d_outboundtat_key_idx2

-- DROP INDEX IF EXISTS dwh.d_outboundtat_key_idx2;

CREATE INDEX IF NOT EXISTS d_outboundtat_key_idx2
    ON dwh.d_outboundtat USING btree
    (ou ASC NULLS LAST, locationcode COLLATE public.nocase ASC NULLS LAST, ordertype COLLATE public.nocase ASC NULLS LAST, servicetype COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;