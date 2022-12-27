CREATE TABLE stg.stg_wms_stock_acc_exec_hdr (
    wms_stk_acc_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_ou integer NOT NULL,
    wms_stk_acc_exec_date timestamp without time zone,
    wms_stk_acc_exec_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_exec_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_acc_pln_no character varying(72) COLLATE public.nocase,
    wms_stk_acc_employee character varying(80) COLLATE public.nocase,
    wms_stk_acc_created_by character varying(120) COLLATE public.nocase,
    wms_stk_acc_created_date timestamp without time zone,
    wms_stk_acc_modified_by character varying(120) COLLATE public.nocase,
    wms_stk_acc_modified_date timestamp without time zone,
    wms_stk_acc_timestamp integer,
    wms_stk_acc_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_exec_end_date timestamp without time zone,
    wms_stk_acc_ref_doc_type character varying(32) COLLATE public.nocase,
    wms_stk_acc_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_stk_acc_billing_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_bill_value numeric,
    wms_stk_acc_recount_flag character varying(32) COLLATE public.nocase,
    wms_stk_acc_stbhrchr_bil_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_lbchprhr_bil_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_sku_uid_flag character varying(160) COLLATE public.nocase,
    wms_stock_acc_gen_from character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stock_acc_exec_hdr
    ADD CONSTRAINT wms_stock_acc_exec_hdr_pk PRIMARY KEY (wms_stk_acc_loc_code, wms_stk_acc_exec_no, wms_stk_acc_exec_ou);