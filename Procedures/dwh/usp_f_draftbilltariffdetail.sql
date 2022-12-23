CREATE PROCEDURE dwh.usp_f_draftbilltariffdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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

    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_draft_bill_acc_tariff_dtl;

    UPDATE dwh.f_draftBillTariffDetail t
    SET
        draft_bill_location                   = s.wms_draft_bill_location,
        draft_bill_division                   = s.wms_draft_bill_division,
        draft_bill_ref_doc_no                 = s.wms_draft_bill_ref_doc_no,
        draft_bill_ref_doc_type               = s.wms_draft_bill_ref_doc_type,
        draft_bill_trigger_doc_no             = s.wms_draft_bill_trigger_doc_no,
        draft_bill_trigger_doc_line_no        = s.wms_draft_bill_trigger_doc_line_no,
        draft_bill_trigger_doc_type           = s.wms_draft_bill_trigger_doc_type,
        draft_bill_trip_leg                   = s.wms_draft_bill_trip_leg,
        draft_bill_contract_id                = s.wms_draft_bill_contract_id,
        draft_bill_tariff_id                  = s.wms_draft_bill_tariff_id,
        draft_bill_acc_tariff_type            = s.wms_draft_bill_acc_tariff_type,
        draft_bill_billable_hours             = s.wms_draft_bill_billable_hours,
        draft_bill_value                      = s.wms_draft_bill_value,
        draft_bill_su_count                   = s.wms_draft_bill_su_count,
        draft_bill_consumables_count          = s.wms_draft_bill_consumables_count,
        draft_bill_created_by                 = s.wms_draft_bill_created_by,
        draft_bill_created_date               = s.wms_draft_bill_created_date,
        draft_bill_trip_thu_line_no           = s.wms_draft_bill_trip_thu_line_no,
        draft_bill_contract_amend_no          = s.wms_draft_bill_contract_amend_no,
        draft_bill_thu_id                     = s.wms_draft_bill_thu_id,
        draft_bill_equipment                  = s.wms_draft_bill_equipment,
        draft_bill_vehicle                    = s.wms_draft_bill_vehicle,
        draft_bill_employee                   = s.wms_draft_bill_employee,
        draft_bill_equipment_type             = s.wms_draft_bill_equipment_type,
        draft_bill_vehicle_type               = s.wms_draft_bill_vehicle_type,
        draft_bill_su                         = s.wms_draft_bill_su,
        draft_bill_item_code                  = s.wms_draft_bill_item_code,
        draft_bill_item_qty                   = s.wms_draft_bill_item_qty,
        draft_bill_master_uom                 = s.wms_draft_bill_master_uom,
        draft_bill_item_wt                    = s.wms_draft_bill_item_wt,
        draft_bill_item_wt_uom                = s.wms_draft_bill_item_wt_uom,
        draft_bill_no_of_weeks                = s.wms_draft_bill_no_of_weeks,
        draft_bill_weight                     = s.wms_draft_bill_weight,
        draft_bill_vendorid                   = s.wms_draft_bill_vendorid,
        draft_bill_thu_space                  = s.wms_draft_bill_thu_space,
        draft_bill_pickup_wt                  = s.wms_draft_bill_pickup_wt,
        draft_bill_delivery_wt                = s.wms_draft_bill_delivery_wt,
        draft_bill_transit_time               = s.wms_draft_bill_transit_time,
        draft_bill_loading_time               = s.wms_draft_bill_loading_time,
        draft_bill_unloading_time             = s.wms_draft_bill_unloading_time,
        draft_bill_est_return_time            = s.wms_draft_bill_est_return_time,
        draft_bill_no_of_empl                 = s.wms_draft_bill_no_of_empl,
        draft_bill_billable_intervals         = s.wms_draft_bill_billable_intervals,
        draft_bill_billing_status             = s.wms_draft_bill_billing_status,
        draft_bill_customer_id                = s.wms_draft_bill_customer_id,
        draft_bill_booking_location           = s.wms_draft_bill_booking_location,
        draft_bill_db_no                      = s.wms_draft_bill_db_no,
        draft_bill_db_ln_no                   = s.wms_draft_bill_db_ln_no,
        draft_bill_no_of_containers           = s.wms_draft_bill_no_of_containers,
        draft_bill_supp_bat_no                = s.wms_draft_bill_supp_bat_no,
        draft_bill_item_class                 = s.wms_draft_bill_item_class,
        draft_bill_periodfrom                 = s.wms_draft_bill_periodfrom,
        draft_bill_periodto                   = s.wms_draft_bill_periodto,
        draft_bill_item_group                 = s.wms_draft_bill_item_group,
        draft_bill_ref_doc_line_no            = s.wms_draft_bill_ref_doc_line_no,
        draft_bill_thu_qty                    = s.wms_draft_bill_thu_qty,
        draft_bill_volume                     = s.wms_draft_bill_volume,
        draft_bill_distance                   = s.wms_draft_bill_distance,
        draft_bill_resourcetype               = s.wms_draft_bill_resourcetype,
        draft_bill_total_storage_cost         = s.wms_draft_bill_total_storage_cost,
        draft_bill_gross_vol_sales            = s.wms_draft_bill_gross_vol_sales,
        draft_bill_calc_basis                 = s.wms_draft_bill_calc_basis,
        draft_bill_channel_type               = s.wms_draft_bill_channel_type,
        draft_bill_in_ord_lineno              = s.wms_draft_bill_in_ord_lineno,
        draft_bill_in_ord_cust_id             = s.wms_draft_bill_in_ord_cust_id,
        draft_bill_int_ord_cust_id            = s.wms_draft_bill_int_ord_cust_id,
        draft_bill_exch_rate                  = s.wms_draft_bill_exch_rate,
        draft_bill_margin                     = s.wms_draft_bill_margin,
        draft_bill_min_charge                 = s.wms_draft_bill_min_charge,
        draft_bill_max_charge                 = s.wms_draft_bill_max_charge,
        draft_bill_min_charge_added           = s.wms_draft_bill_min_charge_added,
        draft_bill_discount                   = s.wms_draft_bill_discount,
        draft_bill_cont_rate                  = s.wms_draft_bill_cont_rate,
        draft_bill_value_currency             = s.wms_draft_bill_value_currency,
        draft_bill_alt_bill_currency          = s.wms_draft_bill_alt_bill_currency,
        draft_bill_seq_no                     = s.wms_draft_bill_seq_no,
        etlactiveind                          = 1,
        etljobname                            = p_etljobname,
        envsourcecd                           = p_envsourcecd,
        datasourcecd                          = p_datasourcecd,
        etlupdatedatetime                     = NOW()
    FROM stg.stg_wms_draft_bill_acc_tariff_dtl s
    WHERE t.draft_bill_ou = s.wms_draft_bill_ou
    AND t.draft_bill_line_no = s.wms_draft_bill_line_no
    AND t.draft_bill_tran_type = s.wms_draft_bill_tran_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_draftBillTariffDetail
    (
        draft_bill_ou, draft_bill_line_no, draft_bill_location, draft_bill_division, draft_bill_tran_type, draft_bill_ref_doc_no, 
		draft_bill_ref_doc_type, draft_bill_trigger_doc_no, draft_bill_trigger_doc_line_no, draft_bill_trigger_doc_type, draft_bill_trip_leg, 
		draft_bill_contract_id, draft_bill_tariff_id, draft_bill_acc_tariff_type, draft_bill_billable_hours, draft_bill_value, 
		draft_bill_su_count, draft_bill_consumables_count, draft_bill_created_by, draft_bill_created_date, draft_bill_trip_thu_line_no, 
		draft_bill_contract_amend_no, draft_bill_thu_id, draft_bill_equipment, draft_bill_vehicle, draft_bill_employee, 
		draft_bill_equipment_type, draft_bill_vehicle_type, draft_bill_su, draft_bill_item_code, draft_bill_item_qty, 
		draft_bill_master_uom, draft_bill_item_wt, draft_bill_item_wt_uom, draft_bill_no_of_weeks, draft_bill_weight, 
		draft_bill_vendorid, draft_bill_thu_space, draft_bill_pickup_wt, draft_bill_delivery_wt, draft_bill_transit_time, 
		draft_bill_loading_time, draft_bill_unloading_time, draft_bill_est_return_time, draft_bill_no_of_empl, draft_bill_billable_intervals, 
		draft_bill_billing_status, draft_bill_customer_id, draft_bill_booking_location, draft_bill_db_no, draft_bill_db_ln_no, 
		draft_bill_no_of_containers, draft_bill_supp_bat_no, draft_bill_item_class, draft_bill_periodfrom, draft_bill_periodto, 
		draft_bill_item_group, draft_bill_ref_doc_line_no, draft_bill_thu_qty, draft_bill_volume, draft_bill_distance, 
		draft_bill_resourcetype, draft_bill_total_storage_cost, draft_bill_gross_vol_sales, draft_bill_calc_basis, draft_bill_channel_type, 
		draft_bill_in_ord_lineno, draft_bill_in_ord_cust_id, draft_bill_int_ord_cust_id, draft_bill_exch_rate, draft_bill_margin, 
		draft_bill_min_charge, draft_bill_max_charge, draft_bill_min_charge_added, draft_bill_discount, draft_bill_cont_rate, 
		draft_bill_value_currency, draft_bill_alt_bill_currency, draft_bill_seq_no, etlactiveind, etljobname, envsourcecd, 
		datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_draft_bill_ou, s.wms_draft_bill_line_no, s.wms_draft_bill_location, s.wms_draft_bill_division, s.wms_draft_bill_tran_type, s.wms_draft_bill_ref_doc_no, s.wms_draft_bill_ref_doc_type, s.wms_draft_bill_trigger_doc_no, s.wms_draft_bill_trigger_doc_line_no, s.wms_draft_bill_trigger_doc_type, s.wms_draft_bill_trip_leg, s.wms_draft_bill_contract_id, s.wms_draft_bill_tariff_id, s.wms_draft_bill_acc_tariff_type, s.wms_draft_bill_billable_hours, s.wms_draft_bill_value, s.wms_draft_bill_su_count, s.wms_draft_bill_consumables_count, s.wms_draft_bill_created_by, s.wms_draft_bill_created_date, s.wms_draft_bill_trip_thu_line_no, s.wms_draft_bill_contract_amend_no, s.wms_draft_bill_thu_id, s.wms_draft_bill_equipment, s.wms_draft_bill_vehicle, s.wms_draft_bill_employee, s.wms_draft_bill_equipment_type, s.wms_draft_bill_vehicle_type, s.wms_draft_bill_su, s.wms_draft_bill_item_code, s.wms_draft_bill_item_qty, s.wms_draft_bill_master_uom, s.wms_draft_bill_item_wt, s.wms_draft_bill_item_wt_uom, s.wms_draft_bill_no_of_weeks, s.wms_draft_bill_weight, s.wms_draft_bill_vendorid, s.wms_draft_bill_thu_space, s.wms_draft_bill_pickup_wt, s.wms_draft_bill_delivery_wt, s.wms_draft_bill_transit_time, s.wms_draft_bill_loading_time, s.wms_draft_bill_unloading_time, s.wms_draft_bill_est_return_time, s.wms_draft_bill_no_of_empl, s.wms_draft_bill_billable_intervals, s.wms_draft_bill_billing_status, s.wms_draft_bill_customer_id, s.wms_draft_bill_booking_location, s.wms_draft_bill_db_no, s.wms_draft_bill_db_ln_no, s.wms_draft_bill_no_of_containers, s.wms_draft_bill_supp_bat_no, s.wms_draft_bill_item_class, s.wms_draft_bill_periodfrom, s.wms_draft_bill_periodto, s.wms_draft_bill_item_group, s.wms_draft_bill_ref_doc_line_no, s.wms_draft_bill_thu_qty, s.wms_draft_bill_volume, s.wms_draft_bill_distance, s.wms_draft_bill_resourcetype, s.wms_draft_bill_total_storage_cost, s.wms_draft_bill_gross_vol_sales, s.wms_draft_bill_calc_basis, s.wms_draft_bill_channel_type, s.wms_draft_bill_in_ord_lineno, s.wms_draft_bill_in_ord_cust_id, s.wms_draft_bill_int_ord_cust_id, s.wms_draft_bill_exch_rate, s.wms_draft_bill_margin, s.wms_draft_bill_min_charge, s.wms_draft_bill_max_charge, s.wms_draft_bill_min_charge_added, s.wms_draft_bill_discount, s.wms_draft_bill_cont_rate, s.wms_draft_bill_value_currency, s.wms_draft_bill_alt_bill_currency, s.wms_draft_bill_seq_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_draft_bill_acc_tariff_dtl s
    LEFT JOIN dwh.f_draftBillTariffDetail t
    ON s.wms_draft_bill_ou = t.draft_bill_ou
    AND s.wms_draft_bill_line_no = t.draft_bill_line_no
    AND s.wms_draft_bill_tran_type = t.draft_bill_tran_type
    WHERE t.draft_bill_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_draft_bill_acc_tariff_dtl
    (
        wms_draft_bill_ou, wms_draft_bill_line_no, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, wms_draft_bill_trigger_doc_no, wms_draft_bill_trigger_doc_line_no, wms_draft_bill_trigger_doc_type, wms_draft_bill_trip_leg, wms_draft_bill_contract_id, wms_draft_bill_tariff_id, wms_draft_bill_acc_tariff_type, wms_draft_bill_billable_hours, wms_draft_bill_value, wms_draft_bill_su_count, wms_draft_bill_consumables_count, wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_trip_thu_line_no, wms_draft_bill_contract_amend_no, wms_draft_bill_thu_id, wms_draft_bill_equipment, wms_draft_bill_vehicle, wms_draft_bill_employee, wms_draft_bill_equipment_type, wms_draft_bill_vehicle_type, wms_draft_bill_su, wms_draft_bill_item_code, wms_draft_bill_item_qty, wms_draft_bill_master_uom, wms_draft_bill_item_wt, wms_draft_bill_item_wt_uom, wms_draft_bill_no_of_weeks, wms_draft_bill_weight, wms_draft_bill_vendorid, wms_draft_bill_thu_space, wms_draft_bill_pickup_wt, wms_draft_bill_delivery_wt, wms_draft_bill_transit_time, wms_draft_bill_loading_time, wms_draft_bill_unloading_time, wms_draft_bill_est_return_time, wms_draft_bill_no_of_empl, wms_draft_bill_billable_intervals, wms_draft_bill_billing_status, wms_draft_bill_customer_id, wms_draft_bill_booking_location, wms_draft_bill_db_no, wms_draft_bill_db_ln_no, wms_draft_bill_no_of_containers, wms_draft_bill_supp_bat_no, wms_draft_bill_item_class, wms_draft_bill_periodfrom, wms_draft_bill_periodto, wms_draft_bill_item_group, wms_draft_bill_ref_doc_line_no, wms_draft_bill_thu_qty, wms_draft_bill_volume, wms_draft_bill_distance, wms_draft_bill_resourcetype, wms_draft_bill_total_storage_cost, wms_draft_bill_gross_vol_sales, wms_draft_bill_calc_basis, wms_draft_bill_channel_type, wms_draft_bill_in_ord_lineno, wms_draft_bill_in_ord_cust_id, wms_draft_bill_int_ord_cust_id, wms_draft_bill_exch_rate, wms_draft_bill_margin, wms_draft_bill_min_charge, wms_draft_bill_max_charge, wms_draft_bill_min_charge_added, wms_draft_bill_discount, wms_draft_bill_cont_rate, wms_draft_bill_value_currency, wms_draft_bill_alt_bill_currency, wms_draft_bill_seq_no, etlcreateddatetime
    )
    SELECT
        wms_draft_bill_ou, wms_draft_bill_line_no, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, wms_draft_bill_trigger_doc_no, wms_draft_bill_trigger_doc_line_no, wms_draft_bill_trigger_doc_type, wms_draft_bill_trip_leg, wms_draft_bill_contract_id, wms_draft_bill_tariff_id, wms_draft_bill_acc_tariff_type, wms_draft_bill_billable_hours, wms_draft_bill_value, wms_draft_bill_su_count, wms_draft_bill_consumables_count, wms_draft_bill_created_by, wms_draft_bill_created_date, wms_draft_bill_trip_thu_line_no, wms_draft_bill_contract_amend_no, wms_draft_bill_thu_id, wms_draft_bill_equipment, wms_draft_bill_vehicle, wms_draft_bill_employee, wms_draft_bill_equipment_type, wms_draft_bill_vehicle_type, wms_draft_bill_su, wms_draft_bill_item_code, wms_draft_bill_item_qty, wms_draft_bill_master_uom, wms_draft_bill_item_wt, wms_draft_bill_item_wt_uom, wms_draft_bill_no_of_weeks, wms_draft_bill_weight, wms_draft_bill_vendorid, wms_draft_bill_thu_space, wms_draft_bill_pickup_wt, wms_draft_bill_delivery_wt, wms_draft_bill_transit_time, wms_draft_bill_loading_time, wms_draft_bill_unloading_time, wms_draft_bill_est_return_time, wms_draft_bill_no_of_empl, wms_draft_bill_billable_intervals, wms_draft_bill_billing_status, wms_draft_bill_customer_id, wms_draft_bill_booking_location, wms_draft_bill_db_no, wms_draft_bill_db_ln_no, wms_draft_bill_no_of_containers, wms_draft_bill_supp_bat_no, wms_draft_bill_item_class, wms_draft_bill_periodfrom, wms_draft_bill_periodto, wms_draft_bill_item_group, wms_draft_bill_ref_doc_line_no, wms_draft_bill_thu_qty, wms_draft_bill_volume, wms_draft_bill_distance, wms_draft_bill_resourcetype, wms_draft_bill_total_storage_cost, wms_draft_bill_gross_vol_sales, wms_draft_bill_calc_basis, wms_draft_bill_channel_type, wms_draft_bill_in_ord_lineno, wms_draft_bill_in_ord_cust_id, wms_draft_bill_int_ord_cust_id, wms_draft_bill_exch_rate, wms_draft_bill_margin, wms_draft_bill_min_charge, wms_draft_bill_max_charge, wms_draft_bill_min_charge_added, wms_draft_bill_discount, wms_draft_bill_cont_rate, wms_draft_bill_value_currency, wms_draft_bill_alt_bill_currency, wms_draft_bill_seq_no, etlcreateddatetime
    FROM stg.stg_wms_draft_bill_acc_tariff_dtl;
    END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;