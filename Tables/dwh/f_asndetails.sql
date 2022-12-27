CREATE TABLE dwh.f_asndetails (
    asn_dtl_key bigint NOT NULL,
    asn_hr_key bigint NOT NULL,
    asn_dtl_loc_key bigint NOT NULL,
    asn_dtl_itm_hdr_key bigint NOT NULL,
    asn_dtl_thu_key bigint NOT NULL,
    asn_dtl_uom_key bigint NOT NULL,
    asn_ou integer,
    asn_location character varying(20) COLLATE public.nocase,
    asn_no character varying(40) COLLATE public.nocase,
    asn_lineno integer,
    asn_line_status character varying(50) COLLATE public.nocase,
    asn_itm_code character varying(80) COLLATE public.nocase,
    asn_qty numeric(20,2),
    asn_batch_no character varying(60) COLLATE public.nocase,
    asn_srl_no character varying(60) COLLATE public.nocase,
    asn_manfct_date timestamp without time zone,
    asn_exp_date timestamp without time zone,
    asn_thu_id character varying(80) COLLATE public.nocase,
    asn_thu_desc character varying(510) COLLATE public.nocase,
    asn_thu_qty numeric(20,2),
    po_lineno integer,
    gr_flag character varying(10) COLLATE public.nocase,
    asn_rec_qty numeric(20,2),
    asn_acc_qty numeric(20,2),
    asn_rej_qty numeric(20,2),
    asn_thu_srl_no character varying(60) COLLATE public.nocase,
    asn_rem character varying(510) COLLATE public.nocase,
    asn_itm_height numeric(20,2),
    asn_itm_volume numeric(20,2),
    asn_itm_weight numeric(20,2),
    asn_order_uom character varying(20) COLLATE public.nocase,
    asn_master_uom_qty numeric(20,2),
    asn_cust_sl_no character varying(60) COLLATE public.nocase,
    asn_ref_doc_no1 character varying(40) COLLATE public.nocase,
    asn_outboundorder_qty numeric(20,2),
    asn_bestbeforedate timestamp without time zone,
    asn_itm_length numeric(20,2),
    asn_itm_breadth numeric(20,2),
    asn_heightuom character varying(20) COLLATE public.nocase,
    asn_weightuom character varying(20) COLLATE public.nocase,
    asn_volumeuom character varying(20) COLLATE public.nocase,
    asn_user_def_1 character varying(510) COLLATE public.nocase,
    asn_user_def_2 numeric(20,2),
    asn_user_def_3 character varying(510) COLLATE public.nocase,
    asn_hold integer,
    asn_stock_status character varying(80) COLLATE public.nocase,
    asn_product_status character varying(80) COLLATE public.nocase,
    asn_coo character varying(100) COLLATE public.nocase,
    asn_item_attribute1 character varying(510) COLLATE public.nocase,
    asn_item_attribute2 character varying(510) COLLATE public.nocase,
    asn_item_attribute3 character varying(510) COLLATE public.nocase,
    asn_itm_cust character varying(40) COLLATE public.nocase,
    asn_cust_po_lineno integer,
    inb_wr_serial_no character varying(60) COLLATE public.nocase,
    asn_lottable1 character varying(512) COLLATE public.nocase,
    asn_lottable2 character varying(512) COLLATE public.nocase,
    asn_lottable3 character varying(512) COLLATE public.nocase,
    asn_item_attribute6 character varying(510) COLLATE public.nocase,
    asn_item_attribute7 character varying(510) COLLATE public.nocase,
    asn_item_attribute9 character varying(510) COLLATE public.nocase,
    asn_component integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    asn_itm_itemgroup character varying(80),
    asn_itm_class character varying(80)
);

ALTER TABLE dwh.f_asndetails ALTER COLUMN asn_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_asndetails_asn_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_pkey PRIMARY KEY (asn_dtl_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_lineno);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_itm_hdr_key_fkey FOREIGN KEY (asn_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_loc_key_fkey FOREIGN KEY (asn_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_thu_key_fkey FOREIGN KEY (asn_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_uom_key_fkey FOREIGN KEY (asn_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

CREATE INDEX f_asndetails_join_idx ON dwh.f_asndetails USING btree (asn_ou, asn_location, asn_no, asn_lineno);

CREATE INDEX f_asndetails_key_idx ON dwh.f_asndetails USING btree (asn_hr_key, asn_dtl_loc_key, asn_dtl_itm_hdr_key, asn_dtl_thu_key, asn_dtl_uom_key);