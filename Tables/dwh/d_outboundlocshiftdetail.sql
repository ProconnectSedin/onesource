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

ALTER TABLE dwh.d_outboundlocshiftdetail ALTER COLUMN obd_loc_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_outboundlocshiftdetail_obd_loc_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_outboundlocshiftdetail
    ADD CONSTRAINT d_outboundlocshiftdetail_pkey PRIMARY KEY (obd_loc_dtl_key);

ALTER TABLE ONLY dwh.d_outboundlocshiftdetail
    ADD CONSTRAINT d_outboundlocshiftdetail_obd_loc_sht_key_fkey FOREIGN KEY (obd_loc_sht_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX d_outboundlocshiftdetail_key_idx ON dwh.d_outboundlocshiftdetail USING btree (obd_loc_sht_key);

CREATE INDEX d_outboundlocshiftdetail_key_idx3 ON dwh.d_outboundlocshiftdetail USING btree (ou, locationcode, ordertype, servicetype);