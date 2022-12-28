CREATE TABLE dwh.f_packplandetail (
    pack_pln_dtl_key bigint NOT NULL,
    pack_pln_hdr_key bigint NOT NULL,
    pack_pln_dtl_loc_key bigint NOT NULL,
    pack_pln_dtl_itm_hdr_key bigint NOT NULL,
    pack_pln_dtl_thu_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_pln_no character varying(40) COLLATE public.nocase,
    pack_pln_ou integer,
    pack_lineno integer,
    pack_picklist_no character varying(40) COLLATE public.nocase,
    pack_so_no character varying(40) COLLATE public.nocase,
    pack_so_line_no integer,
    pack_so_sch_lineno integer,
    pack_item_code character varying(80) COLLATE public.nocase,
    pack_item_batch_no character varying(60) COLLATE public.nocase,
    pack_item_sr_no character varying(60) COLLATE public.nocase,
    pack_so_qty numeric(25,2),
    pack_uid_sr_no character varying(60) COLLATE public.nocase,
    pack_thu_sr_no character varying(60) COLLATE public.nocase,
    pack_pre_packing_bay character varying(40) COLLATE public.nocase,
    pack_lot_no character varying(60) COLLATE public.nocase,
    pack_su character varying(20) COLLATE public.nocase,
    pack_su_type character varying(20) COLLATE public.nocase,
    pack_thu_id character varying(80) COLLATE public.nocase,
    pack_plan_qty numeric(25,2),
    pack_allocated_qty numeric(25,2),
    pack_tolerance_qty numeric(25,2),
    pack_customer_serial_no character varying(60) COLLATE public.nocase,
    pack_warranty_serial_no character varying(60) COLLATE public.nocase,
    pack_packed_from_uid_serno character varying(60) COLLATE public.nocase,
    pack_source_thu_ser_no character varying(80) COLLATE public.nocase,
    pack_item_attribute1 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packplandetail ALTER COLUMN pack_pln_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packplandetail_pack_pln_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pkey PRIMARY KEY (pack_pln_dtl_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_ukey UNIQUE (pack_loc_code, pack_pln_no, pack_pln_ou, pack_lineno);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_itm_hdr_key_fkey FOREIGN KEY (pack_pln_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_loc_key_fkey FOREIGN KEY (pack_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_thu_key_fkey FOREIGN KEY (pack_pln_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_hdr_key_fkey FOREIGN KEY (pack_pln_hdr_key) REFERENCES dwh.f_packplanheader(pack_pln_hdr_key);

CREATE INDEX f_packplandetail_key_idx ON dwh.f_packplandetail USING btree (pack_loc_code, pack_pln_no, pack_pln_ou, pack_lineno);

CREATE INDEX f_packplandetail_key_idx1 ON dwh.f_packplandetail USING btree (pack_pln_hdr_key, pack_pln_dtl_loc_key, pack_pln_dtl_itm_hdr_key, pack_pln_dtl_thu_key);