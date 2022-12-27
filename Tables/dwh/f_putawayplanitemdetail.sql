CREATE TABLE dwh.f_putawayplanitemdetail (
    pway_pln_itm_dtl_key bigint NOT NULL,
    pway_pln_dtl_key bigint NOT NULL,
    pway_pln_itm_dtl_loc_key bigint NOT NULL,
    pway_pln_itm_dtl_itm_hdr_key bigint NOT NULL,
    pway_pln_itm_dtl_zone_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_lineno integer,
    pway_po_no character varying(40) COLLATE public.nocase,
    pway_po_sr_no integer,
    pway_uid character varying(80) COLLATE public.nocase,
    pway_item character varying(80) COLLATE public.nocase,
    pway_zone character varying(20) COLLATE public.nocase,
    pway_allocated_qty numeric(132,0),
    pway_allocated_bin character varying(20) COLLATE public.nocase,
    pway_gr_no character varying(40) COLLATE public.nocase,
    pway_gr_lineno integer,
    pway_gr_lot_no character varying(60) COLLATE public.nocase,
    pway_rqs_conformation integer,
    pway_su_type character varying(20) COLLATE public.nocase,
    pway_su_serial_no character varying(60) COLLATE public.nocase,
    pway_su character varying(20) COLLATE public.nocase,
    pway_from_staging_id character varying(40) COLLATE public.nocase,
    pway_supp_batch_no character varying(60) COLLATE public.nocase,
    pway_thu_serial_no character varying(80) COLLATE public.nocase,
    pway_allocated_staging character varying(40) COLLATE public.nocase,
    pway_cross_dock integer,
    pway_stock_status character varying(20) COLLATE public.nocase,
    pway_staging character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayplanitemdetail ALTER COLUMN pway_pln_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayplanitemdetail_pway_pln_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pkey PRIMARY KEY (pway_pln_itm_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_dtl_key_fkey FOREIGN KEY (pway_pln_dtl_key) REFERENCES dwh.f_putawayplandetail(pway_pln_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (pway_pln_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_loc_key_fkey FOREIGN KEY (pway_pln_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_zone_key_fkey FOREIGN KEY (pway_pln_itm_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_putawayplanitemdetail_key_idx ON dwh.f_putawayplanitemdetail USING btree (pway_pln_dtl_key, pway_pln_itm_dtl_itm_hdr_key, pway_pln_itm_dtl_loc_key, pway_pln_itm_dtl_zone_key);

CREATE INDEX f_putawayplanitemdetail_key_idx1 ON dwh.f_putawayplanitemdetail USING btree (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno, pway_gr_no, pway_item);