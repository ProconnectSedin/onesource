CREATE TABLE dwh.f_stockbalanceseriallevel (
    sbs_level_key bigint NOT NULL,
    sbs_level_wh_key bigint NOT NULL,
    sbs_level_itm_hdr_key bigint NOT NULL,
    sbs_level_zone_key bigint NOT NULL,
    sbs_wh_code character varying(20) COLLATE public.nocase,
    sbs_ouinstid integer,
    sbs_item_code character varying(80) COLLATE public.nocase,
    sbs_sr_no character varying(60) COLLATE public.nocase,
    sbs_zone character varying(20) COLLATE public.nocase,
    sbs_bin character varying(20) COLLATE public.nocase,
    sbs_stock_status character varying(80) COLLATE public.nocase,
    sbs_lot_no character varying(60) COLLATE public.nocase,
    sbs_quantity numeric(132,0),
    sbs_wh_bat_no character varying(60) COLLATE public.nocase,
    sbs_supp_bat_no character varying(60) COLLATE public.nocase,
    sbs_ido_no character varying(40) COLLATE public.nocase,
    sbs_gr_no character varying(40) COLLATE public.nocase,
    sbs_trantype character varying(50) COLLATE public.nocase,
    sbs_customer_serial_no character varying(60) COLLATE public.nocase,
    sbs_3pl_serial_no character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockbalanceseriallevel ALTER COLUMN sbs_level_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockbalanceseriallevel_sbs_level_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_pkey PRIMARY KEY (sbs_level_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_ukey UNIQUE (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_itm_hdr_key_fkey FOREIGN KEY (sbs_level_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_wh_key_fkey FOREIGN KEY (sbs_level_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_zone_key_fkey FOREIGN KEY (sbs_level_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_stockbalanceseriallevel_key_idx ON dwh.f_stockbalanceseriallevel USING btree (sbs_level_itm_hdr_key, sbs_level_zone_key, sbs_level_wh_key);