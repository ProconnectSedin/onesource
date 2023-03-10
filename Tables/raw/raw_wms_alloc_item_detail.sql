CREATE TABLE raw.raw_wms_alloc_item_detail (
    raw_id bigint NOT NULL,
    allc_ouinstid integer NOT NULL,
    allc_doc_no character varying(512) NOT NULL COLLATE public.nocase,
    allc_doc_ou integer NOT NULL,
    allc_doc_line_no integer NOT NULL,
    allc_alloc_line_no integer NOT NULL,
    allc_order_no character varying(72) COLLATE public.nocase,
    allc_order_line_no integer,
    allc_order_sch_no integer,
    allc_item_code character varying(128) COLLATE public.nocase,
    allc_wh_no character varying(40) COLLATE public.nocase,
    allc_zone_no character varying(40) COLLATE public.nocase,
    allc_bin_no character varying(40) COLLATE public.nocase,
    allc_lot_no character varying(112) COLLATE public.nocase,
    allc_batch_no character varying(112) COLLATE public.nocase,
    allc_serial_no character varying(112) COLLATE public.nocase,
    allc_su character varying(40) COLLATE public.nocase,
    allc_su_serial_no character varying(112) COLLATE public.nocase,
    allc_su_type character varying(32) COLLATE public.nocase,
    allc_thu_id character varying(160) COLLATE public.nocase,
    allc_tran_qty numeric,
    allc_allocated_qty numeric,
    allc_mas_uom character varying(40) COLLATE public.nocase,
    allc_created_date timestamp without time zone,
    allc_modified_date timestamp without time zone,
    allc_created_by character varying(120) COLLATE public.nocase,
    allc_modified_by character varying(120) COLLATE public.nocase,
    allc_tolerance_qty numeric,
    allc_thu_serial_no character varying(112) COLLATE public.nocase,
    allc_stock_status character varying(160) COLLATE public.nocase,
    allc_inpro_stage character varying(32) COLLATE public.nocase,
    allc_staging_id_crosdk character varying(72) COLLATE public.nocase,
    allc_inpro_stk_serial_line_no integer,
    allc_inpro_stk_line_no integer,
    allc_box_thu_id character varying(160) COLLATE public.nocase,
    allc_box_no character varying(72) COLLATE public.nocase,
    allc_su2 character varying(40) COLLATE public.nocase,
    allc_su_serial_no2 character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_alloc_item_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_alloc_item_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_alloc_item_detail
    ADD CONSTRAINT raw_wms_alloc_item_detail_pkey PRIMARY KEY (raw_id);