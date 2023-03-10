CREATE TABLE dwh.f_lotmasterdetail (
    lot_mst_dtl_key bigint NOT NULL,
    lot_mst_dtl_itm_hdr_key bigint NOT NULL,
    lot_mst_dtl_wh_key bigint NOT NULL,
    lm_lotno_ou integer,
    lm_wh_code character varying(20) COLLATE public.nocase,
    lm_item_code character varying(80) COLLATE public.nocase,
    lm_lot_no character varying(60) COLLATE public.nocase,
    lm_serial_no character varying(60) COLLATE public.nocase,
    lm_trans_no character varying(40) COLLATE public.nocase,
    lm_trans_type character varying(20) COLLATE public.nocase,
    lm_trans_date timestamp without time zone,
    lm_manufacturing_date timestamp without time zone,
    lm_expiry_date timestamp without time zone,
    lm_created_date timestamp without time zone,
    lm_created_by character varying(60) COLLATE public.nocase,
    lm_supp_batch_no character varying(60) COLLATE public.nocase,
    lm_asn_srl_no character varying(60) COLLATE public.nocase,
    lm_asn_uid character varying(80) COLLATE public.nocase,
    lm_asn_cust_sl_no character varying(60) COLLATE public.nocase,
    lm_asn_ref_doc_no1 character varying(40) COLLATE public.nocase,
    lm_asn_consignee character varying(40) COLLATE public.nocase,
    lm_asn_outboundorder_no character varying(40) COLLATE public.nocase,
    lm_asn_outboundorder_qty numeric(20,2),
    lm_asn_bestbeforedate timestamp without time zone,
    lm_asn_remarks character varying(510) COLLATE public.nocase,
    lm_gr_plan_no character varying(40) COLLATE public.nocase,
    lm_gr_execution_date timestamp without time zone,
    lm_exp_flg character varying(20) COLLATE public.nocase,
    lm_gr_cust_sno character varying(60) COLLATE public.nocase,
    lm_gr_3pl_sno character varying(60) COLLATE public.nocase,
    lm_gr_warranty_sno character varying(60) COLLATE public.nocase,
    lm_gr_coo character varying(100) COLLATE public.nocase,
    lm_gr_product_status character varying(80) COLLATE public.nocase,
    lm_gr_inv_type character varying(80) COLLATE public.nocase,
    lm_gr_item_attribute1 character varying(100) COLLATE public.nocase,
    lm_gr_item_attribute2 character varying(100) COLLATE public.nocase,
    lm_gr_item_attribute3 character varying(100) COLLATE public.nocase,
    lm_giftcard_sno character varying(60) COLLATE public.nocase,
    lm_gr_item_attribute7 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_lotmasterdetail ALTER COLUMN lot_mst_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_lotmasterdetail_lot_mst_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_pkey PRIMARY KEY (lot_mst_dtl_key);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_ukey UNIQUE (lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_lot_mst_dtl_itm_hdr_key_fkey FOREIGN KEY (lot_mst_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_lot_mst_dtl_wh_key_fkey FOREIGN KEY (lot_mst_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

CREATE INDEX f_lotmasterdetail_key_idx ON dwh.f_lotmasterdetail USING btree (lot_mst_dtl_itm_hdr_key, lot_mst_dtl_wh_key);

CREATE INDEX f_lotmasterdetail_key_idx1 ON dwh.f_lotmasterdetail USING btree (lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no);