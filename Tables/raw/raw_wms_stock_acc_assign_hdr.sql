CREATE TABLE raw.raw_wms_stock_acc_assign_hdr (
    raw_id bigint NOT NULL,
    wms_stk_acc_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_acc_exec_pln_ou integer NOT NULL,
    wms_stk_acc_exec_pln_date timestamp without time zone,
    wms_stk_acc_exec_pln_status character varying(32) COLLATE public.nocase,
    wms_stk_acc_pln_no character varying(72) COLLATE public.nocase,
    wms_stk_acc_employee character varying(80) COLLATE public.nocase,
    wms_stk_acc_date timestamp without time zone,
    wms_stk_acc_exec_pln_level character varying(32) COLLATE public.nocase,
    wms_stk_acc_exec_customer character varying(72) COLLATE public.nocase,
    wms_stk_acc_exec_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_stk_acc_created_by character varying(120) COLLATE public.nocase,
    wms_stk_acc_created_date timestamp without time zone,
    wms_stk_acc_modified_by character varying(120) COLLATE public.nocase,
    wms_stk_acc_modified_date timestamp without time zone,
    wms_stk_acc_timestamp integer,
    wms_stk_acc_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_stk_acc_output_pln character varying(32) COLLATE public.nocase,
    wms_stk_acc_end_date timestamp without time zone,
    wms_stk_acc_exec_ref_doc_type character varying(32) COLLATE public.nocase,
    wms_stk_acc_recount_flag character varying(32) COLLATE public.nocase,
    wms_stk_acc_sku_uid_flag character varying(160) COLLATE public.nocase,
    wms_stk_acc_wfstatus character varying(1020) COLLATE public.nocase,
    wms_stk_acc_resonforreturn character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_acc_assign_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_acc_assign_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_acc_assign_hdr
    ADD CONSTRAINT raw_wms_stock_acc_assign_hdr_pkey PRIMARY KEY (raw_id);