CREATE TABLE dwh.f_triplogthudetail (
    tltd_tpthd_key bigint NOT NULL,
    plpth_hdr_key bigint NOT NULL,
    tltd_vendor_key bigint NOT NULL,
    tltd_ouinstance integer,
    tltd_trip_plan_id character varying(40) COLLATE public.nocase,
    tltd_trip_plan_line_id character varying(300) COLLATE public.nocase,
    tltd_dispatch_doc_no character varying(40) COLLATE public.nocase,
    tltd_thu_line_no character varying(300) COLLATE public.nocase,
    tltd_thu_id character varying(80) COLLATE public.nocase,
    tltd_class_of_stores character varying(80) COLLATE public.nocase,
    tltd_planned_qty numeric(25,2),
    tltd_thu_actual_qty numeric(25,2),
    tltd_damaged_qty numeric(25,2),
    tltd_vendor_id character varying(40) COLLATE public.nocase,
    tltd_vendor_thu_type character varying(80) COLLATE public.nocase,
    tltd_vendor_thu_id character varying(80) COLLATE public.nocase,
    tltd_vendor_doc_no character varying(80) COLLATE public.nocase,
    tltd_vendor_ac_no character varying(80) COLLATE public.nocase,
    tltd_cha_id character varying(80) COLLATE public.nocase,
    tltd_created_date character varying(50) COLLATE public.nocase,
    tltd_created_by character varying(60) COLLATE public.nocase,
    tltd_modified_date character varying(50) COLLATE public.nocase,
    tltd_modified_by character varying(60) COLLATE public.nocase,
    tltd_timestamp integer,
    tltd_transfer_type character varying(80) COLLATE public.nocase,
    tltd_remarks character varying(80) COLLATE public.nocase,
    tltd_trip_sequence integer,
    tltd_thu_weight numeric(25,2),
    tltd_rsncode_damage character varying(80) COLLATE public.nocase,
    tltd_thu_weight_uom character varying(30) COLLATE public.nocase,
    tltd_reasoncode_remarks character varying(510) COLLATE public.nocase,
    tltd_damaged_reasoncode character varying(80) COLLATE public.nocase,
    tltd_returned_reasoncode character varying(80) COLLATE public.nocase,
    tltd_actual_planned_mismatch_reason character varying(80) COLLATE public.nocase,
    tltd_actual_pallet_space integer,
    tltd_returned_qty integer,
    tltd_planned_palletspace integer,
    tltd_actual_palletspace integer,
    tltd_volume numeric(25,2),
    tltd_volume_uom character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogthudetail ALTER COLUMN tltd_tpthd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogthudetail_tltd_tpthd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_pkey PRIMARY KEY (tltd_tpthd_key);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_tltd_vendor_key_fkey FOREIGN KEY (tltd_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_triplogthudetail_key_idx ON dwh.f_triplogthudetail USING btree (tltd_vendor_key);

CREATE INDEX f_triplogthudetail_key_idx1 ON dwh.f_triplogthudetail USING btree (tltd_trip_plan_id, tltd_thu_line_no, tltd_trip_sequence, tltd_dispatch_doc_no, tltd_ouinstance, tltd_trip_plan_line_id);