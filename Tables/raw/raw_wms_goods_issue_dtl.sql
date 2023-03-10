CREATE TABLE raw.raw_wms_goods_issue_dtl (
    raw_id bigint NOT NULL,
    wms_gi_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gi_ou integer NOT NULL,
    wms_gi_status character varying(32) COLLATE public.nocase,
    wms_gi_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gi_outbound_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gi_line_no integer NOT NULL,
    wms_gi_date timestamp without time zone,
    wms_gi_execution_no character varying(72) COLLATE public.nocase,
    wms_gi_execution_stage character varying(100) COLLATE public.nocase,
    wms_gi_outbound_date timestamp without time zone,
    wms_gi_customer_id character varying(72) COLLATE public.nocase,
    wms_gi_prim_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_gi_prim_ref_doc_date timestamp without time zone,
    wms_gi_outbound_ord_line_no integer,
    wms_gi_outbound_ord_sch_no integer,
    wms_gi_outbound_ord_item character varying(128) COLLATE public.nocase,
    wms_gi_issue_qty numeric,
    wms_gi_lot_no character varying(112) COLLATE public.nocase,
    wms_gi_item_serial_no character varying(112) COLLATE public.nocase,
    wms_gi_sup_batch_no character varying(112) COLLATE public.nocase,
    wms_gi_wh_batch_no character varying(112) COLLATE public.nocase,
    wms_gi_mfg_date timestamp without time zone,
    wms_gi_exp_date timestamp without time zone,
    wms_gi_item_status character varying(32) COLLATE public.nocase,
    wms_gi_su character varying(160) COLLATE public.nocase,
    wms_gi_su_type character varying(32) COLLATE public.nocase,
    wms_gi_su_serial_no character varying(112) COLLATE public.nocase,
    wms_gi_created_date timestamp without time zone,
    wms_gi_created_by character varying(120) COLLATE public.nocase,
    wms_gi_modified_date timestamp without time zone,
    wms_gi_modified_by character varying(120) COLLATE public.nocase,
    wms_gi_billing_status character varying(32) COLLATE public.nocase,
    wms_gi_bill_value numeric,
    wms_gi_tolerance_qty numeric,
    wms_gi_hdochpvl_bil_status character varying(32) COLLATE public.nocase,
    wms_gi_lblcthut_bil_status character varying(32) COLLATE public.nocase,
    wms_gi_hdofsupk_bil_status character varying(32) COLLATE public.nocase,
    wms_gi_stock_status character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_goods_issue_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_goods_issue_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_goods_issue_dtl
    ADD CONSTRAINT raw_wms_goods_issue_dtl_pkey PRIMARY KEY (raw_id);