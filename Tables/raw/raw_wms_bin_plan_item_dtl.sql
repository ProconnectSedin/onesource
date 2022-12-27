CREATE TABLE raw.raw_wms_bin_plan_item_dtl (
    raw_id bigint NOT NULL,
    wms_bin_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_bin_pln_lineno integer NOT NULL,
    wms_bin_pln_ou integer NOT NULL,
    wms_bin_pln_status character varying(32) COLLATE public.nocase,
    wms_bin_item character varying(128) COLLATE public.nocase,
    wms_bin_item_batch_no character varying(112) COLLATE public.nocase,
    wms_bin_item_sr_no character varying(112) COLLATE public.nocase,
    wms_bin_uid character varying(160) COLLATE public.nocase,
    wms_bin_src_bin character varying(40) COLLATE public.nocase,
    wms_bin_src_zone character varying(40) COLLATE public.nocase,
    wms_bin_su character varying(40) COLLATE public.nocase,
    wms_bin_su_qty numeric,
    wms_bin_avial_qty numeric,
    wms_bin_trn_out_qty numeric,
    wms_bin_tar_bin character varying(40) COLLATE public.nocase,
    wms_bin_tar_zone character varying(40) COLLATE public.nocase,
    wms_bin_trn_in_qty numeric,
    wms_bin_lot_no character varying(112) COLLATE public.nocase,
    wms_bin_su_type character varying(32) COLLATE public.nocase,
    wms_bin_su_slno character varying(112) COLLATE public.nocase,
    wms_bin_uid_slno character varying(112) COLLATE public.nocase,
    wms_bin_thu_typ character varying(32) COLLATE public.nocase,
    wms_bin_thu_id character varying(160) COLLATE public.nocase,
    wms_bin_src_staging_id character varying(72) COLLATE public.nocase,
    wms_bin_trgt_staging_id character varying(72) COLLATE public.nocase,
    wms_bin_stk_line_no integer,
    wms_bin_stk_status character varying(32) COLLATE public.nocase,
    wms_bin_consignee character varying(72) COLLATE public.nocase,
    wms_bin_customer character varying(72) COLLATE public.nocase,
    wms_bin_gr_date timestamp without time zone,
    wms_bin_status character varying(1020) COLLATE public.nocase,
    wms_bin_trans_date timestamp without time zone,
    wms_bin_trans_number character varying(72) COLLATE public.nocase,
    wms_bin_trans_type character varying(160) COLLATE public.nocase,
    wms_bin_src_status character varying(32) COLLATE public.nocase,
    wms_bin_mul_batch_flg character varying(32) COLLATE public.nocase,
    wms_bin_from_thu_sl_no character varying(112) COLLATE public.nocase,
    wms_bin_target_thu_sl_no character varying(112) COLLATE public.nocase,
    wms_bin_pal_status character varying(160) COLLATE public.nocase,
    wms_bin_thu2_sl_no character varying(112) COLLATE public.nocase,
    wms_bin_repl_alloc_ln_no integer,
    wms_bin_repl_doc_line_no integer,
    wms_bin_thu2_id character varying(160) COLLATE public.nocase,
    wms_bin_su2 character varying(40) COLLATE public.nocase,
    wms_bin_su_slno2 character varying(112) COLLATE public.nocase,
    wms_bin_su_qty2 numeric,
    wms_bin_prof_type character varying(32) COLLATE public.nocase,
    wms_bin_trans_uom character varying(40) COLLATE public.nocase,
    wms_bin_trans_uom_qty numeric,
    wms_bin_plan_rsn_code character varying(160) COLLATE public.nocase,
    wms_bin_pln_itm_attr1 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr10 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr2 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr3 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr4 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr5 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr6 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr7 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr8 character varying(200) COLLATE public.nocase,
    wms_bin_pln_itm_attr9 character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_bin_plan_item_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_bin_plan_item_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_bin_plan_item_dtl
    ADD CONSTRAINT raw_wms_bin_plan_item_dtl_pkey PRIMARY KEY (raw_id);