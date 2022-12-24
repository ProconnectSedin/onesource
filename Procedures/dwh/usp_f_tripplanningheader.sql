-- PROCEDURE: dwh.usp_f_tripplanningheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripplanningheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripplanningheader(
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
    FROM stg.stg_tms_pltph_trip_plan_hdr;

    UPDATE dwh.f_tripPlanningHeader t
    SET
		plpth_trip_plan_datekey						   = COALESCE(d.datekey,-1),
		plpth_vehicle_key							   = COALESCE (v.veh_key,-1),
        plpth_plan_run_no                              = s.plpth_plan_run_no,
        plpth_plan_run_status                          = s.plpth_plan_run_status,
        plpth_trip_plan_planning_profile_id            = s.plpth_trip_plan_planning_profile_id,
        plpth_trip_plan_status                         = s.plpth_trip_plan_status,
        plpth_trip_plan_date                           = s.plpth_trip_plan_date,
        plpth_trip_plan_end_date                       = s.plpth_trip_plan_end_date,
        plpth_trip_plan_from                           = s.plpth_trip_plan_from,
        plpth_trip_plan_to                             = s.plpth_trip_plan_to,
        plpth_vehicle_profile                          = s.plpth_vehicle_profile,
        plpth_vehicle_type                             = s.plpth_vehicle_type,
        plpth_vehicle_id                               = s.plpth_vehicle_id,
        plpth_vehicle_resource                         = s.plpth_vehicle_resource,
        plpth_vehicle_cov_weight                       = s.plpth_vehicle_cov_weight,
        plpth_vehicle_bal_weight                       = s.plpth_vehicle_bal_weight,
        plpth_vehicle_bal_weight_uom                   = s.plpth_vehicle_bal_weight_uom,
        plpth_vehicle_bal_volume                       = s.plpth_vehicle_bal_volume,
        plpth_vehicle_bal_volume_uom                   = s.plpth_vehicle_bal_volume_uom,
        plpth_equipment_profile                        = s.plpth_equipment_profile,
        plpth_equipment_type                           = s.plpth_equipment_type,
        plpth_equipment_id                             = s.plpth_equipment_id,
        plpth_equipment_resource                       = s.plpth_equipment_resource,
        plpth_equip_cov_weight                         = s.plpth_equip_cov_weight,
        plpth_equip_bal_weight                         = s.plpth_equip_bal_weight,
        plpth_equip_bal_weight_uom                     = s.plpth_equip_bal_weight_uom,
        plpth_equip_bal_volume                         = s.plpth_equip_bal_volume,
        plpth_equip_bal_volume_uom                     = s.plpth_equip_bal_volume_uom,
        plpth_driver_profile                           = s.plpth_driver_profile,
        plpth_driver_grade                             = s.plpth_driver_grade,
        plpth_driver_id                                = s.plpth_driver_id,
        plpth_driver_resource                          = s.plpth_driver_resource,
        plpth_handler_profile                          = s.plpth_handler_profile,
        plpth_handler_grade                            = s.plpth_handler_grade,
        plpth_handler_id                               = s.plpth_handler_id,
        plpth_handler_resource                         = s.plpth_handler_resource,
        plpth_agent_profile                            = s.plpth_agent_profile,
        plpth_agent_service                            = s.plpth_agent_service,
        plpth_agent_id                                 = s.plpth_agent_id,
        plpth_agent_resource                           = s.plpth_agent_resource,
        plpth_rec_trip_id                              = s.plpth_rec_trip_id,
        plpth_schedule_id                              = s.plpth_schedule_id,
        plpth_created_by                               = s.plpth_created_by,
        plpth_created_date                             = s.plpth_created_date,
        plpth_last_modified_by                         = s.plpth_last_modified_by,
        plpth_last_modified_date                       = s.plpth_last_modified_date,
        plpth_timestamp                                = s.plpth_timestamp,
        plpth_location                                 = s.plpth_location,
        plpth_actual_end_time                          = s.plpth_actual_end_time,
        Agent_status                                   = s.Agent_status,
        plpth_plan_run_type                            = s.plpth_plan_run_type,
        plpth_vehicle_cov_volume                       = s.plpth_vehicle_cov_volume,
        plpth_driver2_profile                          = s.plpth_driver2_profile,
        plpth_driver2_grade                            = s.plpth_driver2_grade,
        plpth_driver2_id                               = s.plpth_driver2_id,
        plpth_driver2_resource                         = s.plpth_driver2_resource,
        plpth_handler2_profile                         = s.plpth_handler2_profile,
        plpth_handler2_grade                           = s.plpth_handler2_grade,
        plpth_handler2_id                              = s.plpth_handler2_id,
        plpth_handler2_resource                        = s.plpth_handler2_resource,
        plpth_plan_mode                                = s.plpth_plan_mode,
        plpth_amend_status                             = s.plpth_amend_status,
        plpth_trip_plan_rsncd                          = s.plpth_trip_plan_rsncd,
        plpth_trip_plan_remarks                        = s.plpth_trip_plan_remarks,
        plpth_vehicle_weight                           = s.plpth_vehicle_weight,
        plpth_vehicle_volume                           = s.plpth_vehicle_volume,
        pltph_booking_request_weight                   = s.pltph_booking_request_weight,
        pltph_booking_request_volume                   = s.pltph_booking_request_volume,
        pltph_expected_revenue                         = s.pltph_expected_revenue,
        pltph_expected_cost                            = s.pltph_expected_cost,
        pltph_covered_qty                              = s.pltph_covered_qty,
        pltph_booking_request                          = s.pltph_booking_request,
        pltph_equipment_status_2                       = s.pltph_equipment_status_2,
        pltph_trip_thu_utilization                     = s.pltph_trip_thu_utilization,
        pltph_execution_plan                           = s.pltph_execution_plan,
        pltph_trip_pallet_space                        = s.pltph_trip_pallet_space,
        plpth_trip_plan_from_type                      = s.plpth_trip_plan_from_type,
        plpth_trip_plan_to_type                        = s.plpth_trip_plan_to_type,
        pltph_confirmation_date                        = s.pltph_confirmation_date,
        pltph_release_date                             = s.pltph_release_date,
        pltph_unique_guid                              = s.pltph_unique_guid,
        pltph_error_id                                 = s.pltph_error_id,
        pltph_error_desc                               = s.pltph_error_desc,
        pltph_desktop_mobile_flag                      = s.pltph_desktop_mobile_flag,
        pltph_trip_sht_cls_date                        = s.pltph_trip_sht_cls_date,
        plpth_prime_mover_chkflg                       = s.plpth_prime_mover_chkflg,
        pltph_recurring_flag                           = s.pltph_recurring_flag,
        pltph_trip_calculated_chargeable_weight        = s.pltph_trip_calculated_chargeable_weight,
        plpth_plan_accrual_jv_date                     = s.plpth_plan_accrual_jv_date,
        etlactiveind                                   = 1,
        etljobname                                     = p_etljobname,
        envsourcecd                                    = p_envsourcecd,
        datasourcecd                                   = p_datasourcecd,
        etlupdatedatetime                              = NOW()
    FROM stg.stg_tms_pltph_trip_plan_hdr s
	left join dwh.d_vehicle v
	on s.plpth_vehicle_id = v.veh_id
	and s.plpth_ouinstance = v.veh_ou
	LEFT JOIN dwh.d_date d			
	ON s.plpth_trip_plan_date::date = d.dateactual
    WHERE t.plpth_ouinstance = s.plpth_ouinstance
    AND t.plpth_trip_plan_id = s.plpth_trip_plan_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tripPlanningHeader
    (
        plpth_trip_plan_datekey,plpth_vehicle_key,
		plpth_ouinstance, plpth_plan_run_no, plpth_plan_run_status, plpth_trip_plan_id, plpth_trip_plan_planning_profile_id, plpth_trip_plan_status, plpth_trip_plan_date, plpth_trip_plan_end_date, plpth_trip_plan_from, plpth_trip_plan_to, plpth_vehicle_profile, plpth_vehicle_type, plpth_vehicle_id, plpth_vehicle_resource, plpth_vehicle_cov_weight, plpth_vehicle_bal_weight, plpth_vehicle_bal_weight_uom, plpth_vehicle_bal_volume, plpth_vehicle_bal_volume_uom, plpth_equipment_profile, plpth_equipment_type, plpth_equipment_id, plpth_equipment_resource, plpth_equip_cov_weight, plpth_equip_bal_weight, plpth_equip_bal_weight_uom, plpth_equip_bal_volume, plpth_equip_bal_volume_uom, plpth_driver_profile, plpth_driver_grade, plpth_driver_id, plpth_driver_resource, plpth_handler_profile, plpth_handler_grade, plpth_handler_id, plpth_handler_resource, plpth_agent_profile, plpth_agent_service, plpth_agent_id, plpth_agent_resource, plpth_rec_trip_id, plpth_schedule_id, plpth_created_by, plpth_created_date, plpth_last_modified_by, plpth_last_modified_date, plpth_timestamp, plpth_location, plpth_actual_end_time, Agent_status, plpth_plan_run_type, plpth_vehicle_cov_volume, plpth_driver2_profile, plpth_driver2_grade, plpth_driver2_id, plpth_driver2_resource, plpth_handler2_profile, plpth_handler2_grade, plpth_handler2_id, plpth_handler2_resource, plpth_plan_mode, plpth_amend_status, plpth_trip_plan_rsncd, plpth_trip_plan_remarks, plpth_vehicle_weight, plpth_vehicle_volume, pltph_booking_request_weight, pltph_booking_request_volume, pltph_expected_revenue, pltph_expected_cost, pltph_covered_qty, pltph_booking_request, pltph_equipment_status_2, pltph_trip_thu_utilization, pltph_execution_plan, pltph_trip_pallet_space, plpth_trip_plan_from_type, plpth_trip_plan_to_type, pltph_confirmation_date, pltph_release_date, pltph_unique_guid, pltph_error_id, pltph_error_desc, pltph_desktop_mobile_flag, pltph_trip_sht_cls_date, plpth_prime_mover_chkflg, pltph_recurring_flag, pltph_trip_calculated_chargeable_weight, plpth_plan_accrual_jv_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(d.datekey,-1),COALESCE (v.veh_key,-1),
        s.plpth_ouinstance, s.plpth_plan_run_no, s.plpth_plan_run_status, s.plpth_trip_plan_id, s.plpth_trip_plan_planning_profile_id, s.plpth_trip_plan_status, s.plpth_trip_plan_date, s.plpth_trip_plan_end_date, s.plpth_trip_plan_from, s.plpth_trip_plan_to, s.plpth_vehicle_profile, s.plpth_vehicle_type, s.plpth_vehicle_id, s.plpth_vehicle_resource, s.plpth_vehicle_cov_weight, s.plpth_vehicle_bal_weight, s.plpth_vehicle_bal_weight_uom, s.plpth_vehicle_bal_volume, s.plpth_vehicle_bal_volume_uom, s.plpth_equipment_profile, s.plpth_equipment_type, s.plpth_equipment_id, s.plpth_equipment_resource, s.plpth_equip_cov_weight, s.plpth_equip_bal_weight, s.plpth_equip_bal_weight_uom, s.plpth_equip_bal_volume, s.plpth_equip_bal_volume_uom, s.plpth_driver_profile, s.plpth_driver_grade, s.plpth_driver_id, s.plpth_driver_resource, s.plpth_handler_profile, s.plpth_handler_grade, s.plpth_handler_id, s.plpth_handler_resource, s.plpth_agent_profile, s.plpth_agent_service, s.plpth_agent_id, s.plpth_agent_resource, s.plpth_rec_trip_id, s.plpth_schedule_id, s.plpth_created_by, s.plpth_created_date, s.plpth_last_modified_by, s.plpth_last_modified_date, s.plpth_timestamp, s.plpth_location, s.plpth_actual_end_time, s.Agent_status, s.plpth_plan_run_type, s.plpth_vehicle_cov_volume, s.plpth_driver2_profile, s.plpth_driver2_grade, s.plpth_driver2_id, s.plpth_driver2_resource, s.plpth_handler2_profile, s.plpth_handler2_grade, s.plpth_handler2_id, s.plpth_handler2_resource, s.plpth_plan_mode, s.plpth_amend_status, s.plpth_trip_plan_rsncd, s.plpth_trip_plan_remarks, s.plpth_vehicle_weight, s.plpth_vehicle_volume, s.pltph_booking_request_weight, s.pltph_booking_request_volume, s.pltph_expected_revenue, s.pltph_expected_cost, s.pltph_covered_qty, s.pltph_booking_request, s.pltph_equipment_status_2, s.pltph_trip_thu_utilization, s.pltph_execution_plan, s.pltph_trip_pallet_space, s.plpth_trip_plan_from_type, s.plpth_trip_plan_to_type, s.pltph_confirmation_date, s.pltph_release_date, s.pltph_unique_guid, s.pltph_error_id, s.pltph_error_desc, s.pltph_desktop_mobile_flag, s.pltph_trip_sht_cls_date, s.plpth_prime_mover_chkflg, s.pltph_recurring_flag, s.pltph_trip_calculated_chargeable_weight, s.plpth_plan_accrual_jv_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_pltph_trip_plan_hdr s
	left join dwh.d_vehicle v
	on s.plpth_vehicle_id = v.veh_id
	and s.plpth_ouinstance = v.veh_ou
	LEFT JOIN dwh.d_date d 			
	ON s.plpth_trip_plan_date::date = d.dateactual
    LEFT JOIN dwh.f_tripPlanningHeader t
    ON s.plpth_ouinstance = t.plpth_ouinstance
    AND s.plpth_trip_plan_id = t.plpth_trip_plan_id
    WHERE t.plpth_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_pltph_trip_plan_hdr
    (
        plpth_ouinstance, plpth_plan_run_no, plpth_plan_run_status, plpth_trip_plan_id, plpth_trip_plan_planning_profile_id, plpth_trip_plan_status, plpth_trip_plan_date, plpth_trip_plan_end_date, plpth_trip_plan_from, plpth_trip_plan_to, plpth_vehicle_profile, plpth_vehicle_type, plpth_vehicle_id, plpth_vehicle_resource, plpth_vehicle_cov_weight, plpth_vehicle_bal_weight, plpth_vehicle_bal_weight_uom, plpth_vehicle_bal_volume, plpth_vehicle_bal_volume_uom, plpth_equipment_profile, plpth_equipment_type, plpth_equipment_id, plpth_equipment_resource, plpth_equip_cov_weight, plpth_equip_bal_weight, plpth_equip_bal_weight_uom, plpth_equip_bal_volume, plpth_equip_bal_volume_uom, plpth_driver_profile, plpth_driver_grade, plpth_driver_id, plpth_driver_resource, plpth_handler_profile, plpth_handler_grade, plpth_handler_id, plpth_handler_resource, plpth_agent_profile, plpth_agent_service, plpth_agent_id, plpth_agent_resource, plpth_rec_trip_id, plpth_schedule_id, plpth_created_by, plpth_created_date, plpth_last_modified_by, plpth_last_modified_date, plpth_timestamp, plpth_location, plpth_actual_start_time, plpth_actual_end_time, Agent_status, plpth_schedule_Profile, plpth_plan_run_type, plpth_vehicle_cov_volume, plpth_driver2_profile, plpth_driver2_grade, plpth_driver2_id, plpth_driver2_resource, plpth_handler2_profile, plpth_handler2_grade, plpth_handler2_id, plpth_handler2_resource, plpth_schedule_resource, plpth_gps_ref_no, plpth_mobile_gps_ref_no, plpth_from_date_time, plpth_to_date_time, plpth_equipment2_id, plpth_plan_mode, plpth_amend_status, plpth_trip_plan_backtohub, plpth_trip_plan_rsncd, plpth_trip_plan_remarks, plpth_vehicle_weight, plpth_vehicle_volume, pltph_booking_request_weight, pltph_booking_request_volume, pltph_expected_revenue, pltph_expected_cost, pltph_covered_qty, pltph_booking_request, pltph_equipment_type_2, pltph_equipment_status_2, pltph_trip_thu_utilization, pltph_execution_plan, pltph_trip_pallet_space, plpth_trip_plan_from_type, plpth_trip_plan_to_type, pltph_confirmation_date, pltph_release_date, pltph_unique_guid, pltph_error_id, pltph_error_desc, pltph_mobile_remarks, pltph_desktop_mobile_flag, pltph_vehicle_reg_num, pltph_trip_sht_cls_date, plpth_ship_point_id, plpth_prime_mover_chkflg, pltph_recurring_flag, plpth_Consol_Eway_bill_no, pltph_trip_calculated_chargeable_weight, pltph_trip_applied_chargeable_weight, plpth_trip_preload, tms_trip_plan_workflow_status, plpth_plan_accrual_jv_no, plpth_plan_reversal_jv_no, plpth_plan_accrual_jv_date, plpth_plan_accrual_jv_amount, plpth_plan_reversal_jv_date, plpth_plan_reversal_jv_amount, tms_trip_log_worklfow_status, etlcreateddatetime
    )
    SELECT
        plpth_ouinstance, plpth_plan_run_no, plpth_plan_run_status, plpth_trip_plan_id, plpth_trip_plan_planning_profile_id, plpth_trip_plan_status, plpth_trip_plan_date, plpth_trip_plan_end_date, plpth_trip_plan_from, plpth_trip_plan_to, plpth_vehicle_profile, plpth_vehicle_type, plpth_vehicle_id, plpth_vehicle_resource, plpth_vehicle_cov_weight, plpth_vehicle_bal_weight, plpth_vehicle_bal_weight_uom, plpth_vehicle_bal_volume, plpth_vehicle_bal_volume_uom, plpth_equipment_profile, plpth_equipment_type, plpth_equipment_id, plpth_equipment_resource, plpth_equip_cov_weight, plpth_equip_bal_weight, plpth_equip_bal_weight_uom, plpth_equip_bal_volume, plpth_equip_bal_volume_uom, plpth_driver_profile, plpth_driver_grade, plpth_driver_id, plpth_driver_resource, plpth_handler_profile, plpth_handler_grade, plpth_handler_id, plpth_handler_resource, plpth_agent_profile, plpth_agent_service, plpth_agent_id, plpth_agent_resource, plpth_rec_trip_id, plpth_schedule_id, plpth_created_by, plpth_created_date, plpth_last_modified_by, plpth_last_modified_date, plpth_timestamp, plpth_location, plpth_actual_start_time, plpth_actual_end_time, Agent_status, plpth_schedule_Profile, plpth_plan_run_type, plpth_vehicle_cov_volume, plpth_driver2_profile, plpth_driver2_grade, plpth_driver2_id, plpth_driver2_resource, plpth_handler2_profile, plpth_handler2_grade, plpth_handler2_id, plpth_handler2_resource, plpth_schedule_resource, plpth_gps_ref_no, plpth_mobile_gps_ref_no, plpth_from_date_time, plpth_to_date_time, plpth_equipment2_id, plpth_plan_mode, plpth_amend_status, plpth_trip_plan_backtohub, plpth_trip_plan_rsncd, plpth_trip_plan_remarks, plpth_vehicle_weight, plpth_vehicle_volume, pltph_booking_request_weight, pltph_booking_request_volume, pltph_expected_revenue, pltph_expected_cost, pltph_covered_qty, pltph_booking_request, pltph_equipment_type_2, pltph_equipment_status_2, pltph_trip_thu_utilization, pltph_execution_plan, pltph_trip_pallet_space, plpth_trip_plan_from_type, plpth_trip_plan_to_type, pltph_confirmation_date, pltph_release_date, pltph_unique_guid, pltph_error_id, pltph_error_desc, pltph_mobile_remarks, pltph_desktop_mobile_flag, pltph_vehicle_reg_num, pltph_trip_sht_cls_date, plpth_ship_point_id, plpth_prime_mover_chkflg, pltph_recurring_flag, plpth_Consol_Eway_bill_no, pltph_trip_calculated_chargeable_weight, pltph_trip_applied_chargeable_weight, plpth_trip_preload, tms_trip_plan_workflow_status, plpth_plan_accrual_jv_no, plpth_plan_reversal_jv_no, plpth_plan_accrual_jv_date, plpth_plan_accrual_jv_amount, plpth_plan_reversal_jv_date, plpth_plan_reversal_jv_amount, tms_trip_log_worklfow_status, etlcreateddatetime
    FROM stg.stg_tms_pltph_trip_plan_hdr;
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
ALTER PROCEDURE dwh.usp_f_tripplanningheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;

