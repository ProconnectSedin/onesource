CREATE TABLE raw.raw_wms_stock_ledger_dtl (
    raw_id bigint NOT NULL,
    wms_stkled_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_stkled_processed_by character varying(120) COLLATE public.nocase,
    wms_stkled_processed_date timestamp without time zone,
    wms_stkled_gen_from character varying(1020) COLLATE public.nocase,
    wms_stkled_ou integer,
    wms_stkled_loc_code character varying(40) COLLATE public.nocase,
    wms_stkled_trantype character varying(100) COLLATE public.nocase,
    wms_stkled_tranno character varying(72) COLLATE public.nocase,
    wms_stkled_trandate timestamp without time zone,
    wms_stkled_tranou integer,
    wms_stkled_tran_amendno integer,
    wms_stkled_primary_refdocno character varying(72) COLLATE public.nocase,
    wms_stkled_primary_refdoc_type character varying(1020) COLLATE public.nocase,
    wms_stkled_refdoc_no character varying(72) COLLATE public.nocase,
    wms_stkled_refdoc_type character varying(100) COLLATE public.nocase,
    wms_stkled_refdoc_lineno integer,
    wms_stkled_refdoc_schlineno integer,
    wms_stkled_refdoc_date timestamp without time zone,
    wms_stkled_itemlineno integer,
    wms_stkled_item_tracking character varying(80) COLLATE public.nocase,
    wms_stkled_item_code character varying(128) COLLATE public.nocase,
    wms_stkled_quantity numeric,
    wms_stkled_stock_status character varying(160) COLLATE public.nocase,
    wms_stkled_bin character varying(40) COLLATE public.nocase,
    wms_stkled_zone character varying(40) COLLATE public.nocase,
    wms_stkled_supp_batchno character varying(112) COLLATE public.nocase,
    wms_stkled_wh_batchno character varying(112) COLLATE public.nocase,
    wms_stkled_lot_no character varying(112) COLLATE public.nocase,
    wms_stkled_su character varying(40) COLLATE public.nocase,
    wms_stkled_su_serial_no character varying(160) COLLATE public.nocase,
    wms_stkled_serial_no character varying(112) COLLATE public.nocase,
    wms_stkled_thu_id character varying(160) COLLATE public.nocase,
    wms_stkled_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_stkled_stock_add_remove character varying(160) COLLATE public.nocase,
    wms_stkled_stage character varying(100) COLLATE public.nocase,
    wms_stkled_stock_running_qty numeric,
    wms_stkled_stock_available_status character varying(160) COLLATE public.nocase,
    wms_stkled_stock_available_qty numeric,
    wms_stkled_inp_running_qty numeric,
    wms_stkled_inp_add_remove character varying(160) COLLATE public.nocase,
    wms_stkled_stock_stage_classification character varying(160) COLLATE public.nocase,
    wms_stkled_staging_id character varying(72) COLLATE public.nocase,
    wms_stkled_stock_alloc_qty numeric,
    wms_stkled_manu_date timestamp without time zone,
    wms_stkled_exp_date timestamp without time zone,
    wms_stkled_inp_available_qty numeric,
    wms_stkled_virtstk_available_qty numeric,
    wms_stkled_virtstk_current_qty numeric,
    wms_stkled_gi_flag character varying(32) COLLATE public.nocase,
    wms_stkled_invacc_flag character varying(32) COLLATE public.nocase,
    wms_stkled_customer_code character varying(72) COLLATE public.nocase,
    wms_stkled_master_unit character varying(40) COLLATE public.nocase,
    wms_stkled_add_or_remove character varying(32) COLLATE public.nocase,
    wms_stkled_order_no character varying(72) COLLATE public.nocase,
    wms_stkled_tran_status character varying(160) COLLATE public.nocase,
    wms_stkled_identity_no integer NOT NULL,
    wms_stkled_asn_no character varying(72) COLLATE public.nocase,
    wms_stkled_su_type character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_ledger_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_ledger_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_wms_stock_ledger_dtl ALTER COLUMN wms_stkled_identity_no ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_ledger_dtl_wms_stkled_identity_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_ledger_dtl
    ADD CONSTRAINT raw_wms_stock_ledger_dtl_pkey PRIMARY KEY (raw_id);