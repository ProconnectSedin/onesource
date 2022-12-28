CREATE TABLE dwh.f_packexecthudetailhistory (
    pack_exec_thu_dtl_hst_key bigint NOT NULL,
    pack_exec_hdr_key bigint,
    pack_exec_loc_key bigint NOT NULL,
    pack_exec_thu_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_thu_id character varying(80) COLLATE public.nocase,
    pack_thu_lineno integer,
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
    pack_thu_ser_no character varying(60) COLLATE public.nocase,
    pack_uid_ser_no character varying(60) COLLATE public.nocase,
    pack_allocated_qty numeric(25,2),
    pack_planned_qty numeric(25,2),
    pack_tolerance_qty numeric(25,2),
    pack_packed_from_uid_serno character varying(60) COLLATE public.nocase,
    pack_factory_pack character varying(40) COLLATE public.nocase,
    pack_source_thu_ser_no character varying(80) COLLATE public.nocase,
    pack_reason_code character varying(80) COLLATE public.nocase,
    pack_created_by character varying(510) COLLATE public.nocase,
    pack_created_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packexecthudetailhistory ALTER COLUMN pack_exec_thu_dtl_hst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packexecthudetailhistory_pack_exec_thu_dtl_hst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pkey PRIMARY KEY (pack_exec_thu_dtl_hst_key);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pack_exec_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_packexecthudetailhistory_key_idx ON dwh.f_packexecthudetailhistory USING btree (pack_exec_thu_dtl_hst_key);

CREATE INDEX f_packexecthudetailhistory_key_idx2 ON dwh.f_packexecthudetailhistory USING btree (pack_exec_hdr_key);

CREATE INDEX f_packexecthudetailhistory_key_idx3 ON dwh.f_packexecthudetailhistory USING btree (pack_exec_loc_key);

CREATE INDEX f_packexecthudetailhistory_key_idx4 ON dwh.f_packexecthudetailhistory USING btree (pack_exec_thu_key);

CREATE INDEX f_packexecthudetailhistory_key_idx5 ON dwh.f_packexecthudetailhistory USING btree (pack_exec_ou, pack_loc_code, pack_exec_no, pack_thu_id, pack_thu_lineno, pack_thu_ser_no);

CREATE INDEX f_packexecthudetailhistory_key_idx6 ON dwh.f_packexecthudetailhistory USING btree (pack_exec_ou, pack_loc_code, pack_exec_no);