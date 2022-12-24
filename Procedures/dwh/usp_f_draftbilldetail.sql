-- PROCEDURE: dwh.usp_f_draftbilldetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_draftbilldetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_draftbilldetail(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
    p_depsource VARCHAR(100);

    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN
        SELECT COUNT(1) INTO srccnt
        FROM stg.stg_wms_draft_bill_dtl;

        UPDATE dwh.F_DraftBillDetail t
        SET
        draft_bill_hdr_key                       = COALESCE(oh.draft_bill_hdr_key,-1),
        draft_bill_ref_doc_no                    = s.wms_draft_bill_ref_doc_no,
        draft_bill_ref_doc_typ                   = s.wms_draft_bill_ref_doc_typ,
        draft_bill_triggerring_no                = s.wms_draft_bill_triggerring_no,
        draft_bill_triggerring_type              = s.wms_draft_bill_triggerring_type,
        draft_bill_triggerring_date              = s.wms_draft_bill_triggerring_date,
        draft_bill_tariff_id                     = s.wms_draft_bill_tariff_id,
        draft_bill_uom                           = s.wms_draft_bill_uom,
        draft_bill_qty                           = s.wms_draft_bill_qty,
        draft_bill_rate                          = s.wms_draft_bill_rate,
        draft_bill_value                         = s.wms_draft_bill_value,
        draft_bill_discount                      = s.wms_draft_bill_discount,
        draft_bill_total_value                   = s.wms_draft_bill_total_value,
        draft_bill_br_wt                         = s.wms_draft_bill_br_wt,
        draft_bill_cn_weight                     = s.wms_draft_bill_cn_weight,
        draft_bill_rev_prot_wt                   = s.wms_draft_bill_rev_prot_wt,
        draft_bill_billable_wt                   = s.wms_draft_bill_billable_wt,
        draft_bill_volume                        = s.wms_draft_bill_volume,
        draft_bill_hours                         = s.wms_draft_bill_hours,
        draft_bill_no_of_pallet                  = s.wms_draft_bill_no_of_pallet,
        draft_bill_br_vol                        = s.wms_draft_bill_br_vol,
        draft_bill_cn_vol                        = s.wms_draft_bill_cn_vol,
        draft_bill_rev_prot_vol                  = s.wms_draft_bill_rev_prot_vol,
        draft_bill_no_of_su                      = s.wms_draft_bill_no_of_su,
        draft_bill_count_of_consumables          = s.wms_draft_bill_count_of_consumables,
        draft_bill_thu_id                        = s.wms_draft_bill_thu_id,
        draft_bill_ref_doc_date                  = s.wms_draft_bill_ref_doc_date,
        draft_bill_equipment                     = s.wms_draft_bill_equipment,
        draft_bill_vehicle                       = s.wms_draft_bill_vehicle,
        draft_bill_employee                      = s.wms_draft_bill_employee,
        draft_bill_equipment_type                = s.wms_draft_bill_equipment_type,
        draft_bill_vehicle_type                  = s.wms_draft_bill_vehicle_type,
        invoice_flag                             = s.wms_invoice_flag,
        draft_bill_exec_dt_from                  = s.wms_draft_bill_exec_dt_from,
        draft_bill_exec_dt_to                    = s.wms_draft_bill_exec_dt_to,
        draft_bill_calc_value                    = s.wms_draft_bill_calc_value,
        draft_bill_margin                        = s.wms_draft_bill_margin,
        draft_bill_invoice_no                    = s.wms_draft_bill_invoice_no,
        draft_bill_invoice_ou                    = s.wms_draft_bill_invoice_ou,
        draft_bill_invoice_trantype              = s.wms_draft_bill_invoice_trantype,
        draft_bill_note_no                       = s.wms_draft_bill_note_no,
        draft_bill_note_ou                       = s.wms_draft_bill_note_ou,
        draft_bill_note_trantype                 = s.wms_draft_bill_note_trantype,
        draft_bill_su                            = s.wms_draft_bill_su,
        draft_bill_item_code                     = s.wms_draft_bill_item_code,
        draft_bill_item_qty                      = s.wms_draft_bill_item_qty,
        draft_bill_master_uom                    = s.wms_draft_bill_master_uom,
        draft_bill_item_wt                       = s.wms_draft_bill_item_wt,
        draft_bill_item_wt_uom                   = s.wms_draft_bill_item_wt_uom,
        draft_bill_no_of_weeks                   = s.wms_draft_bill_no_of_weeks,
        draft_bill_distance                      = s.wms_draft_bill_distance,
        draft_bill_transit_time                  = s.wms_draft_bill_transit_time,
        draft_bill_pickup_wt                     = s.wms_draft_bill_pickup_wt,
        draft_bill_delivery_wt                   = s.wms_draft_bill_delivery_wt,
        draft_bill_loading_time                  = s.wms_draft_bill_loading_time,
        draft_bill_unloading_time                = s.wms_draft_bill_unloading_time,
        draft_bill_est_return_time               = s.wms_draft_bill_est_return_time,
        draft_bill_no_of_empl                    = s.wms_draft_bill_no_of_empl,
        draft_bill_service_type                  = s.wms_draft_bill_service_type,
        draft_bill_subserv_type                  = s.wms_draft_bill_subserv_type,
        draft_bill_no_of_containers              = s.wms_draft_bill_no_of_containers,
        draft_bill_supp_bat_no                   = s.wms_draft_bill_supp_bat_no,
        force_match_flag                         = s.wms_force_match_flag,
        draft_bill_reimbursable                  = s.wms_draft_bill_reimbursable,
        draft_bill_remarks                       = s.wms_draft_bill_remarks,
        draft_bill_line_status                   = s.wms_draft_bill_line_status,
        draft_bill_Contract                      = s.wms_draft_bill_Contract,
        draft_bill_periodfrom                    = s.wms_draft_bill_periodfrom,
        draft_bill_periodto                      = s.wms_draft_bill_periodto,
        draft_bill_veh_id                        = s.wms_draft_bill_veh_id,
        draft_bill_veh_type                      = s.wms_draft_bill_veh_type,
        draft_bill_driver_id                     = s.wms_draft_bill_driver_id,
        draft_bill_equip_id                      = s.wms_draft_bill_equip_id,
        draft_bill_equip_type                    = s.wms_draft_bill_equip_type,
        draft_consignee_name                     = s.wms_draft_consignee_name,
        draft_pri_ref_doc                        = s.wms_draft_pri_ref_doc,
        draft_Pri_gateway_auth_no                = s.wms_draft_Pri_gateway_auth_no,
        draft_authorization_date                 = s.wms_draft_authorization_date,
        draft_cust_item_id                       = s.wms_draft_cust_item_id,
        draft_item_id                            = s.wms_draft_item_id,
        draft_item_desc                          = s.wms_draft_item_desc,
        draft_item_qty                           = s.wms_draft_item_qty,
        draft_bill_exchange_rate                 = s.wms_draft_bill_exchange_rate,
        draft_bill_base_amount                   = s.wms_draft_bill_base_amount,
        draft_bill_inv_gen_flag                  = s.wms_draft_bill_inv_gen_flag,
        draft_bill_DD1                           = s.wms_draft_bill_DD1,
        draft_bill_DD2                           = s.wms_draft_bill_DD2,
        draft_leg_behavior                       = s.wms_draft_leg_behavior,
        draft_bill_primary_ref_docno             = s.wms_draft_bill_primary_ref_docno,
        tmp_df_bill_primary_ref_doc_no           = s.tmp_df_bill_primary_ref_doc_no,
        draft_bill_calc_qty                      = s.wms_draft_bill_calc_qty,
        draft_bill_calc_rate                     = s.wms_draft_bill_calc_rate,
        draft_bill_resourcetype                  = s.wms_draft_bill_resourcetype,
        draft_bill_ord_src                       = s.wms_draft_bill_ord_src,
        draft_bill_odo_ref15_hdr                 = s.wms_draft_bill_odo_ref15_hdr,
        draft_bill_approved_by                   = s.wms_draft_bill_approved_by,
        draft_bill_approved_date                 = s.wms_draft_bill_approved_date,
        draft_bill_flex_field6                   = s.wms_draft_bill_flex_field6,
        draft_bill_grp                           = s.wms_draft_bill_grp,
        draft_bill_invoice_type                  = s.wms_draft_bill_invoice_type,
        customer_id                              = s.wms_customer_id,
        Supplier_id                              = s.wms_Supplier_id,
        db_inco_terms                            = s.wms_db_inco_terms,
        draft_bill_created_by                    = s.wms_draft_bill_created_by,
        draft_bill_modified_by                   = s.wms_draft_bill_modified_by,
        draft_bill_created_date                  = s.wms_draft_bill_created_date,
        draft_bill_modified_date                 = s.wms_draft_bill_modified_date,
        draft_bill_service_currency              = s.wms_draft_bill_service_currency,
        draft_bill_int_ord_lineno                = s.wms_draft_bill_int_ord_lineno,
        draft_bill_int_ord_cust_id               = s.wms_draft_bill_int_ord_cust_id,
        draft_bill_channel_type                  = s.wms_draft_bill_channel_type,
        draft_bill_reason_code                   = s.wms_draft_bill_reason_code,
        draft_bill_amend_user                    = s.wms_draft_bill_amend_user,
        draft_bill_amend_date                    = s.wms_draft_bill_amend_date,
        draft_bill_approve_user                  = s.wms_draft_bill_approve_user,
        draft_bill_approve_date                  = s.wms_draft_bill_approve_date,
        draft_bill_cancel_user                   = s.wms_draft_bill_cancel_user,
        draft_bill_cancel_date                   = s.wms_draft_bill_cancel_date,
        draft_bill_Expflg                        = s.wms_draft_bill_Expflg,
        draft_bill_billing_id                    = s.wms_draft_bill_billing_id,
        draft_bill_fuel_tcd_code                 = s.wms_draft_bill_fuel_tcd_code,
        draft_bill_fuel_tcd_variant              = s.wms_draft_bill_fuel_tcd_variant,
        wsm_draft_bill_accrual_jv_no             = s.wsm_draft_bill_accrual_jv_no,
        wsm_draft_bill_reversal_jv_no            = s.wsm_draft_bill_reversal_jv_no,
        wsm_draft_bill_accrual_jv_date           = s.wsm_draft_bill_accrual_jv_date,
        wsm_draft_bill_accrual_jv_amount         = s.wsm_draft_bill_accrual_jv_amount,
        wsm_draft_bill_reversal_jv_date          = s.wsm_draft_bill_reversal_jv_date,
        wsm_draft_bill_reversal_jv_amount        = s.wsm_draft_bill_reversal_jv_amount,
        draft_bill_accural_flag                  = s.wms_draft_bill_accural_flag,
        draft_bill_br_remittance_YN              = s.wms_draft_bill_br_remittance_YN,
        draft_bill_accrual_amend_flag            = s.wms_draft_bill_accrual_amend_flag,
        etlactiveind                             = 1,
        etljobname                               = p_etljobname,
        envsourcecd                              = p_envsourcecd,
        datasourcecd                             = p_datasourcecd,
        etlupdatedatetime                        = NOW()
        FROM stg.stg_wms_draft_bill_dtl s

        LEFT JOIN dwh.f_draftbillheader oh
        ON    s.wms_draft_bill_no   = oh.draft_bill_no
        AND   s.wms_draft_bill_ou	= oh.draft_bill_ou

        WHERE t.draft_bill_no 	= s.wms_draft_bill_no
		AND t.draft_bill_ou 	= s.wms_draft_bill_ou
		AND t.draft_bill_lineno = s.wms_draft_bill_lineno;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_DraftBillDetail
        (
            draft_bill_hdr_key,draft_bill_no, draft_bill_ou, draft_bill_lineno, draft_bill_ref_doc_no, draft_bill_ref_doc_typ, draft_bill_triggerring_no, draft_bill_triggerring_type, draft_bill_triggerring_date, draft_bill_tariff_id, draft_bill_uom, draft_bill_qty, draft_bill_rate, draft_bill_value, draft_bill_discount, draft_bill_total_value, draft_bill_br_wt, draft_bill_cn_weight, draft_bill_rev_prot_wt, draft_bill_billable_wt, draft_bill_volume, draft_bill_hours, draft_bill_no_of_pallet, draft_bill_br_vol, draft_bill_cn_vol, draft_bill_rev_prot_vol, draft_bill_no_of_su, draft_bill_count_of_consumables, draft_bill_thu_id, draft_bill_ref_doc_date, draft_bill_equipment, draft_bill_vehicle, draft_bill_employee, draft_bill_equipment_type, draft_bill_vehicle_type, invoice_flag, draft_bill_exec_dt_from, draft_bill_exec_dt_to, draft_bill_calc_value, draft_bill_margin, draft_bill_invoice_no, draft_bill_invoice_ou, draft_bill_invoice_trantype, draft_bill_note_no, draft_bill_note_ou, draft_bill_note_trantype, draft_bill_su, draft_bill_item_code, draft_bill_item_qty, draft_bill_master_uom, draft_bill_item_wt, draft_bill_item_wt_uom, draft_bill_no_of_weeks, draft_bill_distance, draft_bill_transit_time, draft_bill_pickup_wt, draft_bill_delivery_wt, draft_bill_loading_time, draft_bill_unloading_time, draft_bill_est_return_time, draft_bill_no_of_empl, draft_bill_service_type, draft_bill_subserv_type, draft_bill_no_of_containers, draft_bill_supp_bat_no, force_match_flag, draft_bill_reimbursable, draft_bill_remarks, draft_bill_line_status, draft_bill_Contract, draft_bill_periodfrom, draft_bill_periodto, draft_bill_veh_id, draft_bill_veh_type, draft_bill_driver_id, draft_bill_equip_id, draft_bill_equip_type, draft_consignee_name, draft_pri_ref_doc, draft_Pri_gateway_auth_no, draft_authorization_date, draft_cust_item_id, draft_item_id, draft_item_desc, draft_item_qty, draft_bill_exchange_rate, draft_bill_base_amount, draft_bill_inv_gen_flag, draft_bill_DD1, draft_bill_DD2, draft_leg_behavior, draft_bill_primary_ref_docno, tmp_df_bill_primary_ref_doc_no, draft_bill_calc_qty, draft_bill_calc_rate, draft_bill_resourcetype, draft_bill_ord_src, draft_bill_odo_ref15_hdr, draft_bill_approved_by, draft_bill_approved_date, draft_bill_flex_field6, draft_bill_grp, draft_bill_invoice_type, customer_id, Supplier_id, db_inco_terms, draft_bill_created_by, draft_bill_modified_by, draft_bill_created_date, draft_bill_modified_date, draft_bill_service_currency, draft_bill_int_ord_lineno, draft_bill_int_ord_cust_id, draft_bill_channel_type, draft_bill_reason_code, draft_bill_amend_user, draft_bill_amend_date, draft_bill_approve_user, draft_bill_approve_date, draft_bill_cancel_user, draft_bill_cancel_date, draft_bill_Expflg, draft_bill_billing_id, draft_bill_fuel_tcd_code, draft_bill_fuel_tcd_variant, wsm_draft_bill_accrual_jv_no, wsm_draft_bill_reversal_jv_no, wsm_draft_bill_accrual_jv_date, wsm_draft_bill_accrual_jv_amount, wsm_draft_bill_reversal_jv_date, wsm_draft_bill_reversal_jv_amount, draft_bill_accural_flag, draft_bill_br_remittance_YN, draft_bill_accrual_amend_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            COALESCE(oh.draft_bill_hdr_key,-1),s.wms_draft_bill_no, s.wms_draft_bill_ou, s.wms_draft_bill_lineno, s.wms_draft_bill_ref_doc_no, s.wms_draft_bill_ref_doc_typ, s.wms_draft_bill_triggerring_no, s.wms_draft_bill_triggerring_type, s.wms_draft_bill_triggerring_date, s.wms_draft_bill_tariff_id, s.wms_draft_bill_uom, s.wms_draft_bill_qty, s.wms_draft_bill_rate, s.wms_draft_bill_value, s.wms_draft_bill_discount, s.wms_draft_bill_total_value, s.wms_draft_bill_br_wt, s.wms_draft_bill_cn_weight, s.wms_draft_bill_rev_prot_wt, s.wms_draft_bill_billable_wt, s.wms_draft_bill_volume, s.wms_draft_bill_hours, s.wms_draft_bill_no_of_pallet, s.wms_draft_bill_br_vol, s.wms_draft_bill_cn_vol, s.wms_draft_bill_rev_prot_vol, s.wms_draft_bill_no_of_su, s.wms_draft_bill_count_of_consumables, s.wms_draft_bill_thu_id, s.wms_draft_bill_ref_doc_date, s.wms_draft_bill_equipment, s.wms_draft_bill_vehicle, s.wms_draft_bill_employee, s.wms_draft_bill_equipment_type, s.wms_draft_bill_vehicle_type, s.wms_invoice_flag, s.wms_draft_bill_exec_dt_from, s.wms_draft_bill_exec_dt_to, s.wms_draft_bill_calc_value, s.wms_draft_bill_margin, s.wms_draft_bill_invoice_no, s.wms_draft_bill_invoice_ou, s.wms_draft_bill_invoice_trantype, s.wms_draft_bill_note_no, s.wms_draft_bill_note_ou, s.wms_draft_bill_note_trantype, s.wms_draft_bill_su, s.wms_draft_bill_item_code, s.wms_draft_bill_item_qty, s.wms_draft_bill_master_uom, s.wms_draft_bill_item_wt, s.wms_draft_bill_item_wt_uom, s.wms_draft_bill_no_of_weeks, s.wms_draft_bill_distance, s.wms_draft_bill_transit_time, s.wms_draft_bill_pickup_wt, s.wms_draft_bill_delivery_wt, s.wms_draft_bill_loading_time, s.wms_draft_bill_unloading_time, s.wms_draft_bill_est_return_time, s.wms_draft_bill_no_of_empl, s.wms_draft_bill_service_type, s.wms_draft_bill_subserv_type, s.wms_draft_bill_no_of_containers, s.wms_draft_bill_supp_bat_no, s.wms_force_match_flag, s.wms_draft_bill_reimbursable, s.wms_draft_bill_remarks, s.wms_draft_bill_line_status, s.wms_draft_bill_Contract, s.wms_draft_bill_periodfrom, s.wms_draft_bill_periodto, s.wms_draft_bill_veh_id, s.wms_draft_bill_veh_type, s.wms_draft_bill_driver_id, s.wms_draft_bill_equip_id, s.wms_draft_bill_equip_type, s.wms_draft_consignee_name, s.wms_draft_pri_ref_doc, s.wms_draft_Pri_gateway_auth_no, s.wms_draft_authorization_date, s.wms_draft_cust_item_id, s.wms_draft_item_id, s.wms_draft_item_desc, s.wms_draft_item_qty, s.wms_draft_bill_exchange_rate, s.wms_draft_bill_base_amount, s.wms_draft_bill_inv_gen_flag, s.wms_draft_bill_DD1, s.wms_draft_bill_DD2, s.wms_draft_leg_behavior, s.wms_draft_bill_primary_ref_docno, s.tmp_df_bill_primary_ref_doc_no, s.wms_draft_bill_calc_qty, s.wms_draft_bill_calc_rate, s.wms_draft_bill_resourcetype, s.wms_draft_bill_ord_src, s.wms_draft_bill_odo_ref15_hdr, s.wms_draft_bill_approved_by, s.wms_draft_bill_approved_date, s.wms_draft_bill_flex_field6, s.wms_draft_bill_grp, s.wms_draft_bill_invoice_type, s.wms_customer_id, s.wms_Supplier_id, s.wms_db_inco_terms, s.wms_draft_bill_created_by, s.wms_draft_bill_modified_by, s.wms_draft_bill_created_date, s.wms_draft_bill_modified_date, s.wms_draft_bill_service_currency, s.wms_draft_bill_int_ord_lineno, s.wms_draft_bill_int_ord_cust_id, s.wms_draft_bill_channel_type, s.wms_draft_bill_reason_code, s.wms_draft_bill_amend_user, s.wms_draft_bill_amend_date, s.wms_draft_bill_approve_user, s.wms_draft_bill_approve_date, s.wms_draft_bill_cancel_user, s.wms_draft_bill_cancel_date, s.wms_draft_bill_Expflg, s.wms_draft_bill_billing_id, s.wms_draft_bill_fuel_tcd_code, s.wms_draft_bill_fuel_tcd_variant, s.wsm_draft_bill_accrual_jv_no, s.wsm_draft_bill_reversal_jv_no, s.wsm_draft_bill_accrual_jv_date, s.wsm_draft_bill_accrual_jv_amount, s.wsm_draft_bill_reversal_jv_date, s.wsm_draft_bill_reversal_jv_amount, s.wms_draft_bill_accural_flag, s.wms_draft_bill_br_remittance_YN, s.wms_draft_bill_accrual_amend_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_wms_draft_bill_dtl s

          LEFT JOIN dwh.f_draftbillheader oh
        ON    s.wms_draft_bill_no   = oh.draft_bill_no
        AND   s.wms_draft_bill_ou = oh.draft_bill_ou

        LEFT JOIN dwh.F_DraftBillDetail t
        ON s.wms_draft_bill_no = t.draft_bill_no
		AND s.wms_draft_bill_ou = t.draft_bill_ou
		AND s.wms_draft_bill_lineno = t.draft_bill_lineno

        WHERE t.draft_bill_no IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_wms_draft_bill_dtl
        (
            wms_draft_bill_no, wms_draft_bill_ou, wms_draft_bill_lineno, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_typ, wms_draft_bill_triggerring_no, wms_draft_bill_triggerring_type, wms_draft_bill_triggerring_date, wms_draft_bill_tariff_id, wms_draft_bill_uom, wms_draft_bill_qty, wms_draft_bill_rate, wms_draft_bill_value, wms_draft_bill_discount, wms_draft_bill_total_value, wms_draft_bill_br_wt, wms_draft_bill_cn_weight, wms_draft_bill_rev_prot_wt, wms_draft_bill_billable_wt, wms_draft_bill_volume, wms_draft_bill_hours, wms_draft_bill_no_of_pallet, wms_draft_bill_br_vol, wms_draft_bill_cn_vol, wms_draft_bill_rev_prot_vol, wms_draft_bill_no_of_su, wms_draft_bill_count_of_consumables, wms_draft_bill_thu_id, wms_draft_bill_ref_doc_date, wms_draft_bill_equipment, wms_draft_bill_vehicle, wms_draft_bill_employee, wms_draft_bill_equipment_type, wms_draft_bill_vehicle_type, wms_invoice_flag, wms_draft_bill_exec_dt_from, wms_draft_bill_exec_dt_to, wms_draft_bill_calc_value, wms_draft_bill_margin, wms_draft_bill_invoice_no, wms_draft_bill_invoice_ou, wms_draft_bill_invoice_trantype, wms_draft_bill_note_no, wms_draft_bill_note_ou, wms_draft_bill_note_trantype, wms_draft_bill_su, wms_draft_bill_item_code, wms_draft_bill_item_qty, wms_draft_bill_master_uom, wms_draft_bill_item_wt, wms_draft_bill_item_wt_uom, wms_draft_bill_no_of_weeks, wms_draft_bill_distance, wms_draft_bill_transit_time, wms_draft_bill_pickup_wt, wms_draft_bill_delivery_wt, wms_draft_bill_loading_time, wms_draft_bill_unloading_time, wms_draft_bill_est_return_time, wms_draft_bill_no_of_empl, wms_draft_bill_service_type, wms_draft_bill_subserv_type, wms_draft_bill_no_of_containers, wms_draft_bill_supp_bat_no, wms_force_match_flag, wms_draft_bill_reimbursable, wms_draft_bill_remarks, wms_draft_bill_line_status, wms_draft_bill_Contract, wms_draft_bill_periodfrom, wms_draft_bill_periodto, wms_draft_bill_veh_id, wms_draft_bill_veh_type, wms_draft_bill_driver_id, wms_draft_bill_equip_id, wms_draft_bill_equip_type, wms_draft_consignee_name, wms_draft_pri_ref_doc, wms_draft_Pri_gateway_auth_no, wms_draft_authorization_date, wms_draft_cust_item_id, wms_draft_item_id, wms_draft_item_desc, wms_draft_item_qty, wms_draft_bill_exchange_rate, wms_draft_bill_base_amount, wms_draft_bill_inv_gen_flag, wms_draft_bill_DD1, wms_draft_bill_DD2, wms_draft_leg_behavior, wms_draft_bill_primary_ref_docno, tmp_df_bill_primary_ref_doc_no, wms_draft_bill_calc_qty, wms_draft_bill_calc_rate, wms_draft_bill_resourcetype, wms_draft_bill_ord_src, wms_draft_bill_odo_ref15_hdr, wms_draft_bill_approved_by, wms_draft_bill_approved_date, wms_draft_bill_flex_field6, wms_draft_bill_grp, wms_draft_bill_invoice_type, wms_customer_id, wms_Supplier_id, wms_db_inco_terms, wms_draft_bill_created_by, wms_draft_bill_modified_by, wms_draft_bill_created_date, wms_draft_bill_modified_date, wms_draft_bill_service_currency, wms_draft_bill_int_ord_lineno, wms_draft_bill_int_ord_cust_id, wms_draft_bill_channel_type, wms_draft_bill_reason_code, wms_draft_bill_amend_user, wms_draft_bill_amend_date, wms_draft_bill_approve_user, wms_draft_bill_approve_date, wms_draft_bill_cancel_user, wms_draft_bill_cancel_date, wms_draft_bill_Expflg, wms_draft_bill_billing_id, wms_draft_bill_fuel_tcd_code, wms_draft_bill_fuel_tcd_variant, wsm_draft_bill_accrual_jv_no, wsm_draft_bill_reversal_jv_no, wsm_draft_bill_accrual_jv_date, wsm_draft_bill_accrual_jv_amount, wsm_draft_bill_reversal_jv_date, wsm_draft_bill_reversal_jv_amount, wms_draft_bill_accural_flag, wms_draft_bill_br_remittance_YN, wms_draft_bill_accrual_amend_flag, etlcreateddatetime
        )
        SELECT
            wms_draft_bill_no, wms_draft_bill_ou, wms_draft_bill_lineno, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_typ, wms_draft_bill_triggerring_no, wms_draft_bill_triggerring_type, wms_draft_bill_triggerring_date, wms_draft_bill_tariff_id, wms_draft_bill_uom, wms_draft_bill_qty, wms_draft_bill_rate, wms_draft_bill_value, wms_draft_bill_discount, wms_draft_bill_total_value, wms_draft_bill_br_wt, wms_draft_bill_cn_weight, wms_draft_bill_rev_prot_wt, wms_draft_bill_billable_wt, wms_draft_bill_volume, wms_draft_bill_hours, wms_draft_bill_no_of_pallet, wms_draft_bill_br_vol, wms_draft_bill_cn_vol, wms_draft_bill_rev_prot_vol, wms_draft_bill_no_of_su, wms_draft_bill_count_of_consumables, wms_draft_bill_thu_id, wms_draft_bill_ref_doc_date, wms_draft_bill_equipment, wms_draft_bill_vehicle, wms_draft_bill_employee, wms_draft_bill_equipment_type, wms_draft_bill_vehicle_type, wms_invoice_flag, wms_draft_bill_exec_dt_from, wms_draft_bill_exec_dt_to, wms_draft_bill_calc_value, wms_draft_bill_margin, wms_draft_bill_invoice_no, wms_draft_bill_invoice_ou, wms_draft_bill_invoice_trantype, wms_draft_bill_note_no, wms_draft_bill_note_ou, wms_draft_bill_note_trantype, wms_draft_bill_su, wms_draft_bill_item_code, wms_draft_bill_item_qty, wms_draft_bill_master_uom, wms_draft_bill_item_wt, wms_draft_bill_item_wt_uom, wms_draft_bill_no_of_weeks, wms_draft_bill_distance, wms_draft_bill_transit_time, wms_draft_bill_pickup_wt, wms_draft_bill_delivery_wt, wms_draft_bill_loading_time, wms_draft_bill_unloading_time, wms_draft_bill_est_return_time, wms_draft_bill_no_of_empl, wms_draft_bill_service_type, wms_draft_bill_subserv_type, wms_draft_bill_no_of_containers, wms_draft_bill_supp_bat_no, wms_force_match_flag, wms_draft_bill_reimbursable, wms_draft_bill_remarks, wms_draft_bill_line_status, wms_draft_bill_Contract, wms_draft_bill_periodfrom, wms_draft_bill_periodto, wms_draft_bill_veh_id, wms_draft_bill_veh_type, wms_draft_bill_driver_id, wms_draft_bill_equip_id, wms_draft_bill_equip_type, wms_draft_consignee_name, wms_draft_pri_ref_doc, wms_draft_Pri_gateway_auth_no, wms_draft_authorization_date, wms_draft_cust_item_id, wms_draft_item_id, wms_draft_item_desc, wms_draft_item_qty, wms_draft_bill_exchange_rate, wms_draft_bill_base_amount, wms_draft_bill_inv_gen_flag, wms_draft_bill_DD1, wms_draft_bill_DD2, wms_draft_leg_behavior, wms_draft_bill_primary_ref_docno, tmp_df_bill_primary_ref_doc_no, wms_draft_bill_calc_qty, wms_draft_bill_calc_rate, wms_draft_bill_resourcetype, wms_draft_bill_ord_src, wms_draft_bill_odo_ref15_hdr, wms_draft_bill_approved_by, wms_draft_bill_approved_date, wms_draft_bill_flex_field6, wms_draft_bill_grp, wms_draft_bill_invoice_type, wms_customer_id, wms_Supplier_id, wms_db_inco_terms, wms_draft_bill_created_by, wms_draft_bill_modified_by, wms_draft_bill_created_date, wms_draft_bill_modified_date, wms_draft_bill_service_currency, wms_draft_bill_int_ord_lineno, wms_draft_bill_int_ord_cust_id, wms_draft_bill_channel_type, wms_draft_bill_reason_code, wms_draft_bill_amend_user, wms_draft_bill_amend_date, wms_draft_bill_approve_user, wms_draft_bill_approve_date, wms_draft_bill_cancel_user, wms_draft_bill_cancel_date, wms_draft_bill_Expflg, wms_draft_bill_billing_id, wms_draft_bill_fuel_tcd_code, wms_draft_bill_fuel_tcd_variant, wsm_draft_bill_accrual_jv_no, wsm_draft_bill_reversal_jv_no, wsm_draft_bill_accrual_jv_date, wsm_draft_bill_accrual_jv_amount, wsm_draft_bill_reversal_jv_date, wsm_draft_bill_reversal_jv_amount, wms_draft_bill_accural_flag, wms_draft_bill_br_remittance_YN, wms_draft_bill_accrual_amend_flag, etlcreateddatetime
        FROM stg.stg_wms_draft_bill_dtl;
    END IF;

    ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
         select 0 into updcnt;
         select 0 into srccnt;  
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
    END IF; 
    
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_draftbilldetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
