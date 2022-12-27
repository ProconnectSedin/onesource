CREATE TABLE dwh.f_itemallocdetail (
    allc_dtl_key bigint NOT NULL,
    allc_itm_hdr_key bigint NOT NULL,
    allc_wh_key bigint NOT NULL,
    allc_zone_key bigint NOT NULL,
    allc_thu_key bigint NOT NULL,
    allc_uom_key bigint NOT NULL,
    allc_stg_mas_key bigint NOT NULL,
    allc_ouinstid integer,
    allc_doc_no character varying(300) COLLATE public.nocase,
    allc_doc_ou integer,
    allc_doc_line_no integer,
    allc_alloc_line_no integer,
    allc_order_no character varying(40) COLLATE public.nocase,
    allc_order_line_no integer,
    allc_order_sch_no integer,
    allc_item_code character varying(80) COLLATE public.nocase,
    allc_wh_no character varying(20) COLLATE public.nocase,
    allc_zone_no character varying(20) COLLATE public.nocase,
    allc_bin_no character varying(20) COLLATE public.nocase,
    allc_lot_no character varying(60) COLLATE public.nocase,
    allc_batch_no character varying(60) COLLATE public.nocase,
    allc_serial_no character varying(60) COLLATE public.nocase,
    allc_su character varying(20) COLLATE public.nocase,
    allc_su_serial_no character varying(60) COLLATE public.nocase,
    allc_su_type character varying(20) COLLATE public.nocase,
    allc_thu_id character varying(80) COLLATE public.nocase,
    allc_tran_qty numeric(20,2),
    allc_allocated_qty numeric(20,2),
    allc_mas_uom character varying(20) COLLATE public.nocase,
    allc_created_by character varying(60) COLLATE public.nocase,
    allc_created_date timestamp without time zone,
    allc_modified_by character varying(60) COLLATE public.nocase,
    allc_modified_date timestamp without time zone,
    allc_thu_serial_no character varying(60) COLLATE public.nocase,
    allc_stock_status character varying(80) COLLATE public.nocase,
    allc_inpro_stage character varying(20) COLLATE public.nocase,
    allc_staging_id_crosdk character varying(40) COLLATE public.nocase,
    allc_inpro_stk_serial_line_no integer,
    allc_inpro_stk_line_no integer,
    allc_su2 character varying(20) COLLATE public.nocase,
    allc_su_serial_no2 character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_itemallocdetail ALTER COLUMN allc_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_itemallocdetail_allc_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_pkey PRIMARY KEY (allc_dtl_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_ukey UNIQUE (allc_doc_no, allc_doc_line_no, allc_alloc_line_no, allc_doc_ou);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_itm_hdr_key_fkey FOREIGN KEY (allc_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_stg_mas_key_fkey FOREIGN KEY (allc_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_thu_key_fkey FOREIGN KEY (allc_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_uom_key_fkey FOREIGN KEY (allc_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_wh_key_fkey FOREIGN KEY (allc_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_zone_key_fkey FOREIGN KEY (allc_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_itemallocdetail_key_idx ON dwh.f_itemallocdetail USING btree (allc_itm_hdr_key, allc_wh_key, allc_zone_key, allc_thu_key, allc_uom_key, allc_stg_mas_key);

CREATE INDEX f_itemallocdetail_key_idx1 ON dwh.f_itemallocdetail USING btree (allc_doc_no, allc_doc_line_no, allc_alloc_line_no, allc_doc_ou);