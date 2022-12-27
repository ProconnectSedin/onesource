CREATE TABLE raw.raw_wms_gr_po_item_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_pln_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_po_sno character varying(112) COLLATE public.nocase,
    wms_gr_item character varying(128) COLLATE public.nocase,
    wms_gr_item_desc character varying(3000) COLLATE public.nocase,
    wms_gr_qty numeric,
    wms_gr_mas_uom character varying(40) COLLATE public.nocase,
    wms_gr_asn_line_no integer,
    wms_gr_asn_srl_no character varying(112) COLLATE public.nocase,
    wms_gr_asn_uid character varying(160) COLLATE public.nocase,
    wms_gr_asn_cust_sl_no character varying(112) COLLATE public.nocase,
    wms_gr_asn_ref_doc_no1 character varying(72) COLLATE public.nocase,
    wms_gr_asn_consignee character varying(72) COLLATE public.nocase,
    wms_gr_asn_outboundorder_no character varying(72) COLLATE public.nocase,
    wms_gr_asn_outboundorder_qty numeric,
    wms_gr_asn_outboundorder_lineno integer,
    wms_gr_asn_bestbeforedate timestamp without time zone,
    wms_gr_asn_remarks character varying(1020) COLLATE public.nocase,
    wms_gr_fully_executed character varying(40) COLLATE public.nocase,
    wms_gr_asn_stock_status character varying(160) COLLATE public.nocase,
    wms_gr_inv_type character varying(160) COLLATE public.nocase,
    wms_gr_product_status character varying(160) COLLATE public.nocase,
    wms_gr_coo character varying(200) COLLATE public.nocase,
    wms_gr_item_attribute1 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute2 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute3 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute4 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute5 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute6 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute7 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute8 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute9 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute10 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_po_item_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_po_item_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_po_item_dtl
    ADD CONSTRAINT raw_wms_gr_po_item_dtl_pkey PRIMARY KEY (raw_id);