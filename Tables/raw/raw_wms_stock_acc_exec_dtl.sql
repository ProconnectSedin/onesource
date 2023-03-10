CREATE TABLE raw.raw_wms_stock_acc_exec_dtl (
    raw_id bigint NOT NULL,
    wms_stk_acc_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_pln_ou integer NOT NULL,
    wms_stk_acc_lineno integer NOT NULL,
    wms_stk_acc_zone character varying(40) COLLATE public.nocase,
    wms_stk_acc_aisle character varying(40) COLLATE public.nocase,
    wms_stk_acc_bin character varying(40) COLLATE public.nocase,
    wms_stk_acc_item character varying(128) COLLATE public.nocase,
    wms_stk_acc_item_class character varying(160) COLLATE public.nocase,
    wms_stk_acc_su character varying(40) COLLATE public.nocase,
    wms_stk_acc_su_qty numeric,
    wms_stk_acc_count_qty numeric,
    wms_stk_acc_recount integer,
    wms_stk_acc_expln_lin_no integer,
    wms_stk_acc_lotno character varying(112) COLLATE public.nocase,
    wms_stk_acc_serialno character varying(112) COLLATE public.nocase,
    wms_stk_acc_batchno character varying(112) COLLATE public.nocase,
    wms_stk_acc_quantity numeric,
    wms_stk_acc_uidserialno character varying(112) COLLATE public.nocase,
    wms_stk_acc_ex_line_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_reason_code character varying(160) COLLATE public.nocase,
    wms_stk_acc_stock_status character varying(160) COLLATE public.nocase,
    wms_zero_stock_flag character varying(160) COLLATE public.nocase,
    wms_stk_acc_discard integer,
    wms_stk_acc_uidserialno2 character varying(112) COLLATE public.nocase,
    wms_stk_acc_new_lot_flg character varying(160) COLLATE public.nocase,
    wms_stk_acc_shortage_qty numeric,
    wms_stk_acc_excess_qty numeric,
    wms_stk_acc_new_lot_no character varying(112) COLLATE public.nocase,
    wms_stk_acc_item_qty numeric,
    wms_stk_acc_bin_flag character varying(48) COLLATE public.nocase,
    wms_stk_acc_ass_lineno integer,
    wms_stk_acc_su2 character varying(40) COLLATE public.nocase,
    wms_expiry_date timestamp without time zone,
    wms_stk_acc_sys_feedback character varying(1020) COLLATE public.nocase,
    wms_stk_acc_complete_flag character varying(160) COLLATE public.nocase,
    wms_stk_acc_su2_qty numeric,
    wms_stk_acc_addline_flag character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_acc_exec_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_acc_exec_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_acc_exec_dtl
    ADD CONSTRAINT raw_wms_stock_acc_exec_dtl_pkey PRIMARY KEY (raw_id);