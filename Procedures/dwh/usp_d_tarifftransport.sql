CREATE OR REPLACE PROCEDURE dwh.usp_d_tarifftransport(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag

    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_tariff_transport_hdr;

    UPDATE dwh.D_TariffTransport t
    SET
        tf_tp_desc                          = s.wms_tf_tp_desc,
        tf_tp_type_code                     = s.wms_tf_tp_type_code,
        tf_tp_status                        = s.wms_tf_tp_status,
        tf_tp_division                      = s.wms_tf_tp_division,
        tf_tp_location                      = s.wms_tf_tp_location,
        tf_tp_validity_id                   = s.wms_tf_tp_validity_id,
        tf_tp_frm_ship_point                = s.wms_tf_tp_frm_ship_point,
        tf_tp_to_ship_point                 = s.wms_tf_tp_to_ship_point,
        tf_tp_frm_geo_type                  = s.wms_tf_tp_frm_geo_type,
        tf_tp_frm_geo                       = s.wms_tf_tp_frm_geo,
        tf_tp_to_geo_type                   = s.wms_tf_tp_to_geo_type,
        tf_tp_to_geo                        = s.wms_tf_tp_to_geo,
        tf_tp_dist_check                    = s.wms_tf_tp_dist_check,
        tf_tp_dist_min                      = s.wms_tf_tp_dist_min,
        tf_tp_dist_max                      = s.wms_tf_tp_dist_max,
        tf_tp_dist_uom                      = s.wms_tf_tp_dist_uom,
        tf_tp_wt                            = s.wms_tf_tp_wt,
        tf_tp_wt_min                        = s.wms_tf_tp_wt_min,
        tf_tp_wt_max                        = s.wms_tf_tp_wt_max,
        tf_tp_wt_uom                        = s.wms_tf_tp_wt_uom,
        tf_tp_vol                           = s.wms_tf_tp_vol,
        tf_tp_vol_min                       = s.wms_tf_tp_vol_min,
        tf_tp_vol_max                       = s.wms_tf_tp_vol_max,
        tf_tp_vol_uom                       = s.wms_tf_tp_vol_uom,
        tf_tp_trip_time                     = s.wms_tf_tp_trip_time,
        tf_tp_trip_time_min                 = s.wms_tf_tp_trip_time_min,
        tf_tp_trip_time_max                 = s.wms_tf_tp_trip_time_max,
        tf_tp_trip_time_uom                 = s.wms_tf_tp_trip_time_uom,
        tf_tp_vol_conversion                = s.wms_tf_tp_vol_conversion,
        tf_tp_service                       = s.wms_tf_tp_service,
        tf_tp_sub_service                   = s.wms_tf_tp_sub_service,
        tf_tp_thu_type                      = s.wms_tf_tp_thu_type,
        tf_tp_min_no_thu                    = s.wms_tf_tp_min_no_thu,
        tf_tp_max_no_thu                    = s.wms_tf_tp_max_no_thu,
        tf_tp_class_of_stores               = s.wms_tf_tp_class_of_stores,
        tf_tp_thu_space_frm                 = s.wms_tf_tp_thu_space_frm,
        tf_tp_thu_space_to                  = s.wms_tf_tp_thu_space_to,
        tf_tp_equip_type                    = s.wms_tf_tp_equip_type,
        tf_tp_veh_type                      = s.wms_tf_tp_veh_type,
        tf_tp_timestamp                     = s.wms_tf_tp_timestamp,
        tf_tp_created_by                    = s.wms_tf_tp_created_by,
        tf_tp_created_dt                    = s.wms_tf_tp_created_dt,
        tf_tp_modified_by                   = s.wms_tf_tp_modified_by,
        tf_tp_modified_dt                   = s.wms_tf_tp_modified_dt,
        tf_tp_multilvl_approval             = s.wms_tf_tp_multilvl_approval,
        tf_tp_min_weight                    = s.wms_tf_tp_min_weight,
        tf_tp_min_volume                    = s.wms_tf_tp_min_volume,
        tf_tp_previous_status               = s.wms_tf_tp_previous_status,
        tf_tp_factor                        = s.wms_tf_tp_factor,
        tf_tp_leg_behavior                  = s.wms_tf_tp_leg_behavior,
        tf_tp_service_id                    = s.wms_tf_tp_service_id,
        non_billable_chk                    = s.wms_non_billable_chk,
        tf_tp_numeric_round_off             = s.wms_tf_tp_numeric_round_off,
        tf_tp_thu_volume_min_lim            = s.wms_tf_tp_thu_volume_min_lim,
        tf_tp_thu_weight_min_lim            = s.wms_tf_tp_thu_weight_min_lim,
        tf_tp_category                      = s.wms_tf_tp_category,
        tf_tp_load_type                     = s.wms_tf_tp_load_type,
        tf_tp_freight_charges               = s.wms_tf_tp_freight_charges,
        tf_tp_inco_terms                    = s.wms_tf_tp_inco_terms,
        tf_tp_rate_class                    = s.wms_tf_tp_rate_class,
        tf_tp_govt_status                   = s.wms_tf_tp_govt_status,
        tf_tp_uniq_note                     = s.wms_tf_tp_uniq_note,
        tf_tp_type_of_entry                 = s.wms_tf_tp_type_of_entry,
        tf_tp_uld_rating_type               = s.wms_tf_tp_uld_rating_type,
        tf_tp_uld_charge_code               = s.wms_tf_tp_uld_charge_code,
        tf_tp_dis_doc_type                  = s.wms_tf_tp_dis_doc_type,
        tf_tp_resource_type                 = s.wms_tf_tp_resource_type,
        tf_tp_no_of_thu_uom                 = s.wms_tf_tp_no_of_thu_uom,
        tf_tp_space_uom                     = s.wms_tf_tp_space_uom,
        tf_tp_cod_cop                       = s.wms_tf_tp_cod_cop,
        tf_tp_cod_cop_min                   = s.wms_tf_tp_cod_cop_min,
        tf_tp_cod_cop_max                   = s.wms_tf_tp_cod_cop_max,
        tf_tp_cod_cop_min_lim               = s.wms_tf_tp_cod_cop_min_lim,
        tf_tp_cod_cop_uom                   = s.wms_tf_tp_cod_cop_uom,
        tf_tp_declrd_value                  = s.wms_tf_tp_declrd_value,
        tf_tp_declrd_value_min              = s.wms_tf_tp_declrd_value_min,
        tf_tp_declrd_value_max              = s.wms_tf_tp_declrd_value_max,
        tf_tp_declrd_value_min_lim          = s.wms_tf_tp_declrd_value_min_lim,
        tf_tp_declrd_value_uom              = s.wms_tf_tp_declrd_value_uom,
        tf_tp_dutiable_value                = s.wms_tf_tp_dutiable_value,
        tf_tp_dutiable_value_min            = s.wms_tf_tp_dutiable_value_min,
        tf_tp_dutiable_value_max            = s.wms_tf_tp_dutiable_value_max,
        tf_tp_dutiable_value_min_lim        = s.wms_tf_tp_dutiable_value_min_lim,
        tf_tp_dutiable_value_uom            = s.wms_tf_tp_dutiable_value_uom,
        tf_tp_thu_length                    = s.wms_tf_tp_thu_length,
        tf_tp_thu_length_min                = s.wms_tf_tp_thu_length_min,
        tf_tp_thu_length_max                = s.wms_tf_tp_thu_length_max,
        tf_tp_thu_length_min_lim            = s.wms_tf_tp_thu_length_min_lim,
        tf_tp_thu_length_uom                = s.wms_tf_tp_thu_length_uom,
        tf_tp_thu_width                     = s.wms_tf_tp_thu_width,
        tf_tp_thu_width_min                 = s.wms_tf_tp_thu_width_min,
        tf_tp_thu_width_max                 = s.wms_tf_tp_thu_width_max,
        tf_tp_thu_width_min_lim             = s.wms_tf_tp_thu_width_min_lim,
        tf_tp_thu_width_uom                 = s.wms_tf_tp_thu_width_uom,
        tf_tp_thu_height                    = s.wms_tf_tp_thu_height,
        tf_tp_thu_height_min                = s.wms_tf_tp_thu_height_min,
        tf_tp_thu_height_max                = s.wms_tf_tp_thu_height_max,
        tf_tp_thu_height_min_lim            = s.wms_tf_tp_thu_height_min_lim,
        tf_tp_thu_height_uom                = s.wms_tf_tp_thu_height_uom,
        tf_tp_thu_distance_min_lim          = s.wms_tf_tp_thu_distance_min_lim,
        tf_tp_thu_trip_time_min_lim         = s.wms_tf_tp_thu_trip_time_min_lim,
        tf_tp_cost_type                     = s.wms_tf_tp_cost_type,
        tf_tp_area                          = s.wms_tf_tp_area,
        tf_tp_Origin_Via_Point              = s.wms_tf_tp_Origin_Via_Point,
        tf_tp_Dest_Via_Point                = s.wms_tf_tp_Dest_Via_Point,
        tf_tp_data_source                   = s.wms_tf_tp_data_source,
        tf_tp_directioncode_chk             = s.wms_tf_tp_directioncode_chk,
        tf_tp_proportional_Code             = s.wms_tf_tp_proportional_Code,
        tf_tp_uniq_addon_area_code          = s.wms_tf_tp_uniq_addon_area_code,
        tf_tp_no_of_thu_min                 = s.wms_tf_tp_no_of_thu_min,
        tf_tp_no_of_thu_max                 = s.wms_tf_tp_no_of_thu_max,
        tf_tp_space_min                     = s.wms_tf_tp_space_min,
        tf_tp_space_max                     = s.wms_tf_tp_space_max,
        tf_tp_no_of_thu                     = s.wms_tf_tp_no_of_thu,
        tf_tp_no_of_thu_min_lim             = s.wms_tf_tp_no_of_thu_min_lim,
        tf_tp_space                         = s.wms_tf_tp_space,
        tf_tp_space_min_lim                 = s.wms_tf_tp_space_min_lim,
        tf_acc_flag                         = s.wms_tf_acc_flag,
        tf_tp_Reciprocal_YN                 = s.wms_tf_tp_Reciprocal_YN,
        tf_tp_doc                           = s.wms_tf_tp_doc,
        tf_tp_min_doc                       = s.wms_tf_tp_min_doc,
        tf_tp_doc_min                       = s.wms_tf_tp_doc_min,
        tf_tp_doc_max                       = s.wms_tf_tp_doc_max,
        tf_tp_doc_uom                       = s.wms_tf_tp_doc_uom,
        tf_tp_doc_min_lim                   = s.wms_tf_tp_doc_min_lim,
        tf_tp_dec_id                        = s.wms_tf_tp_dec_id,
        tf_tp_consumables                   = s.wms_tf_tp_consumables,
        tf_tp_task                          = s.wms_tf_tp_task,
        tf_tp_job_type                      = s.wms_tf_tp_job_type,
        tf_tp_min_eqp                       = s.wms_tf_tp_min_eqp,
        tf_tp_eqp_min                       = s.wms_tf_tp_eqp_min,
        tf_tp_eqp_max                       = s.wms_tf_tp_eqp_max,
        tf_tp_eqp_uom                       = s.wms_tf_tp_eqp_uom,
        tf_tp_min_commodity                 = s.wms_tf_tp_min_commodity,
        tf_tp_commodity_min                 = s.wms_tf_tp_commodity_min,
        tf_tp_commodity_max                 = s.wms_tf_tp_commodity_max,
        tf_tp_commodity_uom                 = s.wms_tf_tp_commodity_uom,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
    FROM stg.stg_wms_tariff_transport_hdr s
    WHERE t.tf_tp_id = s.wms_tf_tp_id
    AND t.tf_tp_ou = s.wms_tf_tp_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TariffTransport
    (
        tf_tp_id						, tf_tp_ou					, tf_tp_desc					, tf_tp_type_code			, tf_tp_status					, 
		tf_tp_division					, tf_tp_location			, tf_tp_validity_id				, tf_tp_frm_ship_point		, tf_tp_to_ship_point			, 
		tf_tp_frm_geo_type				, tf_tp_frm_geo				, tf_tp_to_geo_type				, tf_tp_to_geo				, tf_tp_dist_check				, 
		tf_tp_dist_min					, tf_tp_dist_max			, tf_tp_dist_uom				, tf_tp_wt					, tf_tp_wt_min					, 
		tf_tp_wt_max					, tf_tp_wt_uom				, tf_tp_vol						, tf_tp_vol_min				, tf_tp_vol_max					,
		tf_tp_vol_uom					, tf_tp_trip_time			, tf_tp_trip_time_min			, tf_tp_trip_time_max		, tf_tp_trip_time_uom			, 
		tf_tp_vol_conversion			, tf_tp_service				, tf_tp_sub_service				, tf_tp_thu_type			, tf_tp_min_no_thu				, 
		tf_tp_max_no_thu				, tf_tp_class_of_stores		, tf_tp_thu_space_frm			, tf_tp_thu_space_to		, tf_tp_equip_type				, 
		tf_tp_veh_type					, tf_tp_timestamp			, tf_tp_created_by				, tf_tp_created_dt			, tf_tp_modified_by				, 
		tf_tp_modified_dt				, tf_tp_multilvl_approval	, tf_tp_min_weight				, tf_tp_min_volume			, tf_tp_previous_status			, 
		tf_tp_factor					, tf_tp_leg_behavior		, tf_tp_service_id				, non_billable_chk			, tf_tp_numeric_round_off		, 
		tf_tp_thu_volume_min_lim		, tf_tp_thu_weight_min_lim	, tf_tp_category				, tf_tp_load_type			, tf_tp_freight_charges			, 
		tf_tp_inco_terms				, tf_tp_rate_class			, tf_tp_govt_status				, tf_tp_uniq_note			, tf_tp_type_of_entry			,
		tf_tp_uld_rating_type			, tf_tp_uld_charge_code		, tf_tp_dis_doc_type			, tf_tp_resource_type		, tf_tp_no_of_thu_uom			, 
		tf_tp_space_uom					, tf_tp_cod_cop				, tf_tp_cod_cop_min				, tf_tp_cod_cop_max			, tf_tp_cod_cop_min_lim			, 
		tf_tp_cod_cop_uom				, tf_tp_declrd_value		, tf_tp_declrd_value_min		, tf_tp_declrd_value_max	, tf_tp_declrd_value_min_lim	,
		tf_tp_declrd_value_uom			, tf_tp_dutiable_value		, tf_tp_dutiable_value_min		, tf_tp_dutiable_value_max	, tf_tp_dutiable_value_min_lim	,
		tf_tp_dutiable_value_uom		, tf_tp_thu_length			, tf_tp_thu_length_min			, tf_tp_thu_length_max		, tf_tp_thu_length_min_lim		, 
		tf_tp_thu_length_uom			, tf_tp_thu_width			, tf_tp_thu_width_min			, tf_tp_thu_width_max		, tf_tp_thu_width_min_lim		, 
		tf_tp_thu_width_uom				, tf_tp_thu_height			, tf_tp_thu_height_min			, tf_tp_thu_height_max		, tf_tp_thu_height_min_lim		, 
		tf_tp_thu_height_uom			, tf_tp_thu_distance_min_lim, tf_tp_thu_trip_time_min_lim	, tf_tp_cost_type			, tf_tp_area					, 
		tf_tp_Origin_Via_Point			, tf_tp_Dest_Via_Point		, tf_tp_data_source				, tf_tp_directioncode_chk	, tf_tp_proportional_Code		, 
		tf_tp_uniq_addon_area_code		, tf_tp_no_of_thu_min		, tf_tp_no_of_thu_max			, tf_tp_space_min			, tf_tp_space_max				, 
		tf_tp_no_of_thu					, tf_tp_no_of_thu_min_lim	, tf_tp_space					, tf_tp_space_min_lim		, tf_acc_flag					, 
		tf_tp_Reciprocal_YN				, tf_tp_doc					, tf_tp_min_doc					, tf_tp_doc_min				, tf_tp_doc_max					, 
		tf_tp_doc_uom					, tf_tp_doc_min_lim			, tf_tp_dec_id					, tf_tp_consumables			, tf_tp_task					,
		tf_tp_job_type					, tf_tp_min_eqp				, tf_tp_eqp_min					, tf_tp_eqp_max				, tf_tp_eqp_uom					, 
		tf_tp_min_commodity				, tf_tp_commodity_min		, tf_tp_commodity_max			, tf_tp_commodity_uom		, 
		etlactiveind					, etljobname				, envsourcecd					, datasourcecd				, etlcreatedatetime
    )

    SELECT
        s.wms_tf_tp_id					, s.wms_tf_tp_ou					, s.wms_tf_tp_desc					, s.wms_tf_tp_type_code			, s.wms_tf_tp_status			, 
		s.wms_tf_tp_division			, s.wms_tf_tp_location				, s.wms_tf_tp_validity_id			, s.wms_tf_tp_frm_ship_point	, s.wms_tf_tp_to_ship_point		, 
		s.wms_tf_tp_frm_geo_type		, s.wms_tf_tp_frm_geo				, s.wms_tf_tp_to_geo_type			, s.wms_tf_tp_to_geo			, s.wms_tf_tp_dist_check		, 
		s.wms_tf_tp_dist_min			, s.wms_tf_tp_dist_max				, s.wms_tf_tp_dist_uom				, s.wms_tf_tp_wt				, s.wms_tf_tp_wt_min			, 
		s.wms_tf_tp_wt_max				, s.wms_tf_tp_wt_uom				, s.wms_tf_tp_vol					, s.wms_tf_tp_vol_min			, s.wms_tf_tp_vol_max			,
		s.wms_tf_tp_vol_uom				, s.wms_tf_tp_trip_time				, s.wms_tf_tp_trip_time_min			, s.wms_tf_tp_trip_time_max		, s.wms_tf_tp_trip_time_uom		, 
		s.wms_tf_tp_vol_conversion		, s.wms_tf_tp_service				, s.wms_tf_tp_sub_service			, s.wms_tf_tp_thu_type			, s.wms_tf_tp_min_no_thu		, 
		s.wms_tf_tp_max_no_thu			, s.wms_tf_tp_class_of_stores		, s.wms_tf_tp_thu_space_frm			, s.wms_tf_tp_thu_space_to		, s.wms_tf_tp_equip_type		, 
		s.wms_tf_tp_veh_type			, s.wms_tf_tp_timestamp				, s.wms_tf_tp_created_by			, s.wms_tf_tp_created_dt		, s.wms_tf_tp_modified_by		, 
		s.wms_tf_tp_modified_dt			, s.wms_tf_tp_multilvl_approval		, s.wms_tf_tp_min_weight			, s.wms_tf_tp_min_volume		, s.wms_tf_tp_previous_status	,
		s.wms_tf_tp_factor				, s.wms_tf_tp_leg_behavior			, s.wms_tf_tp_service_id			, s.wms_non_billable_chk		, s.wms_tf_tp_numeric_round_off	, 
		s.wms_tf_tp_thu_volume_min_lim	, s.wms_tf_tp_thu_weight_min_lim	, s.wms_tf_tp_category				, s.wms_tf_tp_load_type			, s.wms_tf_tp_freight_charges	, 
		s.wms_tf_tp_inco_terms			, s.wms_tf_tp_rate_class			, s.wms_tf_tp_govt_status			, s.wms_tf_tp_uniq_note			, s.wms_tf_tp_type_of_entry		, 
		s.wms_tf_tp_uld_rating_type		, s.wms_tf_tp_uld_charge_code		, s.wms_tf_tp_dis_doc_type			, s.wms_tf_tp_resource_type		, s.wms_tf_tp_no_of_thu_uom		, 
		s.wms_tf_tp_space_uom			, s.wms_tf_tp_cod_cop				, s.wms_tf_tp_cod_cop_min			, s.wms_tf_tp_cod_cop_max		, s.wms_tf_tp_cod_cop_min_lim	, 
		s.wms_tf_tp_cod_cop_uom			, s.wms_tf_tp_declrd_value			, s.wms_tf_tp_declrd_value_min		, s.wms_tf_tp_declrd_value_max	, s.wms_tf_tp_declrd_value_min_lim, 
		s.wms_tf_tp_declrd_value_uom	, s.wms_tf_tp_dutiable_value		, s.wms_tf_tp_dutiable_value_min	, s.wms_tf_tp_dutiable_value_max, s.wms_tf_tp_dutiable_value_min_lim, 
		s.wms_tf_tp_dutiable_value_uom	, s.wms_tf_tp_thu_length			, s.wms_tf_tp_thu_length_min		, s.wms_tf_tp_thu_length_max	, s.wms_tf_tp_thu_length_min_lim, 
		s.wms_tf_tp_thu_length_uom		, s.wms_tf_tp_thu_width				, s.wms_tf_tp_thu_width_min			, s.wms_tf_tp_thu_width_max		, s.wms_tf_tp_thu_width_min_lim	, 
		s.wms_tf_tp_thu_width_uom		, s.wms_tf_tp_thu_height			, s.wms_tf_tp_thu_height_min		, s.wms_tf_tp_thu_height_max	, s.wms_tf_tp_thu_height_min_lim, 
		s.wms_tf_tp_thu_height_uom		, s.wms_tf_tp_thu_distance_min_lim	, s.wms_tf_tp_thu_trip_time_min_lim	, s.wms_tf_tp_cost_type			, s.wms_tf_tp_area				, 
		s.wms_tf_tp_Origin_Via_Point	, s.wms_tf_tp_Dest_Via_Point		, s.wms_tf_tp_data_source			, s.wms_tf_tp_directioncode_chk	, s.wms_tf_tp_proportional_Code	, 
		s.wms_tf_tp_uniq_addon_area_code, s.wms_tf_tp_no_of_thu_min			, s.wms_tf_tp_no_of_thu_max			, s.wms_tf_tp_space_min			, s.wms_tf_tp_space_max			, 
		s.wms_tf_tp_no_of_thu			, s.wms_tf_tp_no_of_thu_min_lim		, s.wms_tf_tp_space					, s.wms_tf_tp_space_min_lim		, s.wms_tf_acc_flag				, 
		s.wms_tf_tp_Reciprocal_YN		, s.wms_tf_tp_doc					, s.wms_tf_tp_min_doc				, s.wms_tf_tp_doc_min			, s.wms_tf_tp_doc_max			, 
		s.wms_tf_tp_doc_uom				, s.wms_tf_tp_doc_min_lim			, s.wms_tf_tp_dec_id				, s.wms_tf_tp_consumables		, s.wms_tf_tp_task				, 
		s.wms_tf_tp_job_type			, s.wms_tf_tp_min_eqp				, s.wms_tf_tp_eqp_min				, s.wms_tf_tp_eqp_max			, s.wms_tf_tp_eqp_uom			, 
		s.wms_tf_tp_min_commodity		, s.wms_tf_tp_commodity_min			, s.wms_tf_tp_commodity_max			, s.wms_tf_tp_commodity_uom		, 
						1				, p_etljobname						, p_envsourcecd						, p_datasourcecd				, NOW()
    FROM stg.stg_wms_tariff_transport_hdr s
    LEFT JOIN dwh.D_TariffTransport t
    ON s.wms_tf_tp_id = t.tf_tp_id
    AND s.wms_tf_tp_ou = t.tf_tp_ou
    WHERE t.tf_tp_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_wms_tariff_transport_hdr
    (
        wms_tf_tp_id				, wms_tf_tp_ou						, wms_tf_tp_desc				, wms_tf_tp_type_code			, wms_tf_tp_status, 
		wms_tf_tp_division			, wms_tf_tp_location				, wms_tf_tp_validity_id			, wms_tf_tp_frm_ship_point		, wms_tf_tp_to_ship_point, 
		wms_tf_tp_frm_geo_type		, wms_tf_tp_frm_geo					, wms_tf_tp_to_geo_type			, wms_tf_tp_to_geo				, wms_tf_tp_dist_check, 
		wms_tf_tp_dist_min			, wms_tf_tp_dist_max				, wms_tf_tp_dist_uom			, wms_tf_tp_wt					, wms_tf_tp_wt_min,
		wms_tf_tp_wt_max			, wms_tf_tp_wt_uom					, wms_tf_tp_vol					, wms_tf_tp_vol_min				, wms_tf_tp_vol_max, 
		wms_tf_tp_vol_uom			, wms_tf_tp_trip_time				, wms_tf_tp_trip_time_min		, wms_tf_tp_trip_time_max		,
		wms_tf_tp_trip_time_uom		, wms_tf_tp_vol_conversion			, wms_tf_tp_service				, wms_tf_tp_sub_service			, 
		wms_tf_tp_thu_type			, wms_tf_tp_min_no_thu				, wms_tf_tp_max_no_thu			, wms_tf_tp_class_of_stores		, wms_tf_tp_thu_space_frm,
		wms_tf_tp_thu_space_to		, wms_tf_tp_equip_type				, wms_tf_tp_veh_type			, wms_tf_tp_timestamp			, wms_tf_tp_created_by, 
		wms_tf_tp_created_dt		, wms_tf_tp_modified_by				, wms_tf_tp_modified_dt			, wms_tf_tp_multilvl_approval	, wms_tf_tp_min_weight, 
		wms_tf_tp_min_volume		, wms_tf_tp_previous_status			, wms_tf_tp_factor				, wms_tf_tp_leg_behavior		, wms_tf_tp_service_id,
		wms_non_billable_chk		, wms_tf_tp_numeric_round_off		, wms_tf_tp_thu_volume_min_lim	, wms_tf_tp_thu_weight_min_lim	, wms_tf_tp_category, 
		wms_tf_tp_load_type			, wms_tf_tp_freight_charges			, wms_tf_tp_inco_terms			, wms_tf_tp_rate_class			, wms_tf_tp_govt_status, 
		wms_tf_tp_uniq_note			, wms_tf_tp_type_of_entry			, wms_tf_tp_uld_rating_type		, wms_tf_tp_uld_charge_code		, wms_tf_tp_dis_doc_type, 
		wms_tf_tp_resource_type		, wms_tf_tp_no_of_thu_uom			, wms_tf_tp_space_uom			, wms_tf_tp_cod_cop				, wms_tf_tp_cod_cop_min,
		wms_tf_tp_cod_cop_max		, wms_tf_tp_cod_cop_min_lim			, wms_tf_tp_cod_cop_uom			, wms_tf_tp_declrd_value		, wms_tf_tp_declrd_value_min, 
		wms_tf_tp_declrd_value_max	, wms_tf_tp_declrd_value_min_lim	, wms_tf_tp_declrd_value_uom	, wms_tf_tp_dutiable_value		, wms_tf_tp_dutiable_value_min,
		wms_tf_tp_dutiable_value_max, wms_tf_tp_dutiable_value_min_lim	, wms_tf_tp_dutiable_value_uom	, wms_tf_tp_thu_length			, wms_tf_tp_thu_length_min,
		wms_tf_tp_thu_length_max	, wms_tf_tp_thu_length_min_lim		, wms_tf_tp_thu_length_uom		, wms_tf_tp_thu_width			, wms_tf_tp_thu_width_min, 
		wms_tf_tp_thu_width_max		, wms_tf_tp_thu_width_min_lim		, wms_tf_tp_thu_width_uom		, wms_tf_tp_thu_height			, wms_tf_tp_thu_height_min, 
		wms_tf_tp_thu_height_max	, wms_tf_tp_thu_height_min_lim		, wms_tf_tp_thu_height_uom		, wms_tf_tp_thu_distance_min_lim, wms_tf_tp_thu_trip_time_min_lim,
		wms_tf_tp_cost_type			, wms_tf_tp_area					, wms_tf_tp_Origin_Via_Point	, wms_tf_tp_Dest_Via_Point		, wms_tf_tp_data_source, 
		wms_tf_tp_directioncode_chk	, wms_tf_tp_proportional_Code		, wms_tf_tp_uniq_addon_area_code, wms_tf_tp_no_of_thu_min		, wms_tf_tp_no_of_thu_max,
		wms_tf_tp_space_min			, wms_tf_tp_space_max				, wms_tf_tp_no_of_thu			, wms_tf_tp_no_of_thu_min_lim	, wms_tf_tp_space, 
		wms_tf_tp_space_min_lim		, wms_tf_acc_flag					, wms_tf_tp_Reciprocal_YN		, wms_tf_tp_doc					, wms_tf_tp_min_doc, 
		wms_tf_tp_doc_min			, wms_tf_tp_doc_max					, wms_tf_tp_doc_uom				, wms_tf_tp_doc_min_lim			, wms_tf_tp_dec_id, 
		wms_tf_tp_consumables		, wms_tf_tp_task					, wms_tf_tp_job_type			, wms_tf_tp_min_eqp				, wms_tf_tp_eqp_min, 
		wms_tf_tp_eqp_max			, wms_tf_tp_eqp_uom					, wms_tf_tp_min_commodity		, wms_tf_tp_commodity_min		, wms_tf_tp_commodity_max, 
		wms_tf_tp_commodity_uom		, etlcreateddatetime
    )
    SELECT
		wms_tf_tp_id				, wms_tf_tp_ou						, wms_tf_tp_desc				, wms_tf_tp_type_code			, wms_tf_tp_status, 
		wms_tf_tp_division			, wms_tf_tp_location				, wms_tf_tp_validity_id			, wms_tf_tp_frm_ship_point		, wms_tf_tp_to_ship_point, 
		wms_tf_tp_frm_geo_type		, wms_tf_tp_frm_geo					, wms_tf_tp_to_geo_type			, wms_tf_tp_to_geo				, wms_tf_tp_dist_check, 
		wms_tf_tp_dist_min			, wms_tf_tp_dist_max				, wms_tf_tp_dist_uom			, wms_tf_tp_wt					, wms_tf_tp_wt_min,
		wms_tf_tp_wt_max			, wms_tf_tp_wt_uom					, wms_tf_tp_vol					, wms_tf_tp_vol_min				, wms_tf_tp_vol_max, 
		wms_tf_tp_vol_uom			, wms_tf_tp_trip_time				, wms_tf_tp_trip_time_min		, wms_tf_tp_trip_time_max		,
		wms_tf_tp_trip_time_uom		, wms_tf_tp_vol_conversion			, wms_tf_tp_service				, wms_tf_tp_sub_service			, 
		wms_tf_tp_thu_type			, wms_tf_tp_min_no_thu				, wms_tf_tp_max_no_thu			, wms_tf_tp_class_of_stores		, wms_tf_tp_thu_space_frm,
		wms_tf_tp_thu_space_to		, wms_tf_tp_equip_type				, wms_tf_tp_veh_type			, wms_tf_tp_timestamp			, wms_tf_tp_created_by, 
		wms_tf_tp_created_dt		, wms_tf_tp_modified_by				, wms_tf_tp_modified_dt			, wms_tf_tp_multilvl_approval	, wms_tf_tp_min_weight, 
		wms_tf_tp_min_volume		, wms_tf_tp_previous_status			, wms_tf_tp_factor				, wms_tf_tp_leg_behavior		, wms_tf_tp_service_id,
		wms_non_billable_chk		, wms_tf_tp_numeric_round_off		, wms_tf_tp_thu_volume_min_lim	, wms_tf_tp_thu_weight_min_lim	, wms_tf_tp_category, 
		wms_tf_tp_load_type			, wms_tf_tp_freight_charges			, wms_tf_tp_inco_terms			, wms_tf_tp_rate_class			, wms_tf_tp_govt_status, 
		wms_tf_tp_uniq_note			, wms_tf_tp_type_of_entry			, wms_tf_tp_uld_rating_type		, wms_tf_tp_uld_charge_code		, wms_tf_tp_dis_doc_type, 
		wms_tf_tp_resource_type		, wms_tf_tp_no_of_thu_uom			, wms_tf_tp_space_uom			, wms_tf_tp_cod_cop				, wms_tf_tp_cod_cop_min,
		wms_tf_tp_cod_cop_max		, wms_tf_tp_cod_cop_min_lim			, wms_tf_tp_cod_cop_uom			, wms_tf_tp_declrd_value		, wms_tf_tp_declrd_value_min, 
		wms_tf_tp_declrd_value_max	, wms_tf_tp_declrd_value_min_lim	, wms_tf_tp_declrd_value_uom	, wms_tf_tp_dutiable_value		, wms_tf_tp_dutiable_value_min,
		wms_tf_tp_dutiable_value_max, wms_tf_tp_dutiable_value_min_lim	, wms_tf_tp_dutiable_value_uom	, wms_tf_tp_thu_length			, wms_tf_tp_thu_length_min,
		wms_tf_tp_thu_length_max	, wms_tf_tp_thu_length_min_lim		, wms_tf_tp_thu_length_uom		, wms_tf_tp_thu_width			, wms_tf_tp_thu_width_min, 
		wms_tf_tp_thu_width_max		, wms_tf_tp_thu_width_min_lim		, wms_tf_tp_thu_width_uom		, wms_tf_tp_thu_height			, wms_tf_tp_thu_height_min, 
		wms_tf_tp_thu_height_max	, wms_tf_tp_thu_height_min_lim		, wms_tf_tp_thu_height_uom		, wms_tf_tp_thu_distance_min_lim, wms_tf_tp_thu_trip_time_min_lim,
		wms_tf_tp_cost_type			, wms_tf_tp_area					, wms_tf_tp_Origin_Via_Point	, wms_tf_tp_Dest_Via_Point		, wms_tf_tp_data_source, 
		wms_tf_tp_directioncode_chk	, wms_tf_tp_proportional_Code		, wms_tf_tp_uniq_addon_area_code, wms_tf_tp_no_of_thu_min		, wms_tf_tp_no_of_thu_max,
		wms_tf_tp_space_min			, wms_tf_tp_space_max				, wms_tf_tp_no_of_thu			, wms_tf_tp_no_of_thu_min_lim	, wms_tf_tp_space, 
		wms_tf_tp_space_min_lim		, wms_tf_acc_flag					, wms_tf_tp_Reciprocal_YN		, wms_tf_tp_doc					, wms_tf_tp_min_doc, 
		wms_tf_tp_doc_min			, wms_tf_tp_doc_max					, wms_tf_tp_doc_uom				, wms_tf_tp_doc_min_lim			, wms_tf_tp_dec_id, 
		wms_tf_tp_consumables		, wms_tf_tp_task					, wms_tf_tp_job_type			, wms_tf_tp_min_eqp				, wms_tf_tp_eqp_min, 
		wms_tf_tp_eqp_max			, wms_tf_tp_eqp_uom					, wms_tf_tp_min_commodity		, wms_tf_tp_commodity_min		, wms_tf_tp_commodity_max, 
		wms_tf_tp_commodity_uom		, etlcreateddatetime
		FROM stg.stg_wms_tariff_transport_hdr;
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