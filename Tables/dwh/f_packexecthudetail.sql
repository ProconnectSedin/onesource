CREATE TABLE dwh.f_packexecthudetail (
    pack_exec_thu_dtl_key bigint NOT NULL,
    pack_exec_hdr_key bigint NOT NULL,
    pack_exec_thu_hdr_key bigint,
    pack_exec_itm_hdr_key bigint,
    pack_exec_loc_key bigint NOT NULL,
    pack_exec_thu_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_thu_id character varying(80) COLLATE public.nocase,
    pack_thu_lineno integer,
    pack_thu_ser_no character varying(60) COLLATE public.nocase,
    pack_picklist_no character varying(40) COLLATE public.nocase,
    pack_so_no character varying(40) COLLATE public.nocase,
    pack_so_line_no integer,
    pack_so_sch_lineno integer,
    pack_thu_item_code character varying(80) COLLATE public.nocase,
    pack_thu_item_qty numeric(25,2),
    pack_thu_pack_qty numeric(25,2),
    pack_thu_item_batch_no character varying(60) COLLATE public.nocase,
    pack_thu_item_sr_no character varying(60) COLLATE public.nocase,
    pack_lot_no character varying(60) COLLATE public.nocase,
    pack_uid1_ser_no character varying(60) COLLATE public.nocase,
    pack_uid_ser_no character varying(60) COLLATE public.nocase,
    pack_allocated_qty numeric(25,2),
    pack_planned_qty numeric(25,2),
    pack_tolerance_qty numeric(25,2),
    pack_packed_from_uid_serno character varying(60) COLLATE public.nocase,
    pack_factory_pack character varying(40) COLLATE public.nocase,
    pack_source_thu_ser_no character varying(80) COLLATE public.nocase,
    pack_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packexecthudetail ALTER COLUMN pack_exec_thu_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packexecthudetail_pack_exec_thu_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pkey PRIMARY KEY (pack_exec_thu_dtl_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_itm_hdr_key_fkey FOREIGN KEY (pack_exec_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_thu_hdr_key_fkey FOREIGN KEY (pack_exec_thu_hdr_key) REFERENCES dwh.f_packexecthuheader(pack_exec_thu_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_hdr_key_fkey FOREIGN KEY (pack_exec_hdr_key) REFERENCES dwh.f_packexecheader(pack_exe_hdr_key);

CREATE INDEX f_packexecthudetail_key_idx ON dwh.f_packexecthudetail USING btree (pack_exec_hdr_key, pack_exec_thu_hdr_key, pack_exec_itm_hdr_key, pack_exec_loc_key, pack_exec_thu_key);

CREATE INDEX f_packexecthudetail_key_idx5 ON dwh.f_packexecthudetail USING btree (pack_exec_ou, pack_loc_code, pack_exec_no, pack_thu_id, pack_thu_lineno, pack_thu_ser_no);

CREATE INDEX f_packexecthudetail_key_idx8 ON dwh.f_packexecthudetail USING btree (pack_exec_loc_key, pack_so_no, pack_so_line_no);