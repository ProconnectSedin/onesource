CREATE TABLE stg.stg_wms_bin_exec_item_detail (
    wms_bin_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_bin_exec_lineno integer NOT NULL,
    wms_bin_ref_lineno integer NOT NULL,
    wms_bin_exec_ou integer NOT NULL,
    wms_bin_item character varying(128) COLLATE public.nocase,
    wms_bin_src_bin character varying(40) COLLATE public.nocase,
    wms_bin_src_zone character varying(40) COLLATE public.nocase,
    wms_bin_src_staging_id character varying(72) COLLATE public.nocase,
    wms_bin_stk_avial_qty numeric,
    wms_bin_trn_out_qty numeric,
    wms_bin_tar_bin character varying(40) COLLATE public.nocase,
    wms_bin_tar_zone character varying(40) COLLATE public.nocase,
    wms_bin_trgt_staging_id character varying(72) COLLATE public.nocase,
    wms_bin_lot_no character varying(112) COLLATE public.nocase,
    wms_bin_item_sr_no character varying(112) COLLATE public.nocase,
    wms_bin_item_batch_no character varying(112) COLLATE public.nocase,
    wms_bin_su_slno character varying(112) COLLATE public.nocase,
    wms_bin_su_type character varying(32) COLLATE public.nocase,
    wms_bin_stk_line_no integer,
    wms_bin_stk_status character varying(32) COLLATE public.nocase,
    wms_bin_src_status character varying(32) COLLATE public.nocase,
    wms_bin_from_thu_sl_no character varying(112) COLLATE public.nocase,
    wms_bin_target_thu_sl_no character varying(112) COLLATE public.nocase,
    wms_bin_su character varying(40) COLLATE public.nocase,
    wms_bin_su2 character varying(40) COLLATE public.nocase,
    wms_bin_su_slno2 character varying(112) COLLATE public.nocase,
    wms_bin_thu_id character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_bin_exec_item_detail
    ADD CONSTRAINT wms_bin_exec_item_detail_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_exec_no, wms_bin_exec_lineno, wms_bin_ref_lineno, wms_bin_exec_ou);