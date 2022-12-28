CREATE TABLE raw.raw_wms_outbound_item_detail (
    raw_id bigint NOT NULL,
    wms_oub_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_itm_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_itm_lineno integer NOT NULL,
    wms_oub_item_code character varying(128) COLLATE public.nocase,
    wms_oub_itm_order_qty numeric,
    wms_oub_itm_sch_type character varying(1020) COLLATE public.nocase,
    wms_oub_itm_balqty numeric,
    wms_oub_itm_issueqty numeric,
    wms_oub_itm_processqty numeric,
    wms_oub_itm_masteruom character varying(40) COLLATE public.nocase,
    wms_oub_itm_deliverydate timestamp without time zone,
    wms_oub_itm_serfrom timestamp without time zone,
    wms_oub_itm_serto timestamp without time zone,
    wms_oub_itm_plan_gd_iss_dt timestamp without time zone,
    wms_oub_itm_plan_dt_iss timestamp without time zone,
    wms_oub_itm_sub_rules character varying(1020) COLLATE public.nocase,
    wms_oub_itm_pack_remarks character varying(1020) COLLATE public.nocase,
    wms_oub_itm_su character varying(40) COLLATE public.nocase,
    wms_oub_itm_cust_itm_code character varying(128) COLLATE public.nocase,
    wms_oub_itm_mas_qty numeric,
    wms_oub_itm_order_item character varying(40) COLLATE public.nocase,
    wms_oub_itm_lotsl_batchno character varying(112) COLLATE public.nocase,
    wms_oub_itm_cus_srno character varying(280) COLLATE public.nocase,
    wms_oub_itm_refdocno1 character varying(72) COLLATE public.nocase,
    wms_oub_itm_refdocno2 character varying(72) COLLATE public.nocase,
    wms_oub_itm_serialno character varying(112) COLLATE public.nocase,
    wms_oub_itm_thu_id character varying(160) COLLATE public.nocase,
    wms_oub_itm_thu_srno character varying(112) COLLATE public.nocase,
    wms_oub_itm_inst character varying(160) COLLATE public.nocase,
    wms_oub_itm_uid_serial_no character varying(112) COLLATE public.nocase,
    wms_oub_itm_tolerance numeric,
    wms_oub_itm_user_def_1 character varying(1020) COLLATE public.nocase,
    wms_oub_itm_user_def_2 numeric,
    wms_oub_itm_user_def_3 character varying(1020) COLLATE public.nocase,
    wms_oub_itm_shelflife numeric,
    wms_oub_itm_stock_sts character varying(160) COLLATE public.nocase,
    wms_oub_break_attribute character varying(160) COLLATE public.nocase,
    wms_oub_country_of_origin character varying(200) COLLATE public.nocase,
    wms_oub_itm_cust character varying(72) COLLATE public.nocase,
    wms_oub_itm_inv_type character varying(160) COLLATE public.nocase,
    wms_oub_itm_coo_ml character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute1 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute2 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute3 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute4 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute5 character varying(200) COLLATE public.nocase,
    wms_oub_itm_prod_status character varying(160) COLLATE public.nocase,
    wms_oub_itm_cancel integer,
    wms_oub_itm_cancel_code character varying(160) COLLATE public.nocase,
    wms_oub_opbopitp_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_gmvchrgs_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_gmvchrgs_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_itm_component integer,
    wms_oub_shchdrop_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_gmvcdrop_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_gmvcdrop_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_shchdrop_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_itm_kit_lineno integer,
    wms_oub_itm_ratio integer,
    wms_oub_txchsdrs_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_txchsdrb_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_itm_wave_no character varying(72) COLLATE public.nocase,
    wms_oub_ccmiorfe_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_oub_gmvchmus_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_oub_ccaufbos_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_oub_ffcgvsml_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_oub_markmior_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_markaufe_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_oub_gmvchmus_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_txcsemse_buy_bil_status character varying(32) COLLATE public.nocase,
    wms_oub_itm_arribute6 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute7 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute8 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute9 character varying(200) COLLATE public.nocase,
    wms_oub_itm_arribute10 character varying(200) COLLATE public.nocase,
    wms_oub_cupkslch_sell_bil_status character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_outbound_item_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_outbound_item_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_outbound_item_detail
    ADD CONSTRAINT raw_wms_outbound_item_detail_pkey PRIMARY KEY (raw_id);