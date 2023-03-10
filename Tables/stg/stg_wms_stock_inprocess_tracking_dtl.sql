CREATE TABLE stg.stg_wms_stock_inprocess_tracking_dtl (
    wms_stk_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_ou integer NOT NULL,
    wms_stk_ref_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_ref_doc_type character varying(100) NOT NULL COLLATE public.nocase,
    wms_stk_ref_doc_line_no integer NOT NULL,
    wms_stk_ref_doc_sch_no integer NOT NULL,
    wms_stk_item character varying(128) COLLATE public.nocase,
    wms_stk_from_staging_id character varying(72) COLLATE public.nocase,
    wms_stk_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_stk_su character varying(40) COLLATE public.nocase,
    wms_stk_su_qty numeric,
    wms_stk_staging_id character varying(72) COLLATE public.nocase,
    wms_stk_stage character varying(100) NOT NULL COLLATE public.nocase,
    wms_stk_qty numeric,
    wms_stk_curr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_su_type character varying(32) NOT NULL COLLATE public.nocase,
    wms_stk_created_by character varying(120) COLLATE public.nocase,
    wms_stk_created_date timestamp without time zone,
    wms_stk_modified_by character varying(120) COLLATE public.nocase,
    wms_stk_modified_date timestamp without time zone,
    wms_stk_line_no integer NOT NULL,
    wms_stk_sts character varying(32) COLLATE public.nocase,
    wms_stk_curr_exec_date timestamp without time zone,
    wms_stk_thuid character varying(160) COLLATE public.nocase,
    wms_stk_thu_ser_no character varying(112) COLLATE public.nocase,
    wms_stk_stock_status character varying(160) COLLATE public.nocase,
    wms_stk_thuid_2 character varying(160) COLLATE public.nocase,
    wms_stk_thu_ser_no_2 character varying(112) COLLATE public.nocase,
    wms_stk_su2 character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_stock_inprocess_tracking_dtl_chk CHECK ((wms_stk_qty >= (0)::numeric))
);

ALTER TABLE stg.stg_wms_stock_inprocess_tracking_dtl ALTER COLUMN wms_stk_line_no ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_wms_stock_inprocess_tracking_dtl_wms_stk_line_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);