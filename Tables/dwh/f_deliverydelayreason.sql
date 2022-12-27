CREATE TABLE dwh.f_deliverydelayreason (
    f_deliverydelayreason_key bigint NOT NULL,
    wms_loc_key bigint NOT NULL,
    locationcode character varying(10) COLLATE public.nocase,
    invoiceno character varying(100) COLLATE public.nocase,
    invoicedate date,
    invoiceholdtype character varying(100) COLLATE public.nocase,
    remarks character varying(500) COLLATE public.nocase,
    createdby character varying(50) COLLATE public.nocase,
    createddate timestamp without time zone,
    guid character varying(255) COLLATE public.nocase,
    tranou integer,
    type character varying(100) COLLATE public.nocase,
    activity character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_deliverydelayreason ALTER COLUMN f_deliverydelayreason_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_deliverydelayreason_f_deliverydelayreason_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_deliverydelayreason
    ADD CONSTRAINT f_deliverydelayreason_pkey PRIMARY KEY (f_deliverydelayreason_key);

ALTER TABLE ONLY dwh.f_deliverydelayreason
    ADD CONSTRAINT f_deliverydelayreason_wms_loc_key_fkey FOREIGN KEY (wms_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_deliverydelayreason_idx ON dwh.f_deliverydelayreason USING btree (invoiceno, tranou, locationcode);

CREATE INDEX f_deliverydelayreason_idx1 ON dwh.f_deliverydelayreason USING btree (tranou, type, activity, locationcode, invoiceno, invoiceholdtype, invoicedate, guid, remarks);

CREATE INDEX f_deliverydelayreason_idx2 ON dwh.f_deliverydelayreason USING btree (tranou, type, activity, locationcode, invoiceno, invoiceholdtype, invoicedate, guid, remarks);

CREATE INDEX f_deliverydelayreason_idx3 ON dwh.f_deliverydelayreason USING btree (tranou, locationcode, invoiceno);