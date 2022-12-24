CREATE TABLE raw.raw_wms_gr_exec_item_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_exec_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_po_sno character varying(112) COLLATE public.nocase,
    wms_gr_item character varying(128) COLLATE public.nocase,
    wms_gr_item_qty numeric,
    wms_gr_lot_no character varying(112) COLLATE public.nocase,
    wms_gr_acpt_qty numeric,
    wms_gr_rej_qty numeric,
    wms_gr_storage_unit character varying(40) COLLATE public.nocase,
    wms_gr_consuambles character varying(128) COLLATE public.nocase,
    wms_gr_consum_qty numeric,
    wms_gr_mas_uom character varying(40) COLLATE public.nocase,
    wms_gr_su_qty numeric,
    wms_gr_asn_line_no integer,
    wms_gr_uid_sno character varying(112) COLLATE public.nocase,
    wms_gr_manu_date timestamp without time zone,
    wms_gr_exp_date timestamp without time zone,
    wms_gr_exe_asn_line_no integer,
    wms_gr_exe_wh_bat_no character varying(112) COLLATE public.nocase,
    wms_gr_exe_supp_bat_no character varying(112) COLLATE public.nocase,
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
    wms_gr_plan_no character varying(72) COLLATE public.nocase,
    wms_gr_execution_date timestamp without time zone,
    wms_gr_reasoncode character varying(160) COLLATE public.nocase,
    wms_gr_cross_dock character varying(80) COLLATE public.nocase,
    wms_gr_thu_id character varying(160) COLLATE public.nocase,
    wms_gr_thu_sno character varying(112) COLLATE public.nocase,
    wms_gr_stag_id character varying(72) COLLATE public.nocase,
    wms_gr_stock_status character varying(32) COLLATE public.nocase,
    wms_gr_inv_type character varying(160) COLLATE public.nocase,
    wms_gr_product_status character varying(160) COLLATE public.nocase,
    wms_gr_coo character varying(200) COLLATE public.nocase,
    wms_gr_item_attribute1 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute2 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute3 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute4 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute5 character varying(1020) COLLATE public.nocase,
    wms_gr_item_thu_type character varying(160) COLLATE public.nocase,
    wms_gr_item_in_stage character varying(1020) COLLATE public.nocase,
    wms_gr_item_to_stage character varying(1020) COLLATE public.nocase,
    wms_gr_pal_status character varying(160) COLLATE public.nocase,
    wms_gr_su2_qty numeric,
    wms_gr_uid2_sno character varying(112) COLLATE public.nocase,
    wms_gr_storage_unit2 character varying(40) COLLATE public.nocase,
    wms_gr_item_hht_save_flag character varying(40) COLLATE public.nocase,
    wms_gr_ins_exp_date timestamp without time zone,
    wms_gr_ins_manu_date timestamp without time zone,
    wms_gr_ins_bstbfr_date timestamp without time zone,
    wms_gr_ins_more_coo character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_inv_type character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_itm_attb1 character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_itm_attb2 character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_itm_attb3 character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_itm_attb4 character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_itm_attb5 character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_prod_stus character varying(1020) COLLATE public.nocase,
    wms_gr_ins_more_su_img character varying(1020) COLLATE public.nocase,
    wms_gr_uid_serialno2 character varying(112) COLLATE public.nocase,
    wms_gr_uid_su2 character varying(40) COLLATE public.nocase,
    wms_gr_su1_conv_flg character varying(32) COLLATE public.nocase,
    wms_gr_su2_conv_flg character varying(32) COLLATE public.nocase,
    wms_gr_su1_tog integer,
    wms_gr_su2_tog integer,
    wms_gr_updated_from character varying(160) COLLATE public.nocase,
    wms_gr_last_updated_by character varying(1020) COLLATE public.nocase,
    wms_gr_last_updated_datetime timestamp without time zone,
    wms_gr_item_attribute6 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute7 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute8 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute9 character varying(1020) COLLATE public.nocase,
    wms_gr_item_attribute10 character varying(1020) COLLATE public.nocase,
    wms_gr_qulinfee_bil_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);