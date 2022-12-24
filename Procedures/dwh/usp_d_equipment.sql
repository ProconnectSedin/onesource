CREATE OR REPLACE PROCEDURE dwh.usp_d_equipment(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_equipment_hdr;

	UPDATE dwh.d_equipment t
    SET 
		 eqp_description 		= s.wms_eqp_description
		,eqp_status 			= s.wms_eqp_status
		,eqp_type 				= s.wms_eqp_type
		,eqp_hazardous_goods 	= s.wms_eqp_hazardous_goods
		,eqp_owner_type 		= s.wms_eqp_owner_type
		,eqp_default_location 	= s.wms_eqp_default_location
		,eqp_current_location 	= s.wms_eqp_current_location
		,eqp_timestamp 			= s.wms_eqp_timestamp
		,eqp_created_date 		= s.wms_eqp_created_date
		,eqp_created_by 		= s.wms_eqp_created_by
		,eqp_modified_date 		= s.wms_eqp_modified_date
		,eqp_modified_by 		= s.wms_eqp_modified_by
		,eqp_intransit 			= s.wms_eqp_intransit
		,eqp_refrigerated 		= s.wms_eqp_refrigerated
		,veh_current_geo_type 	= s.wms_veh_current_geo_type
		,eqp_raise_int_drfbill 	= s.wms_eqp_raise_int_drfbill
		,etlactiveind 				= 1
		,etljobname 				= p_etljobname
		,envsourcecd 				= p_envsourcecd 
		,datasourcecd 				= p_datasourcecd
		,etlupdatedatetime 			= NOW()
    FROM stg.stg_wms_equipment_hdr s
    WHERE t.eqp_equipment_id  		= s.wms_eqp_equipment_id
	AND t.eqp_ou 					= s.wms_eqp_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_equipment
	(
		 eqp_ou					,eqp_equipment_id		,eqp_description		,eqp_status				,eqp_type
		,eqp_hazardous_goods	,eqp_owner_type			,eqp_default_location	,eqp_current_location	,eqp_timestamp
		,eqp_created_date		,eqp_created_by			,eqp_modified_date		,eqp_modified_by		,eqp_intransit
		,eqp_refrigerated		,veh_current_geo_type	,eqp_raise_int_drfbill
		,etlactiveind			,etljobname				,envsourcecd			,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		 s.wms_eqp_ou				,s.wms_eqp_equipment_id		,s.wms_eqp_description		,s.wms_eqp_status			,s.wms_eqp_type
		,s.wms_eqp_hazardous_goods	,s.wms_eqp_owner_type		,s.wms_eqp_default_location	,s.wms_eqp_current_location	,s.wms_eqp_timestamp
		,s.wms_eqp_created_date		,s.wms_eqp_created_by		,s.wms_eqp_modified_date	,s.wms_eqp_modified_by		,s.wms_eqp_intransit
		,s.wms_eqp_refrigerated		,s.wms_veh_current_geo_type	,s.wms_eqp_raise_int_drfbill
		,1							,p_etljobname				,p_envsourcecd				,p_datasourcecd			,NOW()
	FROM stg.stg_wms_equipment_hdr s
    LEFT JOIN dwh.d_equipment t
    ON 	s.wms_eqp_equipment_id  	= t.eqp_equipment_id
	AND s.wms_eqp_ou 				= t.eqp_ou
    WHERE t.eqp_equipment_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
 
	
	INSERT INTO raw.raw_wms_equipment_hdr
	(
		wms_eqp_ou, 					wms_eqp_equipment_id, 		wms_eqp_description, 			wms_eqp_status, 			wms_eqp_reasoncode, 
		wms_eqp_type, 					wms_eqp_category, 			wms_eqp_reference_id, 			wms_eqp_asset_id, 			wms_eqp_asset_tag, 
		wms_eqp_registration_num, 		wms_eqp_registration_name, 	wms_eqp_hazardous_goods, 		wms_eqp_owner_type, 		wms_eqp_agencyid, 
		wms_eqp_registration_eff_date, 	wms_eqp_agency_contract_num,wms_eqp_registration_address, 	wms_eqp_mfg_name, 			wms_eqp_mfg_date, 
		wms_eqp_purchase_date, 			wms_eqp_inducted_date, 		wms_eqp_running_cost, 			wms_eqp_unit, 				wms_eqp_ref_doc_number, 
		wms_eqp_default_location, 		wms_eqp_current_location, 	wms_eqp_in_current_location, 	wms_eqp_weight_uom, 		wms_eqp_tare, 
		wms_eqp_max_allowable, 			wms_eqp_interior_uom, 		wms_eqp_interior_length, 		wms_eqp_interior_width, 	wms_eqp_interior_height, 
		wms_eqp_exterior_uom, 			wms_eqp_exterior_length,	wms_eqp_exterior_width, 		wms_eqp_exterior_height,	wms_eqp_temperature_uom, 
		wms_eqp_temperature_minimum, 	wms_eqp_temperature_maximum,wms_eqp_volume, 				wms_eqp_volume_uom, 		wms_eqp_teu_count, 
		wms_eqp_feu_count, 				wms_eqp_life_eqp_capacity, 	wms_eqp_load_lift, 				wms_eqp_height_lift, 		wms_eqp_timestamp, 
		wms_eqp_created_date, 			wms_eqp_created_by, 		wms_eqp_modified_date, 			wms_eqp_modified_by, 		wms_eqp_userdefined1, 
		wms_eqp_userdefined2, 			wms_eqp_userdefined3, 		wms_eqp_intransit, 				wms_eqp_route, 				wms_eqp_between, 
		wms_eqp_and, 					wms_eqp_gross_comb_mass, 	wms_eqp_gross_veh_mass, 		wms_eqp_overall_vol, 		wms_eqp_internal_vol, 
		wms_eqp_refrigerated, 			wms_eqp_load_lift_uom, 		wms_eqp_height_lift_uom, 		wms_eqp_no_of_axles, 		wms_veh_current_loc_desc, 
		wms_veh_home_loc_desc, 			wms_veh_home_geo_type, 		wms_veh_current_geo_type, 		wms_equip_ownrshp_eftfrm, 	wms_eqp_pallet_space, 
		wms_eqp_raise_int_drfbill, 		wms_chassis_number, 		wms_min_weight, 				wms_max_weight, 			wms_min_length, 		
		wms_load_carrying_weight_uom, 	wms_max_lenght, 			wms_min_width, 					wms_max_width, 				wms_min_height,
		wms_max_height, 				wms_load_carrying_uom,		wms_eqp_make, 					wms_eqp_model, 				wms_eqp_gen_uom,
		wms_eqp_gen_coupled, 			wms_eqp_gen_coupled_loaded, wms_eqp_emp_id,					wms_eqp_commodity, 			wms_eqp_cls_of_stores, 		
		wms_eqp_last_bill_date, 		etlcreateddatetime
	)
	SELECT 
		wms_eqp_ou, 					wms_eqp_equipment_id, 		wms_eqp_description, 			wms_eqp_status, 			wms_eqp_reasoncode, 
		wms_eqp_type, 					wms_eqp_category, 			wms_eqp_reference_id, 			wms_eqp_asset_id, 			wms_eqp_asset_tag, 
		wms_eqp_registration_num, 		wms_eqp_registration_name, 	wms_eqp_hazardous_goods, 		wms_eqp_owner_type, 		wms_eqp_agencyid, 
		wms_eqp_registration_eff_date, 	wms_eqp_agency_contract_num,wms_eqp_registration_address, 	wms_eqp_mfg_name, 			wms_eqp_mfg_date, 
		wms_eqp_purchase_date, 			wms_eqp_inducted_date, 		wms_eqp_running_cost, 			wms_eqp_unit, 				wms_eqp_ref_doc_number, 
		wms_eqp_default_location, 		wms_eqp_current_location, 	wms_eqp_in_current_location, 	wms_eqp_weight_uom, 		wms_eqp_tare, 
		wms_eqp_max_allowable, 			wms_eqp_interior_uom, 		wms_eqp_interior_length, 		wms_eqp_interior_width, 	wms_eqp_interior_height, 
		wms_eqp_exterior_uom, 			wms_eqp_exterior_length,	wms_eqp_exterior_width, 		wms_eqp_exterior_height,	wms_eqp_temperature_uom, 
		wms_eqp_temperature_minimum, 	wms_eqp_temperature_maximum,wms_eqp_volume, 				wms_eqp_volume_uom, 		wms_eqp_teu_count, 
		wms_eqp_feu_count, 				wms_eqp_life_eqp_capacity, 	wms_eqp_load_lift, 				wms_eqp_height_lift, 		wms_eqp_timestamp, 
		wms_eqp_created_date, 			wms_eqp_created_by, 		wms_eqp_modified_date, 			wms_eqp_modified_by, 		wms_eqp_userdefined1, 
		wms_eqp_userdefined2, 			wms_eqp_userdefined3, 		wms_eqp_intransit, 				wms_eqp_route, 				wms_eqp_between, 
		wms_eqp_and, 					wms_eqp_gross_comb_mass, 	wms_eqp_gross_veh_mass, 		wms_eqp_overall_vol, 		wms_eqp_internal_vol, 
		wms_eqp_refrigerated, 			wms_eqp_load_lift_uom, 		wms_eqp_height_lift_uom, 		wms_eqp_no_of_axles, 		wms_veh_current_loc_desc, 
		wms_veh_home_loc_desc, 			wms_veh_home_geo_type, 		wms_veh_current_geo_type, 		wms_equip_ownrshp_eftfrm, 	wms_eqp_pallet_space, 
		wms_eqp_raise_int_drfbill, 		wms_chassis_number, 		wms_min_weight, 				wms_max_weight, 			wms_min_length, 		
		wms_load_carrying_weight_uom, 	wms_max_lenght, 			wms_min_width, 					wms_max_width, 				wms_min_height,
		wms_max_height, 				wms_load_carrying_uom,		wms_eqp_make, 					wms_eqp_model, 				wms_eqp_gen_uom,
		wms_eqp_gen_coupled, 			wms_eqp_gen_coupled_loaded, wms_eqp_emp_id,					wms_eqp_commodity, 			wms_eqp_cls_of_stores, 		
		wms_eqp_last_bill_date,			etlcreateddatetime
	FROM stg.stg_wms_equipment_hdr;	
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