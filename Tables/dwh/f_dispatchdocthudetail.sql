CREATE TABLE dwh.f_dispatchdocthudetail (
    ddtd_key bigint NOT NULL,
    ddh_key bigint NOT NULL,
    ddh_thu_key bigint NOT NULL,
    ddtd_ouinstance integer,
    ddtd_dispatch_doc_no character varying(40) COLLATE public.nocase,
    ddtd_thu_line_no character varying(300) COLLATE public.nocase,
    ddtd_thu_id character varying(80) COLLATE public.nocase,
    ddtd_thu_qty numeric(25,2),
    ddtd_class_stores character varying(80) COLLATE public.nocase,
    ddtd_thu_desc character varying(80) COLLATE public.nocase,
    ddtd_thu_vol numeric(25,2),
    ddtd_thu_vol_uom character varying(30) COLLATE public.nocase,
    ddtd_thu_weight numeric(25,2),
    ddtd_thu_weight_uom character varying(30) COLLATE public.nocase,
    ddtd_created_by character varying(60) COLLATE public.nocase,
    ddtd_created_date timestamp without time zone,
    ddtd_last_modified_by character varying(60) COLLATE public.nocase,
    ddtd_lst_modified_date timestamp without time zone,
    ddtd_timestamp integer,
    ddtd_transfer_type character varying(80) COLLATE public.nocase,
    ddtd_remarks character varying(80) COLLATE public.nocase,
    ddtd_vendor_thu_id character varying(80) COLLATE public.nocase,
    ddtd_transfer_doc_no character varying(80) COLLATE public.nocase,
    ddtd_vendor_ac_no character varying(80) COLLATE public.nocase,
    ddtd_damaged_qty numeric(25,2),
    ddtd_billing_status character varying(20) COLLATE public.nocase,
    ddtd_no_of_pallet_space numeric(25,2),
    ddtd_height numeric(25,2),
    ddtd_commodityid character varying(40) COLLATE public.nocase,
    ddtd_commodity_qty numeric(25,2),
    ddtd_qty_uom character varying(80) COLLATE public.nocase,
    ddtd_thu_qty_uom character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocthudetail ALTER COLUMN ddtd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocthudetail_ddtd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_pkey PRIMARY KEY (ddtd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ukey UNIQUE (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ddh_key_fkey FOREIGN KEY (ddh_key) REFERENCES dwh.f_dispatchdocheader(ddh_key);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ddh_thu_key_fkey FOREIGN KEY (ddh_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_dispatchdocthudetail_key_idx ON dwh.f_dispatchdocthudetail USING btree (ddh_key, ddh_thu_key);

CREATE INDEX f_dispatchdocthudetail_key_idx1 ON dwh.f_dispatchdocthudetail USING btree (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);