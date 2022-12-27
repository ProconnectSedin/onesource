CREATE TABLE stg.stg_fact_inbound_grn (
    surrogatekey character varying(4000) COLLATE public.nocase,
    reference_no character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(500) COLLATE public.nocase,
    grn_ou integer NOT NULL,
    grn_location character varying(40) NOT NULL COLLATE public.nocase,
    asn_no character varying(72) NOT NULL COLLATE public.nocase,
    gr_pln_no character varying(144) COLLATE public.nocase,
    gr_pln_date timestamp without time zone,
    gr_pln_status character varying(32) COLLATE public.nocase,
    gr_po_date timestamp without time zone,
    gr_employee character varying(160) COLLATE public.nocase,
    gr_remarks character varying(1020) COLLATE public.nocase,
    gr_created_by character varying(120) COLLATE public.nocase,
    gr_created_date timestamp without time zone,
    gr_modified_by character varying(120) COLLATE public.nocase,
    gr_modified_date timestamp without time zone,
    gr_userdefined1 character varying(1020) COLLATE public.nocase,
    gr_userdefined2 character varying(1020) COLLATE public.nocase,
    gr_userdefined3 character varying(1020) COLLATE public.nocase,
    gr_staging_id character varying(72) COLLATE public.nocase,
    gr_build_uid integer,
    gr_notype character varying(1020) COLLATE public.nocase,
    gr_employeename character varying(1020) COLLATE public.nocase,
    gr_remark character varying(1020) COLLATE public.nocase,
    gr_pln_item_attribute1 character varying(200) COLLATE public.nocase,
    gr_pln_item_attribute2 character varying(200) COLLATE public.nocase,
    gr_pln_item_attribute3 character varying(200) COLLATE public.nocase,
    gr_pln_item_attribute4 character varying(200) COLLATE public.nocase,
    gr_pln_item_attribute5 character varying(200) COLLATE public.nocase,
    gr_exec_no character varying(144) COLLATE public.nocase,
    gr_no character varying(72) COLLATE public.nocase,
    gr_emp character varying(160) COLLATE public.nocase,
    gr_start_date timestamp without time zone,
    gr_end_date timestamp without time zone,
    gr_exec_status character varying(32) COLLATE public.nocase,
    gr_exec_created_by character varying(120) COLLATE public.nocase,
    gr_exec_created_date timestamp without time zone,
    gr_exec_modified_by character varying(120) COLLATE public.nocase,
    gr_exec_modified_date timestamp without time zone,
    gr_exec_userdefined1 character varying(1020) COLLATE public.nocase,
    gr_exec_userdefined2 character varying(1020) COLLATE public.nocase,
    gr_exec_userdefined3 character varying(1020) COLLATE public.nocase,
    gr_exec_staging_id character varying(72) COLLATE public.nocase,
    gr_exec_date timestamp without time zone,
    gr_exec_notype character varying(1020) COLLATE public.nocase,
    gr_exec_employeename character varying(1020) COLLATE public.nocase,
    gr_exec_remark character varying(1020) COLLATE public.nocase,
    gr_gen_from character varying(32) COLLATE public.nocase,
    gr_po_no character varying(144) COLLATE public.nocase,
    gr_po_sno integer,
    gr_item character varying(256) COLLATE public.nocase,
    gr_lineno integer,
    gr_item_qty numeric,
    gr_lot_no character varying(112) COLLATE public.nocase,
    gr_acpt_qty numeric,
    gr_rej_qty numeric,
    gr_storage_unit character varying(40) COLLATE public.nocase,
    gr_mas_uom character varying(40) COLLATE public.nocase,
    gr_su_qty numeric,
    gr_asn_remarks character varying(1020) COLLATE public.nocase,
    gr_execution_date timestamp without time zone,
    gr_reasoncode character varying(160) COLLATE public.nocase,
    gr_cross_dock character varying(80) COLLATE public.nocase,
    gr_stag_id character varying(72) COLLATE public.nocase,
    gr_stock_status character varying(32) COLLATE public.nocase,
    gr_item_attribute1 character varying(200) COLLATE public.nocase,
    gr_item_attribute2 character varying(200) COLLATE public.nocase,
    gr_item_attribute3 character varying(200) COLLATE public.nocase,
    gr_item_attribute4 character varying(200) COLLATE public.nocase,
    gr_item_attribute5 character varying(200) COLLATE public.nocase,
    gr_item_in_stage character varying(1020) COLLATE public.nocase,
    gr_pal_status character varying(160) COLLATE public.nocase,
    gr_ins_more_itm_attb1 character varying(1020) COLLATE public.nocase,
    gr_ins_more_itm_attb2 character varying(1020) COLLATE public.nocase,
    gr_ins_more_itm_attb3 character varying(1020) COLLATE public.nocase,
    gr_ins_more_itm_attb4 character varying(1020) COLLATE public.nocase,
    gr_ins_more_itm_attb5 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_fact_inbound_grn
    ADD CONSTRAINT pk__fact_inb__b48ae12d31f2418c PRIMARY KEY (reference_no);