CREATE TABLE dwh.f_pogritemdetail (
    gr_itm_dtl_key bigint NOT NULL,
    gr_pln_key bigint NOT NULL,
    gr_po_loc_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_pln_no character varying(40) COLLATE public.nocase,
    gr_pln_ou integer,
    gr_lineno integer,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_sno character varying(60) COLLATE public.nocase,
    gr_item character varying(80) COLLATE public.nocase,
    gr_item_desc character varying(1500) COLLATE public.nocase,
    gr_qty numeric(13,2),
    gr_mas_uom character varying(20) COLLATE public.nocase,
    gr_asn_line_no integer,
    gr_asn_srl_no character varying(60) COLLATE public.nocase,
    gr_asn_cust_sl_no character varying(60) COLLATE public.nocase,
    gr_asn_ref_doc_no1 character varying(40) COLLATE public.nocase,
    gr_asn_outboundorder_qty numeric(13,2),
    gr_asn_remarks character varying(510) COLLATE public.nocase,
    gr_fully_executed character varying(20) COLLATE public.nocase,
    gr_asn_stock_status character varying(80) COLLATE public.nocase,
    gr_product_status character varying(80) COLLATE public.nocase,
    gr_coo character varying(100) COLLATE public.nocase,
    gr_item_attribute1 character varying(510) COLLATE public.nocase,
    gr_item_attribute2 character varying(510) COLLATE public.nocase,
    gr_item_attribute3 character varying(510) COLLATE public.nocase,
    gr_item_attribute7 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pogritemdetail ALTER COLUMN gr_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pogritemdetail_gr_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_pkey PRIMARY KEY (gr_itm_dtl_key);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_gr_pln_key_fkey FOREIGN KEY (gr_pln_key) REFERENCES dwh.f_grplandetail(gr_pln_key);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_gr_po_loc_key_fkey FOREIGN KEY (gr_po_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_pogritemdetail_key_idx ON dwh.f_pogritemdetail USING btree (gr_po_loc_key);

CREATE INDEX f_pogritemdetail_key_idx1 ON dwh.f_pogritemdetail USING btree (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);