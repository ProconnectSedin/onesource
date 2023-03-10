CREATE TABLE stg.stg_wms_stock_conversion_dtl (
    wms_stk_con_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_con_proposal_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_con_proposal_ou integer NOT NULL,
    wms_stk_con_lineno integer NOT NULL,
    wms_stk_con_cust_no character varying(72) COLLATE public.nocase,
    wms_stk_con_item_code character varying(128) COLLATE public.nocase,
    wms_stk_con_item_batch_no character varying(72) COLLATE public.nocase,
    wms_stk_con_item_sr_no character varying(112) COLLATE public.nocase,
    wms_stk_con_bin character varying(40) COLLATE public.nocase,
    wms_stk_con_qty numeric,
    wms_stk_con_from_status character varying(32) COLLATE public.nocase,
    wms_stk_con_to_status character varying(32) COLLATE public.nocase,
    wms_stk_con_target_bin character varying(72) COLLATE public.nocase,
    wms_stk_con_from_qty numeric,
    wms_stk_con_to_qty numeric,
    wms_stk_con_status character varying(32) COLLATE public.nocase,
    wms_stk_con_remarks character varying(1020) COLLATE public.nocase,
    wms_stk_con_su character varying(1020) COLLATE public.nocase,
    wms_stk_con_uid_serial_no character varying(1020) COLLATE public.nocase,
    wms_stk_con_zone character varying(40) COLLATE public.nocase,
    wms_stk_con_batchno character varying(112) COLLATE public.nocase,
    wms_stk_con_source_staging_id character varying(72) COLLATE public.nocase,
    wms_stk_con_tar_bin character varying(40) COLLATE public.nocase,
    wms_stk_gr_line_no integer,
    wms_stk_gr_exec_no character varying(72) COLLATE public.nocase,
    wms_stk_con_res_code character varying(1020) COLLATE public.nocase,
    wms_stk_wrtoff_qlty_ctrl integer,
    wms_stk_wrtoff_qlty integer,
    wms_stk_con_stksts character varying(32) COLLATE public.nocase,
    wms_stk_con_from_thu_srno character varying(112) COLLATE public.nocase,
    wms_stk_con_target_thu_srno character varying(112) COLLATE public.nocase,
    wms_stk_con_coo character varying(200) COLLATE public.nocase,
    wms_stk_con_inven_type character varying(160) COLLATE public.nocase,
    wms_stk_con_item_atrib1 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib2 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib3 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib4 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib5 character varying(200) COLLATE public.nocase,
    wms_stk_con_prod_status character varying(160) COLLATE public.nocase,
    wms_stk_con_thu_type character varying(160) COLLATE public.nocase,
    wms_stk_con_stk_lineno integer,
    wms_stk_con_curr_stock_qty numeric,
    wms_stk_con_su1_qty numeric,
    wms_stk_con_su2 character varying(1020) COLLATE public.nocase,
    wms_stk_con_uid_serial_no2 character varying(1020) COLLATE public.nocase,
    wms_stk_con_su2_qty numeric,
    wms_stk_con_qty_uom character varying(40) COLLATE public.nocase,
    wms_stk_con_profile_type character varying(40) COLLATE public.nocase,
    wms_stk_con_mas_to_qty numeric,
    wms_stk_con_item_atrib6 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib7 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib8 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib9 character varying(200) COLLATE public.nocase,
    wms_stk_con_item_atrib10 character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stock_conversion_dtl
    ADD CONSTRAINT wms_stock_conversion_dtl_pk PRIMARY KEY (wms_stk_con_loc_code, wms_stk_con_proposal_no, wms_stk_con_proposal_ou, wms_stk_con_lineno);