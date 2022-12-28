CREATE TABLE dwh.f_pickplandetails (
    pick_pln_dtl_key bigint NOT NULL,
    pick_pln_hdr_key bigint NOT NULL,
    pick_pln_loc_key bigint NOT NULL,
    pick_pln_item_key bigint NOT NULL,
    pick_pln_thu_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_pln_no character varying(40) COLLATE public.nocase,
    pick_pln_ou integer,
    pick_lineno integer,
    pick_wave_no character varying(40) COLLATE public.nocase,
    pick_so_no character varying(40) COLLATE public.nocase,
    pick_so_line_no integer,
    pick_sch_lineno integer,
    pick_item_code character varying(80) COLLATE public.nocase,
    pick_so_qty numeric(20,2),
    pick_item_batch_no character varying(60) COLLATE public.nocase,
    pick_item_sr_no character varying(60) COLLATE public.nocase,
    pick_uid_sr_no character varying(40) COLLATE public.nocase,
    pick_qty numeric(20,2),
    pick_zone character varying(20) COLLATE public.nocase,
    pick_bin character varying(40) COLLATE public.nocase,
    pick_bin_qty numeric(20,2),
    pick_su character varying(20) COLLATE public.nocase,
    pick_su_serial_no character varying(60) COLLATE public.nocase,
    pick_lot_no character varying(60) COLLATE public.nocase,
    pick_allc_line_no integer,
    pick_su_type character varying(20) COLLATE public.nocase,
    pick_thu_id character varying(80) COLLATE public.nocase,
    pick_rqs_confirm integer,
    pick_allocated_qty numeric(20,2),
    pick_thu_serial_no character varying(60) COLLATE public.nocase,
    pick_pln_urgent integer,
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
    pick_staging_id character varying(40) COLLATE public.nocase,
    pick_source_thu_id character varying(80) COLLATE public.nocase,
    pick_source_thu_serial_no character varying(80) COLLATE public.nocase,
    pick_cross_dk_staging_id character varying(40) COLLATE public.nocase,
    pick_stock_status character varying(80) COLLATE public.nocase,
    pick_outbound_no character varying(40) COLLATE public.nocase,
    pick_customer_code character varying(40) COLLATE public.nocase,
    pick_customer_item_code character varying(80) COLLATE public.nocase,
    warranty_serial_no character varying(60) COLLATE public.nocase,
    gift_card_serial_no character varying(60) COLLATE public.nocase,
    pick_conso_pln_no character varying(40) COLLATE public.nocase,
    pick_line_complete_flag character varying(80) COLLATE public.nocase,
    pick_item_attribute1 character varying(510) COLLATE public.nocase,
    pick_item_attribute3 character varying(510) COLLATE public.nocase,
    pick_item_attribute7 character varying(510) COLLATE public.nocase,
    pick_line_status character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pickplandetails ALTER COLUMN pick_pln_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pickplandetails_pick_pln_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pkey PRIMARY KEY (pick_pln_dtl_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_ukey UNIQUE (pick_loc_code, pick_pln_no, pick_pln_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_hdr_key_fkey FOREIGN KEY (pick_pln_hdr_key) REFERENCES dwh.f_pickplanheader(pick_pln_hdr_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_item_key_fkey FOREIGN KEY (pick_pln_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_loc_key_fkey FOREIGN KEY (pick_pln_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_thu_key_fkey FOREIGN KEY (pick_pln_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_pickplandetails_key_idx ON dwh.f_pickplandetails USING btree (pick_pln_loc_key, pick_pln_item_key, pick_pln_thu_key, pick_pln_hdr_key);

CREATE INDEX f_pickplandetails_key_idx1 ON dwh.f_pickplandetails USING btree (pick_loc_code, pick_pln_no, pick_pln_ou, pick_lineno);