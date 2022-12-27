CREATE TABLE dwh.f_brconsignmentdetail (
    brcd_key bigint NOT NULL,
    br_key bigint NOT NULL,
    brcd_thu_key bigint NOT NULL,
    brcd_curr_key bigint NOT NULL,
    cd_ouinstance integer,
    cd_br_id character varying(40) COLLATE public.nocase,
    cd_line_no integer,
    cd_thu_id character varying(80) COLLATE public.nocase,
    cd_thu_qty numeric(25,2),
    cd_thu_qty_uom character varying(30) COLLATE public.nocase,
    cd_declared_value_of_goods numeric(25,2),
    cd_insurance_value numeric(25,2),
    cd_currency character varying(20) COLLATE public.nocase,
    cd_class_of_stores character varying(80) COLLATE public.nocase,
    cd_volume numeric(25,2),
    cd_volume_uom character varying(30) COLLATE public.nocase,
    cd_gross_weight numeric(25,2),
    cd_weight_uom character varying(30) COLLATE public.nocase,
    cd_creation_date timestamp without time zone,
    cd_created_by character varying(60) COLLATE public.nocase,
    cd_last_modified_date timestamp without time zone,
    cd_last_modified_by character varying(60) COLLATE public.nocase,
    cd_unique_id character varying(300) COLLATE public.nocase,
    cd_no_of_pallet_space numeric(25,2),
    cd_transfer_to character varying(80) COLLATE public.nocase,
    cd_commoditycode character varying(40) COLLATE public.nocase,
    cd_commodityuom character varying(80) COLLATE public.nocase,
    cd_net_weight numeric(25,2),
    cd_shipper_invoice_value numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brconsignmentdetail ALTER COLUMN brcd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brconsignmentdetail_brcd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_pkey PRIMARY KEY (brcd_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_ukey UNIQUE (cd_ouinstance, cd_br_id, cd_line_no);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_brcd_curr_key_fkey FOREIGN KEY (brcd_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_brcd_thu_key_fkey FOREIGN KEY (brcd_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_brconsignmentdetail_key_idx ON dwh.f_brconsignmentdetail USING btree (br_key, brcd_thu_key, brcd_curr_key);

CREATE INDEX f_brconsignmentdetail_key_idx1 ON dwh.f_brconsignmentdetail USING btree (cd_ouinstance, cd_br_id, cd_line_no);