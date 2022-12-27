CREATE TABLE dwh.d_wmsoutboundtat (
    wms_obd_tat_key bigint NOT NULL,
    wms_loc_key bigint NOT NULL,
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
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_wmsoutboundtat ALTER COLUMN wms_obd_tat_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_wmsoutboundtat_wms_obd_tat_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_wmsoutboundtat
    ADD CONSTRAINT d_wmsoutboundtat_pkey PRIMARY KEY (wms_obd_tat_key);

ALTER TABLE ONLY dwh.d_wmsoutboundtat
    ADD CONSTRAINT d_wmsoutboundtat_wms_loc_key_fkey FOREIGN KEY (wms_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX d_wmsoutboundtat_key_idx ON dwh.d_wmsoutboundtat USING btree (wms_loc_key);

CREATE INDEX d_wmsoutboundtat_key_idx1 ON dwh.d_wmsoutboundtat USING btree (ou, wms_loc_key, ordertype, servicetype);

CREATE INDEX d_wmsoutboundtat_key_idx2 ON dwh.d_wmsoutboundtat USING btree (ou, locationcode, ordertype, servicetype);