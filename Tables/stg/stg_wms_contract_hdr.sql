CREATE TABLE stg.stg_wms_contract_hdr (
    wms_cont_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_ou integer NOT NULL,
    wms_cont_amendno integer,
    wms_cont_desc character varying(1020) COLLATE public.nocase,
    wms_cont_date timestamp without time zone,
    wms_cont_type character varying(32) COLLATE public.nocase,
    wms_cont_status character varying(32) COLLATE public.nocase,
    wms_cont_rsn_code character varying(160) COLLATE public.nocase,
    wms_cont_service_type character varying(160) COLLATE public.nocase,
    wms_cont_valid_from timestamp without time zone,
    wms_cont_valid_to timestamp without time zone,
    wms_cont_cust_contract_ref_no character varying(280) COLLATE public.nocase,
    wms_cont_customer_id character varying(72) COLLATE public.nocase,
    wms_cont_supp_contract_ref_no character varying(280) COLLATE public.nocase,
    wms_cont_vendor_id character varying(64) COLLATE public.nocase,
    wms_cont_ref_doc_type character varying(32) COLLATE public.nocase,
    wms_cont_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_cont_bill_freq character varying(32) COLLATE public.nocase,
    wms_cont_bill_date_day character varying(32) COLLATE public.nocase,
    wms_cont_billing_stage character varying(32) COLLATE public.nocase,
    wms_cont_currency character(20) COLLATE public.nocase,
    wms_cont_exchange_rate numeric,
    wms_cont_bulk_rate_chg_per numeric,
    wms_cont_division character varying(40) COLLATE public.nocase,
    wms_cont_location character varying(40) COLLATE public.nocase,
    wms_cont_remarks character varying(1020) COLLATE public.nocase,
    wms_cont_slab_type character varying(32) COLLATE public.nocase,
    wms_cont_timestamp integer,
    wms_cont_created_by character varying(120) COLLATE public.nocase,
    wms_cont_created_dt timestamp without time zone,
    wms_cont_modified_by character varying(120) COLLATE public.nocase,
    wms_cont_modified_dt timestamp without time zone,
    wms_cont_space_last_bill_dt timestamp without time zone,
    wms_cont_payment_type character varying(160) COLLATE public.nocase,
    wms_cont_std_cont_portal integer,
    wms_cont_vendor_group character varying(160) COLLATE public.nocase,
    wms_cont_prev_status character varying(32) COLLATE public.nocase,
    wms_cont_stpitmwk_last_bil_date timestamp without time zone,
    wms_cont_palrtpdy_last_bil_date timestamp without time zone,
    wms_cont_stcothwk_last_bil_date timestamp without time zone,
    wms_cont_palhrwk_last_bil_date timestamp without time zone,
    wms_cont_wkchgmgt_last_bil_date timestamp without time zone,
    wms_cont_stocbm_last_bil_date timestamp without time zone,
    wms_cont_stopsqm_last_bil_date timestamp without time zone,
    wms_cont_hdlicbm_last_bil_date timestamp without time zone,
    wms_cont_hdlocbm_last_bil_date timestamp without time zone,
    wms_cont_stripchg_last_bil_date timestamp without time zone,
    wms_cont_stuffchg_last_bil_date timestamp without time zone,
    wms_cont_stoplqty_last_bil_date timestamp without time zone,
    wms_cont_stocpthu_last_bil_date timestamp without time zone,
    wms_cont_stcstgwk_last_bil_date timestamp without time zone,
    wms_cont_palsppdy_last_bil_date timestamp without time zone,
    wms_cont_stocbmp_last_bil_date timestamp without time zone,
    wms_cont_stopsqmp_last_bil_date timestamp without time zone,
    wms_cont_palsqmdy_last_bil_date timestamp without time zone,
    wms_cont_stopznbn_last_bil_date timestamp without time zone,
    wms_cont_stocbmwk_last_bil_date timestamp without time zone,
    wms_cont_stcthuit_last_bil_date timestamp without time zone,
    wms_cont_stcbtfxv_last_bil_date timestamp without time zone,
    wms_cont_parkchrg_last_bil_date timestamp without time zone,
    wms_cont_wwkmtchg_last_bil_date timestamp without time zone,
    wms_cont_rtfddfxd_last_bil_date timestamp without time zone,
    wms_cont_quo_ou integer,
    wms_cont_quo_no character varying(72) COLLATE public.nocase,
    wms_cont_cust_grp character varying(1020) COLLATE public.nocase,
    wms_cont_lag_time numeric,
    wms_cont_lag_time_uom character varying(32) COLLATE public.nocase,
    wms_cont_scbiqtya_last_bil_date timestamp without time zone,
    wms_cont_scbicbma_last_bil_date timestamp without time zone,
    wms_cont_non_billable integer,
    wms_non_billable_chk integer,
    wms_cont_last_day character varying(32) COLLATE public.nocase,
    wms_cont_proscpzn_last_bil_date timestamp without time zone,
    wms_cont_div_loc_cust integer,
    wms_cont_numbering_type character varying(40) COLLATE public.nocase,
    wms_cont_scsitqpp_last_bil_date timestamp without time zone,
    wms_cont_dstchpzn_last_bil_date timestamp without time zone,
    wms_cont_stpwpmgp_last_bil_date timestamp without time zone,
    wms_cont_wscchtsa_last_bil_date timestamp without time zone,
    wms_cont_workflow_status character varying(1020) COLLATE public.nocase,
    wms_cont_reason_for_return character varying(1020) COLLATE public.nocase,
    wms_cont_stcbspo_last_bil_date timestamp without time zone,
    wms_cont_stapbspo_last_bil_date timestamp without time zone,
    wms_cont_wkthsczn_last_bil_date timestamp without time zone,
    wms_cont_stcpuvol_last_bil_date timestamp without time zone,
    wms_cont_stcpunwt_last_bil_date timestamp without time zone,
    wms_cont_stcpumwt_last_bil_date timestamp without time zone,
    wms_cont_hdimetr_last_bil_date timestamp without time zone,
    wms_cont_avstcpw_last_bil_date timestamp without time zone,
    wms_cont_avstcpvu_last_bil_date timestamp without time zone,
    wms_cont_avstcpmw_last_bil_date timestamp without time zone,
    wms_cont_hdomepk_last_bil_date timestamp without time zone,
    wms_cont_hdlioutc_last_bil_date timestamp without time zone,
    wms_cont_stcpmvmx_last_bil_date timestamp without time zone,
    wms_cont_mtpalret_last_bil_date timestamp without time zone,
    wms_cont_whfxchrg_last_bil_date timestamp without time zone,
    wms_pack_vnpakchr_bil_status character varying(32) COLLATE public.nocase,
    wms_cont_avstcpb_last_bil_date timestamp without time zone,
    wms_cont_whrtchap_last_bil_date timestamp without time zone,
    wms_cont_ffchspgv_last_bil_date timestamp without time zone,
    wms_cont_ffchsugv_last_bil_date timestamp without time zone,
    wms_cont_iata_chk character(4) COLLATE public.nocase,
    wms_cont_cusmemfe_last_bil_date timestamp without time zone,
    wms_cont_markprch_last_bil_date timestamp without time zone,
    wms_cont_ccmiorfe_last_bil_date timestamp without time zone,
    wms_cont_markmior_last_bill_date timestamp without time zone,
    wms_cont_ffchspml_last_bil_date timestamp without time zone,
    wms_cont_incbadev_last_bil_date timestamp without time zone,
    wms_cont_imcbacbm_last_bil_date timestamp without time zone,
    wms_cont_scprtlar_last_bil_date timestamp without time zone,
    wms_cont_sctplqty_last_bil_date timestamp without time zone,
    wms_cont_schapqty_last_bil_date timestamp without time zone,
    wms_cont_schaahmb_last_bil_date timestamp without time zone,
    wms_cont_schmaitv_last_bil_date timestamp without time zone,
    wms_cont_scbaitve_last_bil_date timestamp without time zone,
    wms_cont_sctolvol_last_bil_date timestamp without time zone,
    wms_cont_markaufe_last_bill_date timestamp without time zone,
    wms_exec_hdlncopt_bil_status character varying(160) COLLATE public.nocase,
    wms_cont_incbts_last_bil_date timestamp without time zone,
    wms_cont_astcpwt_last_bil_date timestamp without time zone,
    wms_cont_astcvlu_last_bil_date timestamp without time zone,
    wms_cont_stchuvol_last_bil_date timestamp without time zone,
    wms_cont_mrccugrp_last_bil_date timestamp without time zone,
    wms_cont_vdrenchr_last_bil_date timestamp without time zone,
    wms_cont_pikpakos_last_bil_date timestamp without time zone,
    wms_min_weight numeric,
    wms_volm_conversion numeric,
    wms_cont_bulk_remarks character varying(1020) COLLATE public.nocase,
    wms_cont_plrnpdtu_last_bil_date timestamp without time zone,
    wms_cont_monpalsr_last_bil_date timestamp without time zone,
    wms_cont_scrprbin_last_bil_date timestamp without time zone,
    wms_cont_stcpmewt_last_bil_date timestamp without time zone,
    wms_cont_stcmxthu_last_bil_date timestamp without time zone,
    wms_cont_plan_difot character varying(32) COLLATE public.nocase,
    wms_cont_mpbroemp_last_bil_date timestamp without time zone,
    wms_cont_actrnros_last_bil_date timestamp without time zone,
    wms_cont_vatwarcg_last_bil_date timestamp without time zone,
    wms_cont_dthusznk_last_bil_date timestamp without time zone,
    wms_cont_scbiqar_last_bill_date timestamp without time zone,
    wms_cont_spbaqtyr_last_bil_date timestamp without time zone,
    wms_cont_scpametr_last_bil_date timestamp without time zone,
    wms_cont_scpawgra_last_bil_date timestamp without time zone,
    wms_cont_scpavour_last_bil_date timestamp without time zone,
    wms_cont_scmaxthu_last_bil_date timestamp without time zone,
    wms_cont_scathuqr_last_bil_date timestamp without time zone,
    wms_cont_flrtmfkm_last_bill_date timestamp without time zone,
    wms_cont_houtptld_last_bil_date timestamp without time zone,
    wms_cont_crptkmdr_last_bil_date timestamp without time zone,
    wms_cont_wchboinv_last_bil_date timestamp without time zone,
    wms_cont_rptkmdr_last_bill_date timestamp without time zone,
    wms_cont_vrptovt_last_bill_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);