CREATE TABLE dwh.f_putawayitemdetail (
    pway_itm_dtl_key bigint NOT NULL,
    pway_exe_dtl_key bigint NOT NULL,
    pway_itm_dtl_loc_key bigint NOT NULL,
    pway_itm_dtl_itm_hdr_key bigint NOT NULL,
    pway_itm_dtl_zone_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_exec_no character varying(40) COLLATE public.nocase,
    pway_exec_ou integer,
    pway_exec_lineno integer,
    pway_po_no character varying(40) COLLATE public.nocase,
    pway_po_sr_no integer,
    pway_uid character varying(80) COLLATE public.nocase,
    pway_item character varying(80) COLLATE public.nocase,
    pway_zone character varying(20) COLLATE public.nocase,
    pway_rqs_conformation integer,
    pway_allocated_qty numeric(20,2),
    pway_allocated_bin character varying(20) COLLATE public.nocase,
    pway_actual_bin character varying(20) COLLATE public.nocase,
    pway_actual_bin_qty numeric(20,2),
    pway_gr_no character varying(40) COLLATE public.nocase,
    pway_gr_lineno integer,
    pway_gr_lot_no character varying(60) COLLATE public.nocase,
    pway_su_type character varying(20) COLLATE public.nocase,
    pway_su_serial_no character varying(60) COLLATE public.nocase,
    pway_su character varying(20) COLLATE public.nocase,
    pway_from_staging_id character varying(40) COLLATE public.nocase,
    pway_reason character varying(80) COLLATE public.nocase,
    pway_supp_batch_no character varying(60) COLLATE public.nocase,
    pway_thu_serial_no character varying(80) COLLATE public.nocase,
    pway_cross_dock integer,
    pway_actual_staging character varying(40) COLLATE public.nocase,
    pway_allocated_staging character varying(40) COLLATE public.nocase,
    pway_target_thu_serial_no character varying(60) COLLATE public.nocase,
    pway_stock_status character varying(20) COLLATE public.nocase,
    pway_staging character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayitemdetail ALTER COLUMN pway_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayitemdetail_pway_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pkey PRIMARY KEY (pway_itm_dtl_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou, pway_exec_lineno);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_exe_dtl_key_fkey FOREIGN KEY (pway_exe_dtl_key) REFERENCES dwh.f_putawayexecdetail(pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (pway_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_loc_key_fkey FOREIGN KEY (pway_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_zone_key_fkey FOREIGN KEY (pway_itm_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_putawayitemdetail_key_idx ON dwh.f_putawayitemdetail USING btree (pway_exe_dtl_key, pway_itm_dtl_itm_hdr_key, pway_itm_dtl_loc_key, pway_itm_dtl_zone_key);

CREATE INDEX f_putawayitemdetail_key_idx1 ON dwh.f_putawayitemdetail USING btree (pway_loc_code, pway_exec_no, pway_exec_ou, pway_exec_lineno, pway_gr_lineno, pway_gr_no);