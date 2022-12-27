CREATE TABLE dwh.f_goodsreceiptitemdetails (
    gr_itm_dtl_key bigint NOT NULL,
    gr_dtl_key bigint NOT NULL,
    gr_itm_dtl_loc_key bigint NOT NULL,
    gr_itm_dtl_itm_hdr_key bigint NOT NULL,
    gr_itm_dtl_uom_key bigint NOT NULL,
    gr_itm_dtl_thu_key bigint NOT NULL,
    gr_itm_dtl_stg_mas_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_lineno integer,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_sno character varying(60) COLLATE public.nocase,
    gr_item character varying(80) COLLATE public.nocase,
    gr_item_qty numeric(20,2),
    gr_lot_no character varying(60) COLLATE public.nocase,
    gr_acpt_qty numeric(20,2),
    gr_rej_qty numeric(20,2),
    gr_storage_unit character varying(20) COLLATE public.nocase,
    gr_mas_uom character varying(20) COLLATE public.nocase,
    gr_su_qty numeric(20,2),
    gr_uid_sno character varying(60) COLLATE public.nocase,
    gr_manu_date timestamp without time zone,
    gr_exp_date timestamp without time zone,
    gr_exe_asn_line_no integer,
    gr_exe_wh_bat_no character varying(60) COLLATE public.nocase,
    gr_exe_supp_bat_no character varying(60) COLLATE public.nocase,
    gr_asn_srl_no character varying(60) COLLATE public.nocase,
    gr_asn_uid character varying(80) COLLATE public.nocase,
    gr_asn_cust_sl_no character varying(60) COLLATE public.nocase,
    gr_asn_ref_doc_no1 character varying(40) COLLATE public.nocase,
    gr_asn_consignee character varying(40) COLLATE public.nocase,
    gr_asn_outboundorder_qty numeric(20,2),
    gr_asn_bestbeforedate timestamp without time zone,
    gr_asn_remarks character varying(510) COLLATE public.nocase,
    gr_plan_no character varying(40) COLLATE public.nocase,
    gr_execution_date timestamp without time zone,
    gr_reasoncode character varying(80) COLLATE public.nocase,
    gr_cross_dock character varying(40) COLLATE public.nocase,
    gr_thu_id character varying(80) COLLATE public.nocase,
    gr_thu_sno character varying(60) COLLATE public.nocase,
    gr_stag_id character varying(40) COLLATE public.nocase,
    gr_stock_status character varying(20) COLLATE public.nocase,
    gr_inv_type character varying(80) COLLATE public.nocase,
    gr_product_status character varying(80) COLLATE public.nocase,
    gr_coo character varying(100) COLLATE public.nocase,
    gr_item_attribute1 character varying(510) COLLATE public.nocase,
    gr_item_attribute2 character varying(510) COLLATE public.nocase,
    gr_item_attribute3 character varying(510) COLLATE public.nocase,
    gr_item_in_stage character varying(510) COLLATE public.nocase,
    gr_item_to_stage character varying(510) COLLATE public.nocase,
    gr_pal_status character varying(80) COLLATE public.nocase,
    gr_item_hht_save_flag character varying(20) COLLATE public.nocase,
    gr_updated_from character varying(80) COLLATE public.nocase,
    gr_last_updated_by character varying(510) COLLATE public.nocase,
    gr_item_attribute7 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_goodsreceiptitemdetails ALTER COLUMN gr_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_goodsreceiptitemdetails_gr_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_pkey PRIMARY KEY (gr_itm_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_dtl_key_fkey FOREIGN KEY (gr_dtl_key) REFERENCES dwh.f_goodsreceiptdetails(gr_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (gr_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_loc_key_fkey FOREIGN KEY (gr_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_stg_mas_key_fkey FOREIGN KEY (gr_itm_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_thu_key_fkey FOREIGN KEY (gr_itm_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_uom_key_fkey FOREIGN KEY (gr_itm_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

CREATE INDEX f_goodsreceiptitemdetails_join_idx ON dwh.f_goodsreceiptitemdetails USING btree (gr_exec_no, gr_lineno, gr_loc_code, gr_po_no, gr_item, gr_lineno, gr_exec_ou, gr_exe_asn_line_no);

CREATE INDEX f_goodsreceiptitemdetails_key_idx ON dwh.f_goodsreceiptitemdetails USING btree (gr_dtl_key, gr_itm_dtl_loc_key, gr_itm_dtl_itm_hdr_key, gr_itm_dtl_uom_key, gr_itm_dtl_thu_key, gr_itm_dtl_stg_mas_key);