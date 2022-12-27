CREATE TABLE dwh.f_brconsignmentthuserialdetail (
    ctsd_thu_key bigint NOT NULL,
    ctsd_br_key bigint NOT NULL,
    ctsd_ouinstance integer,
    ctsd_br_id character varying(40) COLLATE public.nocase,
    ctsd_thu_line_no character varying(300) COLLATE public.nocase,
    ctsd_thu_serial_line_no character varying(300) COLLATE public.nocase,
    ctsd_serial_no character varying(80) COLLATE public.nocase,
    ctsd_hazmat_code character varying(80) COLLATE public.nocase,
    ctsd_length numeric(25,2),
    ctsd_breadth numeric(25,2),
    ctsd_height numeric(25,2),
    ctsd_lbh_uom character varying(30) COLLATE public.nocase,
    ctsd_gross_weight numeric(25,2),
    ctsd_gross_weight_uom character varying(30) COLLATE public.nocase,
    ctsd_created_date timestamp without time zone,
    ctsd_created_by character varying(60) COLLATE public.nocase,
    ctsd_last_modified_by character varying(60) COLLATE public.nocase,
    ctsd_last_modified_date timestamp without time zone,
    ctsd_altqty numeric(25,2),
    ctsd_altqty_uom character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brconsignmentthuserialdetail ALTER COLUMN ctsd_thu_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brconsignmentthuserialdetail_ctsd_thu_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_pkey PRIMARY KEY (ctsd_thu_key);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_ukey UNIQUE (ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_ctsd_br_key_fkey FOREIGN KEY (ctsd_br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_brconsignmentthuserialdetail_key_idx ON dwh.f_brconsignmentthuserialdetail USING btree (ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no);

CREATE INDEX f_brconsignmentthuserialdetail_key_idx1 ON dwh.f_brconsignmentthuserialdetail USING btree (ctsd_br_key);