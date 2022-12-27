CREATE TABLE dwh.f_brconsignmentskudetail (
    brcsd_key bigint NOT NULL,
    br_key bigint NOT NULL,
    brcsd_ou integer,
    brcsd_br_id character varying(40) COLLATE public.nocase,
    brcsd_thu_line_no character varying(300) COLLATE public.nocase,
    brcsd_serial_no character varying(80) COLLATE public.nocase,
    brcsd_sku_line_no character varying(300) COLLATE public.nocase,
    brcsd_sku_id character varying(80) COLLATE public.nocase,
    brcsd_sku_rate numeric(13,2),
    brcsd_sku_quantity numeric(13,2),
    brcsd_sku_value numeric(13,2),
    brcsd_created_by character varying(60) COLLATE public.nocase,
    brcsd_created_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brconsignmentskudetail ALTER COLUMN brcsd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brconsignmentskudetail_brcsd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_pkey PRIMARY KEY (brcsd_key);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_ukey UNIQUE (brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_sku_line_no);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_brconsignmentskudetail_key_idx ON dwh.f_brconsignmentskudetail USING btree (br_key);

CREATE INDEX f_brconsignmentskudetail_key_idx1 ON dwh.f_brconsignmentskudetail USING btree (brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_sku_line_no);