CREATE TABLE dwh.f_packitemserialdetail (
    pack_itm_sl_dtl_key bigint NOT NULL,
    pack_itm_sl_dtl_loc_key bigint NOT NULL,
    pack_itm_sl_dtl_itm_hdr_key bigint NOT NULL,
    pack_itm_sl_dtl_thu_key bigint NOT NULL,
    item_sl_loc_code character varying(20) COLLATE public.nocase,
    item_sl_exec_no character varying(40) COLLATE public.nocase,
    item_sl_ou integer,
    item_sl_line_no integer,
    item_sl_thuid character varying(80) COLLATE public.nocase,
    item_sl_itm character varying(80) COLLATE public.nocase,
    item_sl_serno character varying(60) COLLATE public.nocase,
    item_thu_serno character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packitemserialdetail ALTER COLUMN pack_itm_sl_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packitemserialdetail_pack_itm_sl_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pkey PRIMARY KEY (pack_itm_sl_dtl_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_itm_hdr_key_fkey FOREIGN KEY (pack_itm_sl_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_loc_key_fkey FOREIGN KEY (pack_itm_sl_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_thu_key_fkey FOREIGN KEY (pack_itm_sl_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_packitemserialdetail_key_idx ON dwh.f_packitemserialdetail USING btree (pack_itm_sl_dtl_loc_key, pack_itm_sl_dtl_itm_hdr_key, pack_itm_sl_dtl_thu_key);