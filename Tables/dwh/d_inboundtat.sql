CREATE TABLE dwh.d_inboundtat (
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
    location_key bigint
);

ALTER TABLE dwh.d_inboundtat ALTER COLUMN d_inboundtat_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_inboundtat_d_inboundtat_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_inboundtat
    ADD CONSTRAINT d_inboundtat_pkey PRIMARY KEY (d_inboundtat_key);

ALTER TABLE ONLY dwh.d_inboundtat
    ADD CONSTRAINT d_inboundtat_ukey UNIQUE (id, ou, locationcode, ordertype, servicetype);

CREATE INDEX d_inboundtat_idx ON dwh.d_inboundtat USING btree (locationcode, ou, ordertype, servicetype);