CREATE TABLE dwh.f_grthulotdetail (
    gr_lot_key bigint NOT NULL,
    gr_lot_loc_key bigint NOT NULL,
    gr_lot_thu_key bigint NOT NULL,
    gr_lot_thu_item_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_thu_id character varying(80) COLLATE public.nocase,
    gr_lot_thu_sno character varying(60) COLLATE public.nocase,
    gr_line_no integer,
    gr_item_line_no integer,
    gr_item_code character varying(80) COLLATE public.nocase,
    gr_lot_no character varying(60) COLLATE public.nocase,
    gr_qty numeric(13,2),
    gr_thu_uid_sr_no character varying(80) COLLATE public.nocase,
    gr_thu_lot_su character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_grthulotdetail ALTER COLUMN gr_lot_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grthulotdetail_gr_lot_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_pkey PRIMARY KEY (gr_lot_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_lot_thu_sno, gr_line_no, gr_thu_uid_sr_no, gr_thu_lot_su);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_loc_key_fkey FOREIGN KEY (gr_lot_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_thu_item_key_fkey FOREIGN KEY (gr_lot_thu_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_thu_key_fkey FOREIGN KEY (gr_lot_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_grthulotdetail_key_idx ON dwh.f_grthulotdetail USING btree (gr_lot_loc_key, gr_lot_thu_key, gr_lot_thu_item_key);

CREATE INDEX f_grthulotdetail_key_idx1 ON dwh.f_grthulotdetail USING btree (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_lot_thu_sno, gr_line_no, gr_thu_uid_sr_no, gr_thu_lot_su);