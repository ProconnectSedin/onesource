CREATE TABLE dwh.f_brewaybilldetail (
    ewbd_key bigint NOT NULL,
    br_key bigint NOT NULL,
    ewbd_br_no character varying(40) COLLATE public.nocase,
    ewbd_ouinstance integer,
    ewbd_bill_no character varying(80) COLLATE public.nocase,
    ewbd_ewaybl_guid character varying(300) COLLATE public.nocase,
    ewbd_remarks character varying(510) COLLATE public.nocase,
    ewbd_created_date timestamp without time zone,
    ewbd_created_by character varying(60) COLLATE public.nocase,
    ewbd_modified_date timestamp without time zone,
    ewbd_modified_by character varying(60) COLLATE public.nocase,
    ewbd_timestamp integer,
    ewbd_expiry_date timestamp without time zone,
    ewbd_shipper_invoice_date timestamp without time zone,
    ewbd_shipper_invoice_value numeric(13,2),
    ewbd_shipper_invoice_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brewaybilldetail ALTER COLUMN ewbd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brewaybilldetail_ewbd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_pkey PRIMARY KEY (ewbd_key);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_ukey UNIQUE (ewbd_br_no, ewbd_ouinstance);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_brewaybilldetail_key_idx ON dwh.f_brewaybilldetail USING btree (br_key);

CREATE INDEX f_brewaybilldetail_key_idx1 ON dwh.f_brewaybilldetail USING btree (ewbd_br_no, ewbd_ouinstance);