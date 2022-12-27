CREATE TABLE dwh.f_packexecthuheader (
    pack_exec_thu_hdr_key bigint NOT NULL,
    pack_exec_hdr_key bigint NOT NULL,
    pack_exec_loc_key bigint NOT NULL,
    pack_exec_thu_key bigint NOT NULL,
    pack_exec_uom_key bigint NOT NULL,
    pack_exec_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_exec_thu_id character varying(80) COLLATE public.nocase,
    pack_exec_thu_class character varying(80) COLLATE public.nocase,
    pack_exec_thu_sr_no character varying(60) COLLATE public.nocase,
    pack_exec_thu_qty numeric(25,2),
    pack_exec_thu_weight numeric(25,2),
    pack_exec_thu_weight_uom character varying(20) COLLATE public.nocase,
    pack_exec_thu_su_chk integer,
    pack_exec_uid1_ser_no character varying(60) COLLATE public.nocase,
    pack_exec_thuspace numeric(25,2),
    pack_exec_length numeric(25,2),
    pack_exec_breadth numeric(25,2),
    pack_exec_height numeric(25,2),
    pack_exec_uom character varying(20) COLLATE public.nocase,
    pack_exec_volumeuom character varying(20) COLLATE public.nocase,
    pack_exec_volume numeric(25,2),
    pack_exec_itm_serno_pkplan character varying(40) COLLATE public.nocase,
    pack_exec_itemslno character varying(60) COLLATE public.nocase,
    pack_exec_thu_id2 character varying(80) COLLATE public.nocase,
    pack_exec_thu_sr_no2 character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packexecthuheader ALTER COLUMN pack_exec_thu_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packexecthuheader_pack_exec_thu_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pkey PRIMARY KEY (pack_exec_thu_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_ukey UNIQUE (pack_exec_ou, pack_exec_loc_code, pack_exec_no, pack_exec_thu_id, pack_exec_thu_sr_no);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_uom_key_fkey FOREIGN KEY (pack_exec_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_hdr_key_fkey FOREIGN KEY (pack_exec_hdr_key) REFERENCES dwh.f_packexecheader(pack_exe_hdr_key);

CREATE INDEX f_packexecthuheader_key_idx ON dwh.f_packexecthuheader USING btree (pack_exec_hdr_key, pack_exec_loc_key, pack_exec_uom_key, pack_exec_thu_key);

CREATE INDEX f_packexecthuheader_key_idx4 ON dwh.f_packexecthuheader USING btree (pack_exec_ou, pack_exec_loc_code, pack_exec_no, pack_exec_thu_id, pack_exec_thu_sr_no);