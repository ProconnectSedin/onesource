CREATE PROCEDURE dwh.usp_d_thu(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_thu_hdr;

	UPDATE dwh.d_thu t
    SET 
		thu_description 			= s.wms_thu_description,
        thu_bulk 					= s.wms_thu_bulk,
        thu_class 					= s.wms_thu_class,
        thu_status 					= s.wms_thu_status,
        thu_reason_code 			= s.wms_thu_reason_code,
        thu_tare 					= s.wms_thu_tare,
        thu_max_allowable 			= s.wms_thu_max_allowable,
        thu_weight_uom 				= s.wms_thu_weight_uom,
        thu_uom 					= s.wms_thu_uom,
        thu_int_length 				= s.wms_thu_int_length,
        thu_int_width				= s.wms_thu_int_width,
        thu_int_height				= s.wms_thu_int_height,
        thu_int_uom					= s.wms_thu_int_uom,
        thu_ext_length				= s.wms_thu_ext_length,
        thu_ext_width				= s.wms_thu_ext_width,
        thu_ext_height				= s.wms_thu_ext_height,
        thu_ext_uom					= s.wms_thu_ext_uom,
        thu_timestamp 				= s.wms_thu_timestamp,
        thu_created_by 				= s.wms_thu_created_by,
        thu_created_date 			= s.wms_thu_created_date,
        thu_modified_by 			= s.wms_thu_modified_by,
        thu_modified_date 			= s.wms_thu_modified_date,
        thu_size 					= s.wms_thu_size,
        thu_eligible_cubing			= s.wms_thu_eligible_cubing,
        thu_area 					= s.wms_thu_area,
        thu_weight_const 			= s.wms_thu_weight_const,
        thu_volume_const 			= s.wms_thu_volume_const,
        thu_unit_pallet_const		= s.wms_thu_unit_pallet_const,
        thu_max_unit_permissable	= s.wms_thu_max_unit_permissable,
        thu_stage_mapping			= s.wms_thu_stage_mapping,
        thu_ser_cont				= s.wms_thu_ser_cont,
        thu_is_ethu					= s.wms_thu_is_ethu,
        thu_volume_uom				= s.wms_thu_volume_uom,
        etlactiveind 				= 1,
        etljobname 					= p_etljobname,
        envsourcecd 				= p_envsourcecd ,
        datasourcecd 				= p_datasourcecd ,
        etlupdatedatetime 			= NOW()		
    FROM stg.stg_wms_thu_hdr s
    WHERE t.thu_id  		= s.wms_thu_id
	AND t.thu_ou 			= s.wms_thu_ou;
	
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_thu
	(
	thu_id,					thu_ou,						thu_description,				thu_bulk,		
	thu_class,				thu_status,					thu_reason_code,				thu_tare,		
	thu_max_allowable,		thu_weight_uom,				thu_uom,						thu_int_length,		
	thu_int_width,			thu_int_height,				thu_int_uom,					thu_ext_length,		
	thu_ext_width,			thu_ext_height,				thu_ext_uom,					thu_timestamp,		
	thu_created_by,			thu_created_date,			thu_modified_by,				thu_modified_date,		
	thu_size,				thu_eligible_cubing,		thu_area,						thu_weight_const,	 
	thu_volume_const,		thu_unit_pallet_const,		thu_max_unit_permissable,		thu_stage_mapping,		
	thu_ser_cont,			thu_is_ethu,				thu_volume_uom,					etlactiveind, 
	etljobname, 			envsourcecd, 				datasourcecd, 					etlcreatedatetime
	)
	
    SELECT 
	s.wms_thu_id,					s.wms_thu_ou,						s.wms_thu_description,					s.wms_thu_bulk,		
	s.wms_thu_class,				s.wms_thu_status,					s.wms_thu_reason_code,					s.wms_thu_tare,		
	s.wms_thu_max_allowable,		s.wms_thu_weight_uom,				s.wms_thu_uom,							s.wms_thu_int_length,		
	s.wms_thu_int_width,			s.wms_thu_int_height,				s.wms_thu_int_uom,						s.wms_thu_ext_length,		
	s.wms_thu_ext_width,			s.wms_thu_ext_height,				s.wms_thu_ext_uom,						s.wms_thu_timestamp,		
	s.wms_thu_created_by,			s.wms_thu_created_date,				s.wms_thu_modified_by,					s.wms_thu_modified_date,		
	s.wms_thu_size,					s.wms_thu_eligible_cubing,			s.wms_thu_area,							s.wms_thu_weight_const,	 
	s.wms_thu_volume_const,			s.wms_thu_unit_pallet_const,		s.wms_thu_max_unit_permissable,			s.wms_thu_stage_mapping,		
	s.wms_thu_ser_cont,				s.wms_thu_is_ethu,					s.wms_thu_volume_uom,					1, 
	p_etljobname, 					p_envsourcecd, 						p_datasourcecd, 						now()
	
	FROM stg.stg_wms_thu_hdr s
    LEFT JOIN dwh.d_thu t
    ON 	s.wms_thu_id  		= t.thu_id
	AND s.wms_thu_ou 		= t.thu_ou
	 
    WHERE t.thu_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_thu_hdr
	(
		 wms_thu_id, 				wms_thu_ou, 				wms_thu_description, 		wms_thu_bulk, 
		 wms_thu_class, 			wms_thu_status, 			wms_thu_reason_code, 		wms_thu_tare, 
		 wms_thu_max_allowable, 	wms_thu_weight_uom, 		wms_thu_material, 			wms_thu_uom, 
		 wms_thu_int_length, 		wms_thu_int_width, 			wms_thu_int_height, 		wms_thu_int_uom, 
		 wms_thu_ext_length, 		wms_thu_ext_width, 			wms_thu_ext_height, 		wms_thu_ext_uom, 
		 wms_thu_timestamp, 		wms_thu_created_by, 		wms_thu_created_date, 		wms_thu_modified_by, 	
		 wms_thu_modified_date, 	wms_thu_userdefined1,		wms_thu_userdefined2, 		wms_thu_userdefined3, 
		 wms_thu_size, 			    wms_thu_eligible_cubing,	wms_thu_area, 				wms_thu_area_uom, 			
		 wms_thu_weight_const, 		wms_thu_volume_const,		wms_thu_unit_pallet_const, 	wms_thu_max_unit_permissable, 
		 wms_thu_stage_mapping, 	wms_thu_ser_cont, 			wms_thu_is_ethu, 			wms_thu_volume_uom, 
		 etlcreateddatetime	
	)
	SELECT 
		 wms_thu_id, 				wms_thu_ou, 				wms_thu_description, 		wms_thu_bulk, 
		 wms_thu_class, 			wms_thu_status, 			wms_thu_reason_code, 		wms_thu_tare, 
		 wms_thu_max_allowable, 	wms_thu_weight_uom, 		wms_thu_material, 			wms_thu_uom, 
		 wms_thu_int_length, 		wms_thu_int_width, 			wms_thu_int_height, 		wms_thu_int_uom, 
		 wms_thu_ext_length, 		wms_thu_ext_width, 			wms_thu_ext_height, 		wms_thu_ext_uom, 
		 wms_thu_timestamp, 		wms_thu_created_by, 		wms_thu_created_date, 		wms_thu_modified_by, 	
		 wms_thu_modified_date, 	wms_thu_userdefined1,		wms_thu_userdefined2, 		wms_thu_userdefined3, 
		 wms_thu_size, 			    wms_thu_eligible_cubing,	wms_thu_area, 				wms_thu_area_uom, 			
		 wms_thu_weight_const, 		wms_thu_volume_const,		wms_thu_unit_pallet_const, 	wms_thu_max_unit_permissable, 
		 wms_thu_stage_mapping, 	wms_thu_ser_cont, 			wms_thu_is_ethu, 			wms_thu_volume_uom, 
		 etlcreateddatetime	
    FROM stg.stg_wms_thu_hdr;
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