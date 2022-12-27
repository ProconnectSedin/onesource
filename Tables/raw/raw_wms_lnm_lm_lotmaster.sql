CREATE TABLE raw.raw_wms_lnm_lm_lotmaster (
    raw_id bigint NOT NULL,
    lm_lotno_ou integer NOT NULL,
    lm_wh_code character varying(40) NOT NULL COLLATE public.nocase,
    lm_item_code character varying(128) NOT NULL COLLATE public.nocase,
    lm_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    lm_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    lm_trans_no character varying(72) NOT NULL COLLATE public.nocase,
    lm_trans_type character varying(32) COLLATE public.nocase,
    lm_trans_date timestamp without time zone,
    lm_manufacturing_date timestamp without time zone,
    lm_expiry_date timestamp without time zone,
    lm_created_date timestamp without time zone,
    lm_created_by character varying(120) COLLATE public.nocase,
    lm_supp_batch_no character varying(112) COLLATE public.nocase,
    wms_lm_asn_srl_no character varying(112) COLLATE public.nocase,
    wms_lm_asn_uid character varying(160) COLLATE public.nocase,
    wms_lm_asn_cust_sl_no character varying(112) COLLATE public.nocase,
    wms_lm_asn_ref_doc_no1 character varying(72) COLLATE public.nocase,
    wms_lm_asn_consignee character varying(72) COLLATE public.nocase,
    wms_lm_asn_outboundorder_no character varying(72) COLLATE public.nocase,
    wms_lm_asn_outboundorder_qty numeric,
    wms_lm_asn_outboundorder_lineno integer,
    wms_lm_asn_bestbeforedate timestamp without time zone,
    wms_lm_asn_remarks character varying(1020) COLLATE public.nocase,
    wms_lm_gr_plan_no character varying(72) COLLATE public.nocase,
    wms_lm_gr_execution_date timestamp without time zone,
    wms_lm_exp_flg character varying(32) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    wms_lm_gr_cust_sno character varying(112) COLLATE public.nocase,
    wms_lm_gr_3pl_sno character varying(112) COLLATE public.nocase,
    wms_lm_gr_warranty_sno character varying(112) COLLATE public.nocase,
    wms_lm_gr_coo character varying(200) COLLATE public.nocase,
    wms_lm_gr_product_status character varying(160) COLLATE public.nocase,
    wms_lm_gr_inv_type character varying(160) COLLATE public.nocase,
    wms_lm_gr_item_attribute1 character varying(200) COLLATE public.nocase,
    wms_lm_gr_item_attribute2 character varying(200) COLLATE public.nocase,
    wms_lm_gr_item_attribute3 character varying(200) COLLATE public.nocase,
    wms_lm_gr_item_attribute4 character varying(200) COLLATE public.nocase,
    wms_lm_gr_item_attribute5 character varying(200) COLLATE public.nocase,
    wms_lm_giftcard_sno character varying(112) COLLATE public.nocase,
    wms_lm_gr_item_attribute6 character varying(1020) COLLATE public.nocase,
    wms_lm_gr_item_attribute7 character varying(1020) COLLATE public.nocase,
    wms_lm_gr_item_attribute8 character varying(1020) COLLATE public.nocase,
    wms_lm_gr_item_attribute9 character varying(1020) COLLATE public.nocase,
    wms_lm_gr_item_attribute10 character varying(1020) COLLATE public.nocase,
    wms_lm_new_lottables1 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables2 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables3 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables4 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables5 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables6 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables7 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables8 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables9 character varying(112) COLLATE public.nocase,
    wms_lm_new_lottables10 character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_lnm_lm_lotmaster ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_lnm_lm_lotmaster_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_lnm_lm_lotmaster
    ADD CONSTRAINT raw_wms_lnm_lm_lotmaster_pkey PRIMARY KEY (raw_id);