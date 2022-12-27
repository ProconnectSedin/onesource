CREATE TABLE raw.raw_wms_draft_bill_dtl (
    raw_id bigint NOT NULL,
    wms_draft_bill_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_draft_bill_ou integer NOT NULL,
    wms_draft_bill_lineno integer NOT NULL,
    wms_draft_bill_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_ref_doc_typ character varying(32) COLLATE public.nocase,
    wms_draft_bill_triggerring_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_triggerring_type character varying(32) COLLATE public.nocase,
    wms_draft_bill_triggerring_date timestamp without time zone,
    wms_draft_bill_tariff_id character varying(72) COLLATE public.nocase,
    wms_draft_bill_uom character varying(40) COLLATE public.nocase,
    wms_draft_bill_qty numeric,
    wms_draft_bill_rate numeric,
    wms_draft_bill_value numeric,
    wms_draft_bill_discount numeric,
    wms_draft_bill_total_value numeric,
    wms_draft_bill_br_wt numeric,
    wms_draft_bill_cn_weight numeric,
    wms_draft_bill_rev_prot_wt numeric,
    wms_draft_bill_billable_wt numeric,
    wms_draft_bill_volume numeric,
    wms_draft_bill_hours numeric,
    wms_draft_bill_no_of_pallet numeric,
    wms_draft_bill_br_vol numeric,
    wms_draft_bill_cn_vol numeric,
    wms_draft_bill_rev_prot_vol numeric,
    wms_draft_bill_no_of_su numeric,
    wms_draft_bill_count_of_consumables numeric,
    wms_draft_bill_thu_id character varying(160) COLLATE public.nocase,
    wms_draft_bill_ref_doc_date timestamp without time zone,
    wms_draft_bill_equipment character varying(160) COLLATE public.nocase,
    wms_draft_bill_vehicle character varying(120) COLLATE public.nocase,
    wms_draft_bill_employee character varying(80) COLLATE public.nocase,
    wms_draft_bill_equipment_type character varying(160) COLLATE public.nocase,
    wms_draft_bill_vehicle_type character varying(120) COLLATE public.nocase,
    wms_invoice_flag character varying(32) COLLATE public.nocase,
    wms_draft_bill_exec_dt_from timestamp without time zone,
    wms_draft_bill_exec_dt_to timestamp without time zone,
    wms_draft_bill_calc_value numeric,
    wms_draft_bill_margin numeric,
    wms_draft_bill_invoice_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_invoice_ou integer,
    wms_draft_bill_invoice_trantype character varying(100) COLLATE public.nocase,
    wms_draft_bill_note_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_note_ou integer,
    wms_draft_bill_note_trantype character varying(100) COLLATE public.nocase,
    wms_draft_bill_su character varying(40) COLLATE public.nocase,
    wms_draft_bill_item_code character varying(128) COLLATE public.nocase,
    wms_draft_bill_item_qty numeric,
    wms_draft_bill_master_uom character varying(40) COLLATE public.nocase,
    wms_draft_bill_item_wt numeric,
    wms_draft_bill_item_wt_uom character varying(40) COLLATE public.nocase,
    wms_draft_bill_no_of_weeks integer,
    wms_draft_bill_distance numeric,
    wms_draft_bill_transit_time numeric,
    wms_draft_bill_pickup_wt numeric,
    wms_draft_bill_delivery_wt numeric,
    wms_draft_bill_loading_time numeric,
    wms_draft_bill_unloading_time numeric,
    wms_draft_bill_est_return_time numeric,
    wms_draft_bill_no_of_empl integer,
    wms_draft_bill_service_type character varying(160) COLLATE public.nocase,
    wms_draft_bill_subserv_type character varying(160) COLLATE public.nocase,
    wms_draft_bill_no_of_containers numeric,
    wms_draft_bill_supp_bat_no character varying(112) COLLATE public.nocase,
    wms_force_match_flag character varying(48) COLLATE public.nocase,
    wms_draft_bill_reimbursable character varying(1020) COLLATE public.nocase,
    wms_draft_bill_remarks character varying(1020) COLLATE public.nocase,
    wms_draft_bill_line_status character varying(160) COLLATE public.nocase,
    wms_draft_bill_contract character varying(72) COLLATE public.nocase,
    wms_draft_bill_periodfrom timestamp without time zone,
    wms_draft_bill_periodto timestamp without time zone,
    wms_draft_bill_veh_id character varying(120) COLLATE public.nocase,
    wms_draft_bill_veh_type character varying(160) COLLATE public.nocase,
    wms_draft_bill_driver_id character varying(120) COLLATE public.nocase,
    wms_draft_bill_equip_id character varying(120) COLLATE public.nocase,
    wms_draft_bill_equip_type character varying(160) COLLATE public.nocase,
    wms_draft_consignee_name character varying(600) COLLATE public.nocase,
    wms_draft_pri_ref_doc character varying(72) COLLATE public.nocase,
    wms_draft_pri_gateway_auth_no character varying(1020) COLLATE public.nocase,
    wms_draft_authorization_date timestamp without time zone,
    wms_draft_cust_item_id character varying(128) COLLATE public.nocase,
    wms_draft_item_id character varying(128) COLLATE public.nocase,
    wms_draft_item_desc character varying(3000) COLLATE public.nocase,
    wms_draft_item_qty numeric,
    wms_draft_bill_exchange_rate numeric,
    wms_draft_bill_base_amount numeric,
    wms_draft_bill_inv_gen_flag character varying(32) COLLATE public.nocase,
    wms_draft_bill_dd1 character varying(72) COLLATE public.nocase,
    wms_draft_bill_dd2 character varying(72) COLLATE public.nocase,
    wms_draft_leg_behavior character varying(1020) COLLATE public.nocase,
    wms_draft_bill_primary_ref_docno character varying(72) COLLATE public.nocase,
    tmp_df_bill_primary_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_calc_qty numeric,
    wms_draft_bill_calc_rate numeric,
    wms_draft_bill_resourcetype character varying(1020) COLLATE public.nocase,
    wms_draft_bill_ord_src character varying(200) COLLATE public.nocase,
    wms_draft_bill_odo_ref15_hdr character varying(1020) COLLATE public.nocase,
    wms_draft_bill_approved_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_approved_date timestamp without time zone,
    wms_draft_bill_flex_field6 numeric,
    wms_draft_bill_grp character varying(160) COLLATE public.nocase,
    wms_draft_bill_invoice_type character varying(1020) COLLATE public.nocase,
    wms_customer_id character varying(160) COLLATE public.nocase,
    wms_supplier_id character varying(160) COLLATE public.nocase,
    wms_db_inco_terms character varying(1020) COLLATE public.nocase,
    wms_draft_bill_created_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_modified_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_created_date timestamp without time zone,
    wms_draft_bill_modified_date timestamp without time zone,
    wms_draft_bill_service_currency character(20) COLLATE public.nocase,
    wms_draft_bill_int_ord_lineno integer,
    wms_draft_bill_int_ord_cust_id character varying(72) COLLATE public.nocase,
    wms_draft_bill_channel_type character varying(1020) COLLATE public.nocase,
    wms_draft_bill_reason_code character varying(1020) COLLATE public.nocase,
    wms_draft_bill_amend_user character varying(120) COLLATE public.nocase,
    wms_draft_bill_amend_date timestamp without time zone,
    wms_draft_bill_approve_user character varying(120) COLLATE public.nocase,
    wms_draft_bill_approve_date timestamp without time zone,
    wms_draft_bill_cancel_user character varying(120) COLLATE public.nocase,
    wms_draft_bill_cancel_date timestamp without time zone,
    wms_draft_bill_expflg character varying(32) COLLATE public.nocase,
    wms_draft_bill_billing_id character varying(160) COLLATE public.nocase,
    wms_draft_bill_fuel_tcd_code character varying(40) COLLATE public.nocase,
    wms_draft_bill_fuel_tcd_variant character varying(40) COLLATE public.nocase,
    wsm_draft_bill_accrual_jv_no character varying(80) COLLATE public.nocase,
    wsm_draft_bill_reversal_jv_no character varying(80) COLLATE public.nocase,
    wsm_draft_bill_accrual_jv_date timestamp without time zone,
    wsm_draft_bill_accrual_jv_amount numeric,
    wsm_draft_bill_reversal_jv_date timestamp without time zone,
    wsm_draft_bill_reversal_jv_amount numeric,
    wms_draft_bill_accural_flag character varying(48) COLLATE public.nocase,
    wms_draft_bill_br_remittance_yn character varying(1020) COLLATE public.nocase,
    wms_draft_bill_accrual_amend_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);