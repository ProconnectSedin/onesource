CREATE TABLE dwh.f_pickingdetail (
    pick_dtl_key bigint NOT NULL,
    pick_hdr_key bigint NOT NULL,
    pick_loc_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_exec_no character varying(40) COLLATE public.nocase,
    pick_exec_ou integer,
    pick_lineno integer,
    pick_wave_no character varying(40) COLLATE public.nocase,
    pick_so_no character varying(40) COLLATE public.nocase,
    pick_so_line_no integer,
    pick_sch_lineno integer,
    pick_so_qty numeric(20,2),
    pick_item_code character varying(80) COLLATE public.nocase,
    pick_item_batch_no character varying(60) COLLATE public.nocase,
    pick_item_sr_no character varying(60) COLLATE public.nocase,
    pick_uid_sr_no character varying(40) COLLATE public.nocase,
    pick_qty numeric(20,2),
    pick_zone character varying(20) COLLATE public.nocase,
    pick_bin character varying(40) COLLATE public.nocase,
    pick_bin_qty numeric(20,2),
    pick_plan_line_no integer,
    pick_reason_code character varying(80) COLLATE public.nocase,
    pick_allc_line_no integer,
    pick_lot_no character varying(60) COLLATE public.nocase,
    pick_su character varying(20) COLLATE public.nocase,
    pick_su_serial_no character varying(60) COLLATE public.nocase,
    pick_su_type character varying(20) COLLATE public.nocase,
    pick_thu_id character varying(80) COLLATE public.nocase,
    pick_allocated_qty numeric(20,2),
    pick_thu_serial_no character varying(60) COLLATE public.nocase,
    pick_urgent_cb character varying(510) COLLATE public.nocase,
    pick_exec_thu_wt numeric(20,2),
    pick_exec_thu_wt_uom character varying(20) COLLATE public.nocase,
    pick_length numeric(20,2),
    pick_breadth numeric(20,2),
    pick_height numeric(20,2),
    pick_uom character varying(20) COLLATE public.nocase,
    pick_volumeuom character varying(20) COLLATE public.nocase,
    pick_volume integer,
    pick_weightuom character varying(20) COLLATE public.nocase,
    pick_thuweight numeric(20,2),
    pick_customerserialno character varying(60) COLLATE public.nocase,
    pick_warrantyserialno character varying(60) COLLATE public.nocase,
    pick_counted_blnceqty numeric(20,2),
    pick_staging_id character varying(40) COLLATE public.nocase,
    pick_source_thu_id character varying(80) COLLATE public.nocase,
    pick_source_thu_serial_no character varying(80) COLLATE public.nocase,
    pick_cross_dk_staging_id character varying(40) COLLATE public.nocase,
    pick_stock_status character varying(80) COLLATE public.nocase,
    pick_outbound_no character varying(40) COLLATE public.nocase,
    pick_customer_code character varying(40) COLLATE public.nocase,
    pick_customer_item_code character varying(80) COLLATE public.nocase,
    gift_card_serial_no character varying(60) COLLATE public.nocase,
    warranty_serial_no character varying(60) COLLATE public.nocase,
    pick_ser_flag character varying(20) COLLATE public.nocase,
    pick_ser_date timestamp without time zone,
    pick_su2 character varying(20) COLLATE public.nocase,
    pick_uom1 character varying(20) COLLATE public.nocase,
    pick_su_serial_no2 character varying(60) COLLATE public.nocase,
    pick_system_date timestamp without time zone,
    pick_exec_ml_start_date timestamp without time zone,
    pick_exec_ml_end_date timestamp without time zone,
    pick_targetlocation character varying(510) COLLATE public.nocase,
    pick_item_attribute1 character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    pick_itm_key bigint
);

ALTER TABLE dwh.f_pickingdetail ALTER COLUMN pick_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pickingdetail_pick_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pkey PRIMARY KEY (pick_dtl_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_ukey UNIQUE (pick_loc_code, pick_exec_no, pick_exec_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_hdr_key_fkey FOREIGN KEY (pick_hdr_key) REFERENCES dwh.f_pickingheader(pick_hdr_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_itm_key_fkey FOREIGN KEY (pick_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_loc_key_fkey FOREIGN KEY (pick_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_pickingdetail_key_idx ON dwh.f_pickingdetail USING btree (pick_loc_key, pick_itm_key, pick_hdr_key);

CREATE INDEX f_pickingdetail_key_idx1 ON dwh.f_pickingdetail USING btree (pick_loc_code, pick_exec_no, pick_exec_ou, pick_lineno);

CREATE INDEX f_pickingdetail_key_idx2 ON dwh.f_pickingdetail USING btree (pick_loc_key, pick_so_no);

CREATE INDEX f_pickingdetail_key_idx3 ON dwh.f_pickingdetail USING btree (pick_loc_key, pick_so_no, pick_so_line_no);