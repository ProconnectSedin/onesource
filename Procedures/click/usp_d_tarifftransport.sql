-- PROCEDURE: click.usp_d_tarifftransport()

-- DROP PROCEDURE IF EXISTS click.usp_d_tarifftransport();

CREATE OR REPLACE PROCEDURE click.usp_d_tarifftransport(
	)
LANGUAGE 'plpgsql'
AS $BODY$
Declare
		p_errorid integer;
		p_errordesc character varying;
        v_maxdate date;
BEGIN

    SELECT (CASE WHEN max(COALESCE(etlupdatedatetime,etlcreatedatetime):: DATE) <> NULL 
					THEN max(COALESCE(etlupdatedatetime,etlcreatedatetime):: DATE)
				ELSE '1900-01-01' END)::DATE
	INTO v_maxdate
	FROM click.d_tarifftransport;
	
    IF v_maxdate = '1900-01-01'
	
	THEN
    INSERT INTO click.d_tarifftransport(tf_tp_key, tf_tp_id, tf_tp_ou, tf_tp_desc, tf_tp_type_code, tf_tp_status, tf_tp_division, tf_tp_location, tf_tp_validity_id, tf_tp_frm_ship_point, tf_tp_to_ship_point, tf_tp_frm_geo_type, tf_tp_frm_geo, tf_tp_to_geo_type, tf_tp_to_geo, tf_tp_dist_check, tf_tp_dist_min, tf_tp_dist_max, tf_tp_dist_uom, tf_tp_wt, tf_tp_wt_min, tf_tp_wt_max, tf_tp_wt_uom, tf_tp_vol, tf_tp_vol_min, tf_tp_vol_max, tf_tp_vol_uom, tf_tp_trip_time, tf_tp_trip_time_min, tf_tp_trip_time_max, tf_tp_trip_time_uom, tf_tp_vol_conversion, tf_tp_service, tf_tp_sub_service, tf_tp_thu_type, tf_tp_min_no_thu, tf_tp_max_no_thu, tf_tp_class_of_stores, tf_tp_thu_space_frm, tf_tp_thu_space_to, tf_tp_equip_type, tf_tp_veh_type, tf_tp_timestamp, tf_tp_created_by, tf_tp_created_dt, tf_tp_modified_by, tf_tp_modified_dt, tf_tp_multilvl_approval, tf_tp_min_weight, tf_tp_min_volume, tf_tp_previous_status, tf_tp_factor, tf_tp_leg_behavior, tf_tp_service_id, non_billable_chk, tf_tp_numeric_round_off, tf_tp_thu_volume_min_lim, tf_tp_thu_weight_min_lim, tf_tp_category, tf_tp_load_type, tf_tp_freight_charges, tf_tp_inco_terms, tf_tp_rate_class, tf_tp_govt_status, tf_tp_uniq_note, tf_tp_type_of_entry, tf_tp_uld_rating_type, tf_tp_uld_charge_code, tf_tp_dis_doc_type, tf_tp_resource_type, tf_tp_no_of_thu_uom, tf_tp_space_uom, tf_tp_cod_cop, tf_tp_cod_cop_min, tf_tp_cod_cop_max, tf_tp_cod_cop_min_lim, tf_tp_cod_cop_uom, tf_tp_declrd_value, tf_tp_declrd_value_min, tf_tp_declrd_value_max, tf_tp_declrd_value_min_lim, tf_tp_declrd_value_uom, tf_tp_dutiable_value, tf_tp_dutiable_value_min, tf_tp_dutiable_value_max, tf_tp_dutiable_value_min_lim, tf_tp_dutiable_value_uom, tf_tp_thu_length, tf_tp_thu_length_min, tf_tp_thu_length_max, tf_tp_thu_length_min_lim, tf_tp_thu_length_uom, tf_tp_thu_width, tf_tp_thu_width_min, tf_tp_thu_width_max, tf_tp_thu_width_min_lim, tf_tp_thu_width_uom, tf_tp_thu_height, tf_tp_thu_height_min, tf_tp_thu_height_max, tf_tp_thu_height_min_lim, tf_tp_thu_height_uom, tf_tp_thu_distance_min_lim, tf_tp_thu_trip_time_min_lim, tf_tp_cost_type, tf_tp_area, tf_tp_origin_via_point, tf_tp_dest_via_point, tf_tp_data_source, tf_tp_directioncode_chk, tf_tp_proportional_code, tf_tp_uniq_addon_area_code, tf_tp_no_of_thu_min, tf_tp_no_of_thu_max, tf_tp_space_min, tf_tp_space_max, tf_tp_no_of_thu, tf_tp_no_of_thu_min_lim, tf_tp_space, tf_tp_space_min_lim, tf_acc_flag, tf_tp_reciprocal_yn, tf_tp_doc, tf_tp_min_doc, tf_tp_doc_min, tf_tp_doc_max, tf_tp_doc_uom, tf_tp_doc_min_lim, tf_tp_dec_id, tf_tp_consumables, tf_tp_task, tf_tp_job_type, tf_tp_min_eqp, tf_tp_eqp_min, tf_tp_eqp_max, tf_tp_eqp_uom, tf_tp_min_commodity, tf_tp_commodity_min, tf_tp_commodity_max, tf_tp_commodity_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tf_tp_key, s.tf_tp_id, s.tf_tp_ou, s.tf_tp_desc, s.tf_tp_type_code, s.tf_tp_status, s.tf_tp_division, s.tf_tp_location, s.tf_tp_validity_id, s.tf_tp_frm_ship_point, s.tf_tp_to_ship_point, s.tf_tp_frm_geo_type, s.tf_tp_frm_geo, s.tf_tp_to_geo_type, s.tf_tp_to_geo, s.tf_tp_dist_check, s.tf_tp_dist_min, s.tf_tp_dist_max, s.tf_tp_dist_uom, s.tf_tp_wt, s.tf_tp_wt_min, s.tf_tp_wt_max, s.tf_tp_wt_uom, s.tf_tp_vol, s.tf_tp_vol_min, s.tf_tp_vol_max, s.tf_tp_vol_uom, s.tf_tp_trip_time, s.tf_tp_trip_time_min, s.tf_tp_trip_time_max, s.tf_tp_trip_time_uom, s.tf_tp_vol_conversion, s.tf_tp_service, s.tf_tp_sub_service, s.tf_tp_thu_type, s.tf_tp_min_no_thu, s.tf_tp_max_no_thu, s.tf_tp_class_of_stores, s.tf_tp_thu_space_frm, s.tf_tp_thu_space_to, s.tf_tp_equip_type, s.tf_tp_veh_type, s.tf_tp_timestamp, s.tf_tp_created_by, s.tf_tp_created_dt, s.tf_tp_modified_by, s.tf_tp_modified_dt, s.tf_tp_multilvl_approval, s.tf_tp_min_weight, s.tf_tp_min_volume, s.tf_tp_previous_status, s.tf_tp_factor, s.tf_tp_leg_behavior, s.tf_tp_service_id, s.non_billable_chk, s.tf_tp_numeric_round_off, s.tf_tp_thu_volume_min_lim, s.tf_tp_thu_weight_min_lim, s.tf_tp_category, s.tf_tp_load_type, s.tf_tp_freight_charges, s.tf_tp_inco_terms, s.tf_tp_rate_class, s.tf_tp_govt_status, s.tf_tp_uniq_note, s.tf_tp_type_of_entry, s.tf_tp_uld_rating_type, s.tf_tp_uld_charge_code, s.tf_tp_dis_doc_type, s.tf_tp_resource_type, s.tf_tp_no_of_thu_uom, s.tf_tp_space_uom, s.tf_tp_cod_cop, s.tf_tp_cod_cop_min, s.tf_tp_cod_cop_max, s.tf_tp_cod_cop_min_lim, s.tf_tp_cod_cop_uom, s.tf_tp_declrd_value, s.tf_tp_declrd_value_min, s.tf_tp_declrd_value_max, s.tf_tp_declrd_value_min_lim, s.tf_tp_declrd_value_uom, s.tf_tp_dutiable_value, s.tf_tp_dutiable_value_min, s.tf_tp_dutiable_value_max, s.tf_tp_dutiable_value_min_lim, s.tf_tp_dutiable_value_uom, s.tf_tp_thu_length, s.tf_tp_thu_length_min, s.tf_tp_thu_length_max, s.tf_tp_thu_length_min_lim, s.tf_tp_thu_length_uom, s.tf_tp_thu_width, s.tf_tp_thu_width_min, s.tf_tp_thu_width_max, s.tf_tp_thu_width_min_lim, s.tf_tp_thu_width_uom, s.tf_tp_thu_height, s.tf_tp_thu_height_min, s.tf_tp_thu_height_max, s.tf_tp_thu_height_min_lim, s.tf_tp_thu_height_uom, s.tf_tp_thu_distance_min_lim, s.tf_tp_thu_trip_time_min_lim, s.tf_tp_cost_type, s.tf_tp_area, s.tf_tp_origin_via_point, s.tf_tp_dest_via_point, s.tf_tp_data_source, s.tf_tp_directioncode_chk, s.tf_tp_proportional_code, s.tf_tp_uniq_addon_area_code, s.tf_tp_no_of_thu_min, s.tf_tp_no_of_thu_max, s.tf_tp_space_min, s.tf_tp_space_max, s.tf_tp_no_of_thu, s.tf_tp_no_of_thu_min_lim, s.tf_tp_space, s.tf_tp_space_min_lim, s.tf_acc_flag, s.tf_tp_reciprocal_yn, s.tf_tp_doc, s.tf_tp_min_doc, s.tf_tp_doc_min, s.tf_tp_doc_max, s.tf_tp_doc_uom, s.tf_tp_doc_min_lim, s.tf_tp_dec_id, s.tf_tp_consumables, s.tf_tp_task, s.tf_tp_job_type, s.tf_tp_min_eqp, s.tf_tp_eqp_min, s.tf_tp_eqp_max, s.tf_tp_eqp_uom, s.tf_tp_min_commodity, s.tf_tp_commodity_min, s.tf_tp_commodity_max, s.tf_tp_commodity_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_tarifftransport s
    where 1=1;
    
    else
    
    UPDATE click.d_tarifftransport t
    SET
        tf_tp_key = s.tf_tp_key,
        tf_tp_id = s.tf_tp_id,
        tf_tp_ou = s.tf_tp_ou,
        tf_tp_desc = s.tf_tp_desc,
        tf_tp_type_code = s.tf_tp_type_code,
        tf_tp_status = s.tf_tp_status,
        tf_tp_division = s.tf_tp_division,
        tf_tp_location = s.tf_tp_location,
        tf_tp_validity_id = s.tf_tp_validity_id,
        tf_tp_frm_ship_point = s.tf_tp_frm_ship_point,
        tf_tp_to_ship_point = s.tf_tp_to_ship_point,
        tf_tp_frm_geo_type = s.tf_tp_frm_geo_type,
        tf_tp_frm_geo = s.tf_tp_frm_geo,
        tf_tp_to_geo_type = s.tf_tp_to_geo_type,
        tf_tp_to_geo = s.tf_tp_to_geo,
        tf_tp_dist_check = s.tf_tp_dist_check,
        tf_tp_dist_min = s.tf_tp_dist_min,
        tf_tp_dist_max = s.tf_tp_dist_max,
        tf_tp_dist_uom = s.tf_tp_dist_uom,
        tf_tp_wt = s.tf_tp_wt,
        tf_tp_wt_min = s.tf_tp_wt_min,
        tf_tp_wt_max = s.tf_tp_wt_max,
        tf_tp_wt_uom = s.tf_tp_wt_uom,
        tf_tp_vol = s.tf_tp_vol,
        tf_tp_vol_min = s.tf_tp_vol_min,
        tf_tp_vol_max = s.tf_tp_vol_max,
        tf_tp_vol_uom = s.tf_tp_vol_uom,
        tf_tp_trip_time = s.tf_tp_trip_time,
        tf_tp_trip_time_min = s.tf_tp_trip_time_min,
        tf_tp_trip_time_max = s.tf_tp_trip_time_max,
        tf_tp_trip_time_uom = s.tf_tp_trip_time_uom,
        tf_tp_vol_conversion = s.tf_tp_vol_conversion,
        tf_tp_service = s.tf_tp_service,
        tf_tp_sub_service = s.tf_tp_sub_service,
        tf_tp_thu_type = s.tf_tp_thu_type,
        tf_tp_min_no_thu = s.tf_tp_min_no_thu,
        tf_tp_max_no_thu = s.tf_tp_max_no_thu,
        tf_tp_class_of_stores = s.tf_tp_class_of_stores,
        tf_tp_thu_space_frm = s.tf_tp_thu_space_frm,
        tf_tp_thu_space_to = s.tf_tp_thu_space_to,
        tf_tp_equip_type = s.tf_tp_equip_type,
        tf_tp_veh_type = s.tf_tp_veh_type,
        tf_tp_timestamp = s.tf_tp_timestamp,
        tf_tp_created_by = s.tf_tp_created_by,
        tf_tp_created_dt = s.tf_tp_created_dt,
        tf_tp_modified_by = s.tf_tp_modified_by,
        tf_tp_modified_dt = s.tf_tp_modified_dt,
        tf_tp_multilvl_approval = s.tf_tp_multilvl_approval,
        tf_tp_min_weight = s.tf_tp_min_weight,
        tf_tp_min_volume = s.tf_tp_min_volume,
        tf_tp_previous_status = s.tf_tp_previous_status,
        tf_tp_factor = s.tf_tp_factor,
        tf_tp_leg_behavior = s.tf_tp_leg_behavior,
        tf_tp_service_id = s.tf_tp_service_id,
        non_billable_chk = s.non_billable_chk,
        tf_tp_numeric_round_off = s.tf_tp_numeric_round_off,
        tf_tp_thu_volume_min_lim = s.tf_tp_thu_volume_min_lim,
        tf_tp_thu_weight_min_lim = s.tf_tp_thu_weight_min_lim,
        tf_tp_category = s.tf_tp_category,
        tf_tp_load_type = s.tf_tp_load_type,
        tf_tp_freight_charges = s.tf_tp_freight_charges,
        tf_tp_inco_terms = s.tf_tp_inco_terms,
        tf_tp_rate_class = s.tf_tp_rate_class,
        tf_tp_govt_status = s.tf_tp_govt_status,
        tf_tp_uniq_note = s.tf_tp_uniq_note,
        tf_tp_type_of_entry = s.tf_tp_type_of_entry,
        tf_tp_uld_rating_type = s.tf_tp_uld_rating_type,
        tf_tp_uld_charge_code = s.tf_tp_uld_charge_code,
        tf_tp_dis_doc_type = s.tf_tp_dis_doc_type,
        tf_tp_resource_type = s.tf_tp_resource_type,
        tf_tp_no_of_thu_uom = s.tf_tp_no_of_thu_uom,
        tf_tp_space_uom = s.tf_tp_space_uom,
        tf_tp_cod_cop = s.tf_tp_cod_cop,
        tf_tp_cod_cop_min = s.tf_tp_cod_cop_min,
        tf_tp_cod_cop_max = s.tf_tp_cod_cop_max,
        tf_tp_cod_cop_min_lim = s.tf_tp_cod_cop_min_lim,
        tf_tp_cod_cop_uom = s.tf_tp_cod_cop_uom,
        tf_tp_declrd_value = s.tf_tp_declrd_value,
        tf_tp_declrd_value_min = s.tf_tp_declrd_value_min,
        tf_tp_declrd_value_max = s.tf_tp_declrd_value_max,
        tf_tp_declrd_value_min_lim = s.tf_tp_declrd_value_min_lim,
        tf_tp_declrd_value_uom = s.tf_tp_declrd_value_uom,
        tf_tp_dutiable_value = s.tf_tp_dutiable_value,
        tf_tp_dutiable_value_min = s.tf_tp_dutiable_value_min,
        tf_tp_dutiable_value_max = s.tf_tp_dutiable_value_max,
        tf_tp_dutiable_value_min_lim = s.tf_tp_dutiable_value_min_lim,
        tf_tp_dutiable_value_uom = s.tf_tp_dutiable_value_uom,
        tf_tp_thu_length = s.tf_tp_thu_length,
        tf_tp_thu_length_min = s.tf_tp_thu_length_min,
        tf_tp_thu_length_max = s.tf_tp_thu_length_max,
        tf_tp_thu_length_min_lim = s.tf_tp_thu_length_min_lim,
        tf_tp_thu_length_uom = s.tf_tp_thu_length_uom,
        tf_tp_thu_width = s.tf_tp_thu_width,
        tf_tp_thu_width_min = s.tf_tp_thu_width_min,
        tf_tp_thu_width_max = s.tf_tp_thu_width_max,
        tf_tp_thu_width_min_lim = s.tf_tp_thu_width_min_lim,
        tf_tp_thu_width_uom = s.tf_tp_thu_width_uom,
        tf_tp_thu_height = s.tf_tp_thu_height,
        tf_tp_thu_height_min = s.tf_tp_thu_height_min,
        tf_tp_thu_height_max = s.tf_tp_thu_height_max,
        tf_tp_thu_height_min_lim = s.tf_tp_thu_height_min_lim,
        tf_tp_thu_height_uom = s.tf_tp_thu_height_uom,
        tf_tp_thu_distance_min_lim = s.tf_tp_thu_distance_min_lim,
        tf_tp_thu_trip_time_min_lim = s.tf_tp_thu_trip_time_min_lim,
        tf_tp_cost_type = s.tf_tp_cost_type,
        tf_tp_area = s.tf_tp_area,
        tf_tp_origin_via_point = s.tf_tp_origin_via_point,
        tf_tp_dest_via_point = s.tf_tp_dest_via_point,
        tf_tp_data_source = s.tf_tp_data_source,
        tf_tp_directioncode_chk = s.tf_tp_directioncode_chk,
        tf_tp_proportional_code = s.tf_tp_proportional_code,
        tf_tp_uniq_addon_area_code = s.tf_tp_uniq_addon_area_code,
        tf_tp_no_of_thu_min = s.tf_tp_no_of_thu_min,
        tf_tp_no_of_thu_max = s.tf_tp_no_of_thu_max,
        tf_tp_space_min = s.tf_tp_space_min,
        tf_tp_space_max = s.tf_tp_space_max,
        tf_tp_no_of_thu = s.tf_tp_no_of_thu,
        tf_tp_no_of_thu_min_lim = s.tf_tp_no_of_thu_min_lim,
        tf_tp_space = s.tf_tp_space,
        tf_tp_space_min_lim = s.tf_tp_space_min_lim,
        tf_acc_flag = s.tf_acc_flag,
        tf_tp_reciprocal_yn = s.tf_tp_reciprocal_yn,
        tf_tp_doc = s.tf_tp_doc,
        tf_tp_min_doc = s.tf_tp_min_doc,
        tf_tp_doc_min = s.tf_tp_doc_min,
        tf_tp_doc_max = s.tf_tp_doc_max,
        tf_tp_doc_uom = s.tf_tp_doc_uom,
        tf_tp_doc_min_lim = s.tf_tp_doc_min_lim,
        tf_tp_dec_id = s.tf_tp_dec_id,
        tf_tp_consumables = s.tf_tp_consumables,
        tf_tp_task = s.tf_tp_task,
        tf_tp_job_type = s.tf_tp_job_type,
        tf_tp_min_eqp = s.tf_tp_min_eqp,
        tf_tp_eqp_min = s.tf_tp_eqp_min,
        tf_tp_eqp_max = s.tf_tp_eqp_max,
        tf_tp_eqp_uom = s.tf_tp_eqp_uom,
        tf_tp_min_commodity = s.tf_tp_min_commodity,
        tf_tp_commodity_min = s.tf_tp_commodity_min,
        tf_tp_commodity_max = s.tf_tp_commodity_max,
        tf_tp_commodity_uom = s.tf_tp_commodity_uom,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = s.etlupdatedatetime
    FROM dwh.d_tarifftransport s
    WHERE t.tf_tp_id = s.tf_tp_id
    AND t.tf_tp_ou = s.tf_tp_ou
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= v_maxdate;

    INSERT INTO click.d_tarifftransport(tf_tp_key, tf_tp_id, tf_tp_ou, tf_tp_desc, tf_tp_type_code, tf_tp_status, tf_tp_division, tf_tp_location, tf_tp_validity_id, tf_tp_frm_ship_point, tf_tp_to_ship_point, tf_tp_frm_geo_type, tf_tp_frm_geo, tf_tp_to_geo_type, tf_tp_to_geo, tf_tp_dist_check, tf_tp_dist_min, tf_tp_dist_max, tf_tp_dist_uom, tf_tp_wt, tf_tp_wt_min, tf_tp_wt_max, tf_tp_wt_uom, tf_tp_vol, tf_tp_vol_min, tf_tp_vol_max, tf_tp_vol_uom, tf_tp_trip_time, tf_tp_trip_time_min, tf_tp_trip_time_max, tf_tp_trip_time_uom, tf_tp_vol_conversion, tf_tp_service, tf_tp_sub_service, tf_tp_thu_type, tf_tp_min_no_thu, tf_tp_max_no_thu, tf_tp_class_of_stores, tf_tp_thu_space_frm, tf_tp_thu_space_to, tf_tp_equip_type, tf_tp_veh_type, tf_tp_timestamp, tf_tp_created_by, tf_tp_created_dt, tf_tp_modified_by, tf_tp_modified_dt, tf_tp_multilvl_approval, tf_tp_min_weight, tf_tp_min_volume, tf_tp_previous_status, tf_tp_factor, tf_tp_leg_behavior, tf_tp_service_id, non_billable_chk, tf_tp_numeric_round_off, tf_tp_thu_volume_min_lim, tf_tp_thu_weight_min_lim, tf_tp_category, tf_tp_load_type, tf_tp_freight_charges, tf_tp_inco_terms, tf_tp_rate_class, tf_tp_govt_status, tf_tp_uniq_note, tf_tp_type_of_entry, tf_tp_uld_rating_type, tf_tp_uld_charge_code, tf_tp_dis_doc_type, tf_tp_resource_type, tf_tp_no_of_thu_uom, tf_tp_space_uom, tf_tp_cod_cop, tf_tp_cod_cop_min, tf_tp_cod_cop_max, tf_tp_cod_cop_min_lim, tf_tp_cod_cop_uom, tf_tp_declrd_value, tf_tp_declrd_value_min, tf_tp_declrd_value_max, tf_tp_declrd_value_min_lim, tf_tp_declrd_value_uom, tf_tp_dutiable_value, tf_tp_dutiable_value_min, tf_tp_dutiable_value_max, tf_tp_dutiable_value_min_lim, tf_tp_dutiable_value_uom, tf_tp_thu_length, tf_tp_thu_length_min, tf_tp_thu_length_max, tf_tp_thu_length_min_lim, tf_tp_thu_length_uom, tf_tp_thu_width, tf_tp_thu_width_min, tf_tp_thu_width_max, tf_tp_thu_width_min_lim, tf_tp_thu_width_uom, tf_tp_thu_height, tf_tp_thu_height_min, tf_tp_thu_height_max, tf_tp_thu_height_min_lim, tf_tp_thu_height_uom, tf_tp_thu_distance_min_lim, tf_tp_thu_trip_time_min_lim, tf_tp_cost_type, tf_tp_area, tf_tp_origin_via_point, tf_tp_dest_via_point, tf_tp_data_source, tf_tp_directioncode_chk, tf_tp_proportional_code, tf_tp_uniq_addon_area_code, tf_tp_no_of_thu_min, tf_tp_no_of_thu_max, tf_tp_space_min, tf_tp_space_max, tf_tp_no_of_thu, tf_tp_no_of_thu_min_lim, tf_tp_space, tf_tp_space_min_lim, tf_acc_flag, tf_tp_reciprocal_yn, tf_tp_doc, tf_tp_min_doc, tf_tp_doc_min, tf_tp_doc_max, tf_tp_doc_uom, tf_tp_doc_min_lim, tf_tp_dec_id, tf_tp_consumables, tf_tp_task, tf_tp_job_type, tf_tp_min_eqp, tf_tp_eqp_min, tf_tp_eqp_max, tf_tp_eqp_uom, tf_tp_min_commodity, tf_tp_commodity_min, tf_tp_commodity_max, tf_tp_commodity_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tf_tp_key, s.tf_tp_id, s.tf_tp_ou, s.tf_tp_desc, s.tf_tp_type_code, s.tf_tp_status, s.tf_tp_division, s.tf_tp_location, s.tf_tp_validity_id, s.tf_tp_frm_ship_point, s.tf_tp_to_ship_point, s.tf_tp_frm_geo_type, s.tf_tp_frm_geo, s.tf_tp_to_geo_type, s.tf_tp_to_geo, s.tf_tp_dist_check, s.tf_tp_dist_min, s.tf_tp_dist_max, s.tf_tp_dist_uom, s.tf_tp_wt, s.tf_tp_wt_min, s.tf_tp_wt_max, s.tf_tp_wt_uom, s.tf_tp_vol, s.tf_tp_vol_min, s.tf_tp_vol_max, s.tf_tp_vol_uom, s.tf_tp_trip_time, s.tf_tp_trip_time_min, s.tf_tp_trip_time_max, s.tf_tp_trip_time_uom, s.tf_tp_vol_conversion, s.tf_tp_service, s.tf_tp_sub_service, s.tf_tp_thu_type, s.tf_tp_min_no_thu, s.tf_tp_max_no_thu, s.tf_tp_class_of_stores, s.tf_tp_thu_space_frm, s.tf_tp_thu_space_to, s.tf_tp_equip_type, s.tf_tp_veh_type, s.tf_tp_timestamp, s.tf_tp_created_by, s.tf_tp_created_dt, s.tf_tp_modified_by, s.tf_tp_modified_dt, s.tf_tp_multilvl_approval, s.tf_tp_min_weight, s.tf_tp_min_volume, s.tf_tp_previous_status, s.tf_tp_factor, s.tf_tp_leg_behavior, s.tf_tp_service_id, s.non_billable_chk, s.tf_tp_numeric_round_off, s.tf_tp_thu_volume_min_lim, s.tf_tp_thu_weight_min_lim, s.tf_tp_category, s.tf_tp_load_type, s.tf_tp_freight_charges, s.tf_tp_inco_terms, s.tf_tp_rate_class, s.tf_tp_govt_status, s.tf_tp_uniq_note, s.tf_tp_type_of_entry, s.tf_tp_uld_rating_type, s.tf_tp_uld_charge_code, s.tf_tp_dis_doc_type, s.tf_tp_resource_type, s.tf_tp_no_of_thu_uom, s.tf_tp_space_uom, s.tf_tp_cod_cop, s.tf_tp_cod_cop_min, s.tf_tp_cod_cop_max, s.tf_tp_cod_cop_min_lim, s.tf_tp_cod_cop_uom, s.tf_tp_declrd_value, s.tf_tp_declrd_value_min, s.tf_tp_declrd_value_max, s.tf_tp_declrd_value_min_lim, s.tf_tp_declrd_value_uom, s.tf_tp_dutiable_value, s.tf_tp_dutiable_value_min, s.tf_tp_dutiable_value_max, s.tf_tp_dutiable_value_min_lim, s.tf_tp_dutiable_value_uom, s.tf_tp_thu_length, s.tf_tp_thu_length_min, s.tf_tp_thu_length_max, s.tf_tp_thu_length_min_lim, s.tf_tp_thu_length_uom, s.tf_tp_thu_width, s.tf_tp_thu_width_min, s.tf_tp_thu_width_max, s.tf_tp_thu_width_min_lim, s.tf_tp_thu_width_uom, s.tf_tp_thu_height, s.tf_tp_thu_height_min, s.tf_tp_thu_height_max, s.tf_tp_thu_height_min_lim, s.tf_tp_thu_height_uom, s.tf_tp_thu_distance_min_lim, s.tf_tp_thu_trip_time_min_lim, s.tf_tp_cost_type, s.tf_tp_area, s.tf_tp_origin_via_point, s.tf_tp_dest_via_point, s.tf_tp_data_source, s.tf_tp_directioncode_chk, s.tf_tp_proportional_code, s.tf_tp_uniq_addon_area_code, s.tf_tp_no_of_thu_min, s.tf_tp_no_of_thu_max, s.tf_tp_space_min, s.tf_tp_space_max, s.tf_tp_no_of_thu, s.tf_tp_no_of_thu_min_lim, s.tf_tp_space, s.tf_tp_space_min_lim, s.tf_acc_flag, s.tf_tp_reciprocal_yn, s.tf_tp_doc, s.tf_tp_min_doc, s.tf_tp_doc_min, s.tf_tp_doc_max, s.tf_tp_doc_uom, s.tf_tp_doc_min_lim, s.tf_tp_dec_id, s.tf_tp_consumables, s.tf_tp_task, s.tf_tp_job_type, s.tf_tp_min_eqp, s.tf_tp_eqp_min, s.tf_tp_eqp_max, s.tf_tp_eqp_uom, s.tf_tp_min_commodity, s.tf_tp_commodity_min, s.tf_tp_commodity_max, s.tf_tp_commodity_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_tarifftransport s
    LEFT JOIN click.d_tarifftransport t
    ON t.tf_tp_id = s.tf_tp_id
    AND t.tf_tp_ou = s.tf_tp_ou
    WHERE t.tf_tp_id IS NULL
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= v_maxdate;
 
 END IF;	
 
    exception when others then       
    get stacked diagnostics p_errorid = returned_sqlstate, p_errordesc = message_text;
 	call ods.usp_etlerrorinsert('click','d_tarifftransport','click',null,'de-normalized','sp_exceptionhandling',p_errorid,p_errordesc,null);
	
END;
$BODY$;
ALTER PROCEDURE click.usp_d_tarifftransport()
    OWNER TO proconnect;
