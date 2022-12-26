CREATE TABLE stg.stg_wms_pick_plan_dtl (
    wms_pick_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pick_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pick_pln_ou integer NOT NULL,
    wms_pick_lineno integer NOT NULL,
    wms_pick_wave_no character varying(72) COLLATE public.nocase,
    wms_pick_so_no character varying(72) COLLATE public.nocase,
    wms_pick_so_line_no integer,
    wms_pick_sch_lineno integer,
    wms_pick_item_code character varying(128) COLLATE public.nocase,
    wms_pick_so_qty numeric,
    wms_pick_item_batch_no character varying(112) COLLATE public.nocase,
    wms_pick_item_sr_no character varying(112) COLLATE public.nocase,
    wms_pick_uid_sr_no character varying(72) COLLATE public.nocase,
    wms_pick_qty numeric,
    wms_pick_zone character varying(40) COLLATE public.nocase,
    wms_pick_bin character varying(72) COLLATE public.nocase,
    wms_pick_bin_qty numeric,
    wms_pick_su character varying(40) COLLATE public.nocase,
    wms_pick_su_serial_no character varying(112) COLLATE public.nocase,
    wms_pick_lot_no character varying(112) COLLATE public.nocase,
    wms_pick_allc_line_no integer,
    wms_pick_su_type character varying(32) COLLATE public.nocase,
    wms_pick_thu_id character varying(160) COLLATE public.nocase,
    wms_pick_rqs_confirm integer,
    wms_pick_allocated_qty numeric,
    wms_pick_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_pick_tolerance_qty numeric,
    wms_pick_cons character varying(160) COLLATE public.nocase,
    wms_pick_pln_urgent integer,
    wms_pick_thuspace character varying(160) COLLATE public.nocase,
    wms_pick_length numeric,
    wms_pick_breadth numeric,
    wms_pick_height numeric,
    wms_pick_uom character varying(40) COLLATE public.nocase,
    wms_pick_volumeuom character varying(40) COLLATE public.nocase,
    wms_pick_volume integer,
    wms_pick_weightuom character varying(40) COLLATE public.nocase,
    wms_pick_thuweight numeric,
    wms_pick_customerserialno character varying(112) COLLATE public.nocase,
    wms_pick_warrantyserialno character varying(112) COLLATE public.nocase,
    wms_pick_shelflife numeric,
    wms_pick_counted_blnceqty numeric,
    wms_pick_staging_id character varying(72) COLLATE public.nocase,
    wms_pick_source_thu_id character varying(160) COLLATE public.nocase,
    wms_pick_source_thu_serial_no character varying(160) COLLATE public.nocase,
    wms_pick_cross_dk_staging_id character varying(72) COLLATE public.nocase,
    wms_pick_stock_status character varying(160) COLLATE public.nocase,
    wms_pick_box_thu_id character varying(160) COLLATE public.nocase,
    wms_pick_box_no character varying(72) COLLATE public.nocase,
    wms_pick_outbound_no character varying(72) COLLATE public.nocase,
    wms_pick_customer_code character varying(72) COLLATE public.nocase,
    wms_pick_customer_item_code character varying(128) COLLATE public.nocase,
    wms_warranty_serial_no character varying(112) COLLATE public.nocase,
    wms_gift_card_serial_no character varying(112) COLLATE public.nocase,
    wms_pick_uom1 character varying(40) COLLATE public.nocase,
    wms_pick_su2 character varying(40) COLLATE public.nocase,
    wms_pick_su_serial_no2 character varying(112) COLLATE public.nocase,
    wms_pp_chporcn_sell_bil_status character varying(32) COLLATE public.nocase,
    wms_pick_conso_pln_no character varying(72) COLLATE public.nocase,
    wms_pick_line_complete_flag character varying(160) COLLATE public.nocase,
    wms_pick_multisu_reflineno integer,
    wms_pick_orderuom character varying(40) COLLATE public.nocase,
    wms_pick_masteruomqty numeric,
    wms_pick_orderqty numeric,
    wms_pick_item_attribute1 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute2 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute3 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute4 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute5 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute6 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute7 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute8 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute9 character varying(1020) COLLATE public.nocase,
    wms_pick_item_attribute10 character varying(1020) COLLATE public.nocase,
    wms_pick_zone_su character varying(32) COLLATE public.nocase,
    wms_pick_shrt_flag character varying(48) COLLATE public.nocase,
    wms_pick_line_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);