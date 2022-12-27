CREATE TABLE stg.stg_wms_gr_exec_dtl (
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_exec_ou integer NOT NULL,
    wms_gr_pln_no character varying(72) COLLATE public.nocase,
    wms_gr_pln_ou integer,
    wms_gr_pln_date timestamp without time zone,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_no character varying(72) COLLATE public.nocase,
    wms_gr_emp character varying(160) COLLATE public.nocase,
    wms_gr_start_date timestamp without time zone,
    wms_gr_end_date timestamp without time zone,
    wms_gr_exec_status character varying(32) COLLATE public.nocase,
    wms_gr_created_by character varying(120) COLLATE public.nocase,
    wms_gr_created_date timestamp without time zone,
    wms_gr_modified_by character varying(120) COLLATE public.nocase,
    wms_gr_modified_date timestamp without time zone,
    wms_gr_timestamp integer,
    wms_gr_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_gr_asn_no character varying(72) COLLATE public.nocase,
    wms_gr_staging_id character varying(72) COLLATE public.nocase,
    wms_gr_billing_status character varying(32) COLLATE public.nocase,
    wms_gr_bill_value numeric,
    wms_gr_exec_date timestamp without time zone,
    wms_gr_build_complete character varying(32) COLLATE public.nocase,
    wms_gr_notype character varying(1020) COLLATE public.nocase,
    wms_gr_notype_prefix character varying(1020) COLLATE public.nocase,
    wms_gr_ref_type character varying(1020) COLLATE public.nocase,
    wms_gr_employeename character varying(1020) COLLATE public.nocase,
    wms_gr_refdocno character varying(1020) COLLATE public.nocase,
    wms_gr_remark character varying(1020) COLLATE public.nocase,
    wms_gr_customerserialno character varying(1020) COLLATE public.nocase,
    wms_gr_conschrg_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_csurcdgr_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdichpvl_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_lbchprhr_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_lblprcgr_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_palrestk_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdichwt_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdichitm_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdichsu_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdlimuom_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_gen_from character varying(32) COLLATE public.nocase,
    wms_gr_consbchg_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_hdlioutc_bil_status character varying(32) COLLATE public.nocase,
    wms_gr_whibferb_sell_bil_status character varying(100) COLLATE public.nocase,
    wms_asn_hciqumos_bil_status character varying(160) COLLATE public.nocase,
    wms_gr_cusbsdcg_bil_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_gr_exec_dtl
    ADD CONSTRAINT wms_gr_exec_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou);