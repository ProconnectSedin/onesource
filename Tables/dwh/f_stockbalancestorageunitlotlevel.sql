CREATE TABLE dwh.f_stockbalancestorageunitlotlevel (
    sbl_lot_level_key bigint NOT NULL,
    sbl_lot_level_wh_key bigint NOT NULL,
    sbl_lot_level_itm_hdr_key bigint NOT NULL,
    sbl_lot_level_zone_key bigint NOT NULL,
    sbl_lot_level_thu_key bigint NOT NULL,
    sbl_wh_code character varying(20) COLLATE public.nocase,
    sbl_ouinstid integer,
    sbl_item_code character varying(80) COLLATE public.nocase,
    sbl_lot_no character varying(60) COLLATE public.nocase,
    sbl_zone character varying(20) COLLATE public.nocase,
    sbl_bin character varying(20) COLLATE public.nocase,
    sbl_su character varying(20) COLLATE public.nocase,
    sbl_su_type character varying(20) COLLATE public.nocase,
    sbl_thu_id character varying(80) COLLATE public.nocase,
    sbl_stock_status character varying(20) COLLATE public.nocase,
    sbl_quantity numeric(132,0),
    sbl_su_serial_no character varying(80) COLLATE public.nocase,
    sbl_wh_bat_no character varying(60) COLLATE public.nocase,
    sbl_supp_bat_no character varying(60) COLLATE public.nocase,
    sbl_ido_no character varying(40) COLLATE public.nocase,
    sbl_gr_no character varying(40) COLLATE public.nocase,
    sbl_trantype character varying(50) COLLATE public.nocase,
    sbl_thu_serial_no character varying(60) COLLATE public.nocase,
    sbl_su_serial_no2 character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockbalancestorageunitlotlevel ALTER COLUMN sbl_lot_level_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockbalancestorageunitlotlevel_sbl_lot_level_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_pkey PRIMARY KEY (sbl_lot_level_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_ukey UNIQUE (sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_stock_status, sbl_su_serial_no, sbl_thu_serial_no, sbl_su_serial_no2);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_itm_hdr_key_fke FOREIGN KEY (sbl_lot_level_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_thu_key_fkey FOREIGN KEY (sbl_lot_level_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_wh_key_fkey FOREIGN KEY (sbl_lot_level_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_zone_key_fkey FOREIGN KEY (sbl_lot_level_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_stockbalancestorageunitlotlevel_key_idx ON dwh.f_stockbalancestorageunitlotlevel USING btree (sbl_lot_level_itm_hdr_key, sbl_lot_level_zone_key, sbl_lot_level_wh_key, sbl_lot_level_thu_key);