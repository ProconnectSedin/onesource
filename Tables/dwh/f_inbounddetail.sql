CREATE TABLE dwh.f_inbounddetail (
    inb_dtl_key bigint NOT NULL,
    inb_hdr_key bigint NOT NULL,
    inb_itm_dtl_loc_key bigint NOT NULL,
    inb_itm_dtl_itm_hdr_key bigint NOT NULL,
    inb_loc_code character varying(80) COLLATE public.nocase,
    inb_orderno character varying(510) COLLATE public.nocase,
    inb_lineno integer,
    inb_ou integer,
    inb_item_code character varying(80) COLLATE public.nocase,
    inb_order_qty numeric(20,2),
    inb_alt_uom character varying(20) COLLATE public.nocase,
    inb_sch_type character varying(510) COLLATE public.nocase,
    inb_receipt_date timestamp without time zone,
    inb_item_inst character varying(510) COLLATE public.nocase,
    inb_supp_code character varying(40) COLLATE public.nocase,
    inb_balqty numeric(20,2),
    inb_linestatus character varying(510) COLLATE public.nocase,
    inb_recdqty numeric(20,2),
    inb_accpdqty numeric(20,2),
    inb_itm_grrejdqty numeric(20,2),
    inb_master_uom_qty numeric(20,2),
    inb_stock_status character varying(80) COLLATE public.nocase,
    inb_itm_cust character varying(40) COLLATE public.nocase,
    inb_cust_po_lineno integer,
    inb_batch_no character varying(60) COLLATE public.nocase,
    inb_oe_serial_no character varying(60) COLLATE public.nocase,
    inb_expiry_date timestamp without time zone,
    inb_manu_date timestamp without time zone,
    inb_thu_id character varying(80) COLLATE public.nocase,
    inb_thu_qty numeric(20,2),
    inb_user_def_1 character varying(510) COLLATE public.nocase,
    inb_user_def_2 character varying(510) COLLATE public.nocase,
    inb_user_def_3 character varying(510) COLLATE public.nocase,
    inb_lottable1 character varying(520) COLLATE public.nocase,
    inb_lottable2 character varying(520) COLLATE public.nocase,
    inb_lottable3 character varying(520) COLLATE public.nocase,
    inb_lottable6 character varying(520) COLLATE public.nocase,
    inb_lottable7 character varying(520) COLLATE public.nocase,
    inb_lottable9 character varying(520) COLLATE public.nocase,
    inb_component integer,
    asn_kit_item_lineno integer,
    asn_lineno integer,
    asn_item_po_lineno integer,
    inb_uid1 character varying(60) COLLATE public.nocase,
    inb_item_attribute7 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_inbounddetail ALTER COLUMN inb_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_inbounddetail_inb_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_pkey PRIMARY KEY (inb_dtl_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_hdr_key_fkey FOREIGN KEY (inb_hdr_key) REFERENCES dwh.f_inboundheader(inb_hdr_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (inb_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_itm_dtl_loc_key_fkey FOREIGN KEY (inb_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_inbounddetail_key_idx ON dwh.f_inbounddetail USING btree (inb_itm_dtl_loc_key, inb_itm_dtl_itm_hdr_key);

CREATE INDEX f_inbounddetail_key_idx1 ON dwh.f_inbounddetail USING btree (inb_loc_code, inb_orderno, inb_lineno, inb_ou);