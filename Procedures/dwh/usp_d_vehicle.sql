CREATE PROCEDURE dwh.usp_d_vehicle(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_veh_mas_hdr;

	UPDATE dwh.D_Vehicle t  --Change variables and table name
    SET -- logical column name = s.column name
		
		veh_desc			= s.wms_veh_desc,
		veh_status			= s.wms_veh_status,
		veh_rsn_code		= s.wms_veh_rsn_code,
		veh_vin				= s.wms_veh_vin,
		veh_type			= s.wms_veh_type,
		veh_own_typ			= s.wms_veh_own_typ,
		veh_agency_id		= s.wms_veh_agency_id,
		veh_agency_contno	= s.wms_veh_agency_contno,
		veh_build_date		= s.wms_veh_build_date,
		veh_def_loc			= s.wms_veh_def_loc,
		veh_cur_loc			= s.wms_veh_cur_loc,
		veh_cur_loc_since	= s.wms_veh_cur_loc_since,
		veh_trans_typ		= s.wms_veh_trans_typ,
		veh_fuel_used		= s.wms_veh_fuel_used,
		veh_steering_type	= s.wms_veh_steering_type,
		veh_colour			= s.wms_veh_colour,
		veh_wt_uom			= s.wms_veh_wt_uom,
		veh_tare			= s.wms_veh_tare,
		veh_vehicle_gross	= s.wms_veh_vehicle_gross,
		veh_gross_com		= s.wms_veh_gross_com,
		veh_dim_uom			= s.wms_veh_dim_uom,
		veh_length			= s.wms_veh_length,
		veh_width			= s.wms_veh_width,
		veh_height			= s.wms_veh_height,
		veh_created_by		= s.wms_veh_created_by,
		veh_created_date	= s.wms_veh_created_date,
		veh_modified_by		= s.wms_veh_modified_by,
		veh_modified_date	= s.wms_veh_modified_date,
		veh_timestamp		= s.wms_veh_timestamp,
		veh_refrigerated	= s.wms_veh_refrigerated,
		veh_intransit		= s.wms_veh_intransit,
		veh_route			= s.wms_veh_route,
		veh_and				= s.wms_veh_and,
		veh_between			= s.wms_veh_between,
		veh_category		= s.wms_veh_category,
		veh_use_of_haz		= s.wms_veh_use_of_haz,
		veh_in_dim_uom		= s.wms_veh_in_dim_uom,
		veh_in_length		= s.wms_veh_in_length,
		veh_in_width		= s.wms_veh_in_width,
		veh_in_height		= s.wms_veh_in_height,
		veh_vol_uom			= s.wms_veh_vol_uom,
		veh_over_vol		= s.wms_veh_over_vol,
		veh_internal_vol	= s.wms_veh_internal_vol,
		veh_purchase_date	= s.wms_veh_purchase_date,
		veh_induct_date		= s.wms_veh_induct_date,
		veh_rigid			= s.wms_veh_rigid,
		veh_home_geo_type	= s.wms_veh_home_geo_type,
		veh_current_geo_type= s.wms_veh_current_geo_type,
		veh_ownrshp_EftFrm	= s.wms_veh_ownrshp_EftFrm,
		veh_raise_int_drfbill= s.wms_veh_raise_int_drfbill,
		veh_prev_geo_type	= s.wms_veh_prev_geo_type,
		veh_Prev_loc		= s.wms_veh_Prev_loc,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_veh_mas_hdr s		--staging table name in sheet
    WHERE t.veh_ou	  		= s.wms_veh_ou --unique and primary key
	AND t.veh_id 				= s.wms_veh_id;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_Vehicle -- table name
	(-- logical column names except last 5
		veh_ou,					veh_id,				veh_desc,				veh_status,				veh_rsn_code,
		veh_vin,				veh_type,			veh_own_typ,			veh_agency_id,			veh_agency_contno,
		veh_build_date,			veh_def_loc,		veh_cur_loc,			veh_cur_loc_since,		veh_trans_typ,
		veh_fuel_used,			veh_steering_type,	veh_colour,				veh_wt_uom,				veh_tare,				
		veh_vehicle_gross,		veh_gross_com,		veh_dim_uom,			veh_length,				veh_width,
		veh_height,				veh_created_by,		veh_created_date,		veh_modified_by,		veh_modified_date,					veh_timestamp,			veh_refrigerated,	veh_intransit,			veh_route,				veh_and,				
		veh_between,			veh_category,		veh_use_of_haz,			veh_in_dim_uom,			veh_in_length,				
		veh_in_width,			veh_in_height,		veh_vol_uom,			veh_over_vol,			veh_internal_vol,				veh_purchase_date,		veh_induct_date,	veh_rigid,				veh_home_geo_type,		veh_current_geo_type,				veh_ownrshp_EftFrm,		veh_raise_int_drfbill,						veh_prev_geo_type,		veh_Prev_loc,				
		etlactiveind,
        etljobname, 		envsourcecd, 		datasourcecd, 			etlcreatedatetime
	)
	
    SELECT  -- normal column name except last 5
		s.wms_veh_ou,			s.wms_veh_id,		s.wms_veh_desc,			s.wms_veh_status,		s.wms_veh_rsn_code,	
		s.wms_veh_vin,			s.wms_veh_type,		s.wms_veh_own_typ,		s.wms_veh_agency_id,	s.wms_veh_agency_contno,
		s.wms_veh_build_date,	s.wms_veh_def_loc,	s.wms_veh_cur_loc,		s.wms_veh_cur_loc_since,s.wms_veh_trans_typ,
		s.wms_veh_fuel_used,	s.wms_veh_steering_type,s.wms_veh_colour,	s.wms_veh_wt_uom,		s.wms_veh_tare,	
		s.wms_veh_vehicle_gross,s.wms_veh_gross_com,s.wms_veh_dim_uom,		s.wms_veh_length,		s.wms_veh_width,	
		s.wms_veh_height,		s.wms_veh_created_by,s.wms_veh_created_date,s.wms_veh_modified_by,	s.wms_veh_modified_date,				
		s.wms_veh_timestamp,	s.wms_veh_refrigerated,s.wms_veh_intransit,	s.wms_veh_route,		s.wms_veh_and,
		s.wms_veh_between,		s.wms_veh_category,	s.wms_veh_use_of_haz,	s.wms_veh_in_dim_uom,	s.wms_veh_in_length,
		s.wms_veh_in_width,		s.wms_veh_in_height,s.wms_veh_vol_uom,		s.wms_veh_over_vol,		s.wms_veh_internal_vol,
		s.wms_veh_purchase_date,s.wms_veh_induct_date,s.wms_veh_rigid,		s.wms_veh_home_geo_type,s.wms_veh_current_geo_type,	
		s.wms_veh_ownrshp_EftFrm,s.wms_veh_raise_int_drfbill,				s.wms_veh_prev_geo_type,s.wms_veh_Prev_loc,
		1,		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_wms_veh_mas_hdr s -- staging table name
    LEFT JOIN dwh.D_Vehicle t -- table name
    ON 	s.wms_veh_ou  		= t.veh_ou -- only unique, no pkeys
	AND s.wms_veh_id 			= t.veh_id
    WHERE t.veh_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_veh_mas_hdr --  staging table name
	(
	    wms_veh_ou, wms_veh_id, wms_veh_desc, wms_veh_status, wms_veh_rsn_code, wms_veh_vin, wms_veh_model, 
        wms_veh_type, wms_veh_own_typ, wms_veh_agency_id, wms_veh_agency_contno, wms_veh_build_date, 
        wms_veh_chassis_num, wms_veh_ref_num, wms_veh_equip_id, wms_veh_asset_id, wms_veh_asset_tag, 
        wms_veh_reg_num, wms_veh_address, wms_veh_tit_hold_name, wms_veh_req_date, wms_veh_effect_date, 
        wms_veh_exp_date, wms_veh_renew_date, wms_veh_renew_fee, wms_veh_renew, wms_veh_def_loc, 
        wms_veh_cur_loc, wms_veh_cur_loc_since, wms_veh_gps_ref_num, wms_veh_engine_num, wms_veh_engine_cap, 
        wms_veh_trans_typ, wms_veh_trans_typ_uom, wms_veh_fuel_used, wms_veh_tank_cap, wms_veh_tank_cap_uom, 
        wms_veh_seating_cap, wms_veh_steering_type, wms_veh_colour, wms_veh_wt_uom, wms_veh_tare,
        wms_veh_vehicle_gross, wms_veh_gross_com, wms_veh_dim_uom, wms_veh_length, wms_veh_width, wms_veh_height,
        wms_veh_mileage_uom, wms_veh_no_load, wms_veh_full_load, wms_veh_average, wms_veh_created_by,
        wms_veh_created_date, wms_veh_modified_by, wms_veh_modified_date, wms_veh_timestamp, wms_veh_userdefined1, 
        wms_veh_userdefined2, wms_veh_userdefined3, wms_veh_engine_number, wms_veh_refrigerated, wms_veh_temp_uom, 
        wms_veh_temp_minimum, wms_veh_temp_maximum, wms_veh_intransit, wms_veh_route, wms_veh_and, wms_veh_between, 
        wms_veh_category, wms_veh_no_of_axies, wms_veh_make, wms_veh_gps_dev_typ, wms_veh_use_of_haz, 
        wms_veh_in_dim_uom, wms_veh_in_length, wms_veh_in_width, wms_veh_in_height, wms_veh_eng_cap_uom,
        wms_veh_vol_uom, wms_veh_over_vol, wms_veh_internal_vol, wms_veh_purchase_date, wms_veh_induct_date, 
        wms_veh_rigid, wms_veh_current_loc_desc, wms_veh_home_loc_desc, wms_veh_home_geo_type, 
        wms_veh_current_geo_type, wms_veh_ownrshp_eftfrm, wms_veh_pallet_space, wms_veh_raise_int_drfbill, 
        wms_veh_prev_geo_type, wms_veh_prev_loc, wms_veh_axle_config, wms_veh_avgspd_uom, wms_veh_avspd_noload,
        wms_veh_avspd_coupled, wms_veh_avspd_couple_load, wms_veh_last_bill_date, wms_veh_last_prev_bill_date, 
        etlcreateddatetime

	
	)
	SELECT 
		wms_veh_ou, wms_veh_id, wms_veh_desc, wms_veh_status, wms_veh_rsn_code, wms_veh_vin, wms_veh_model, 
        wms_veh_type, wms_veh_own_typ, wms_veh_agency_id, wms_veh_agency_contno, wms_veh_build_date, 
        wms_veh_chassis_num, wms_veh_ref_num, wms_veh_equip_id, wms_veh_asset_id, wms_veh_asset_tag, 
        wms_veh_reg_num, wms_veh_address, wms_veh_tit_hold_name, wms_veh_req_date, wms_veh_effect_date, 
        wms_veh_exp_date, wms_veh_renew_date, wms_veh_renew_fee, wms_veh_renew, wms_veh_def_loc, 
        wms_veh_cur_loc, wms_veh_cur_loc_since, wms_veh_gps_ref_num, wms_veh_engine_num, wms_veh_engine_cap, 
        wms_veh_trans_typ, wms_veh_trans_typ_uom, wms_veh_fuel_used, wms_veh_tank_cap, wms_veh_tank_cap_uom, 
        wms_veh_seating_cap, wms_veh_steering_type, wms_veh_colour, wms_veh_wt_uom, wms_veh_tare,
        wms_veh_vehicle_gross, wms_veh_gross_com, wms_veh_dim_uom, wms_veh_length, wms_veh_width, wms_veh_height,
        wms_veh_mileage_uom, wms_veh_no_load, wms_veh_full_load, wms_veh_average, wms_veh_created_by,
        wms_veh_created_date, wms_veh_modified_by, wms_veh_modified_date, wms_veh_timestamp, wms_veh_userdefined1, 
        wms_veh_userdefined2, wms_veh_userdefined3, wms_veh_engine_number, wms_veh_refrigerated, wms_veh_temp_uom, 
        wms_veh_temp_minimum, wms_veh_temp_maximum, wms_veh_intransit, wms_veh_route, wms_veh_and, wms_veh_between, 
        wms_veh_category, wms_veh_no_of_axies, wms_veh_make, wms_veh_gps_dev_typ, wms_veh_use_of_haz, 
        wms_veh_in_dim_uom, wms_veh_in_length, wms_veh_in_width, wms_veh_in_height, wms_veh_eng_cap_uom,
        wms_veh_vol_uom, wms_veh_over_vol, wms_veh_internal_vol, wms_veh_purchase_date, wms_veh_induct_date, 
        wms_veh_rigid, wms_veh_current_loc_desc, wms_veh_home_loc_desc, wms_veh_home_geo_type, 
        wms_veh_current_geo_type, wms_veh_ownrshp_eftfrm, wms_veh_pallet_space, wms_veh_raise_int_drfbill, 
        wms_veh_prev_geo_type, wms_veh_prev_loc, wms_veh_axle_config, wms_veh_avgspd_uom, wms_veh_avspd_noload,
        wms_veh_avspd_coupled, wms_veh_avspd_couple_load, wms_veh_last_bill_date, wms_veh_last_prev_bill_date, 
        etlcreateddatetime

	FROM stg.stg_wms_veh_mas_hdr;
	END IF;
	
	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
								
		select 0 into inscnt;
       select 0 into updcnt;
END;
$$;