CREATE OR REPLACE PROCEDURE dwh.usp_d_zone(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_zone_hdr;

	UPDATE dwh.d_zone t  --Change variables and table name
    SET -- logical column name = s.column name
		zone_description			= s.wms_zone_description,
		zone_status					= s.wms_zone_status,
		zone_reason					= s.wms_zone_reason,
		zone_type					= s.wms_zone_type,
		zone_pick_strategy			= s.wms_zone_pick_strategy,
		zone_pick_req_confirm		= s.wms_zone_pick_req_confirm,
		zone_block_picking			= s.wms_zone_block_picking,
		zone_pick_label				= s.wms_zone_pick_label,
		zone_pick_per_picklist		= s.wms_zone_pick_per_picklist,
		zone_pick_by				= s.wms_zone_pick_by,
		zone_pick_sequence			= s.wms_zone_pick_sequence,
		zone_put_strategy			= s.wms_zone_put_strategy,
		zone_put_req_confirm		= s.wms_zone_put_req_confirm,
		zone_add_existing_stk		= s.wms_zone_add_existing_stk,
		zone_block_putaway			= s.wms_zone_block_putaway,
		zone_capacity_check			= s.wms_zone_capacity_check,
		zone_mixed_storage			= s.wms_zone_mixed_storage,
		zone_mixed_stor_strategy	= s.wms_zone_mixed_stor_strategy,
		zone_timestamp				= s.wms_zone_timestamp,
		zone_created_by				= s.wms_zone_created_by,
		zone_created_date			= s.wms_zone_created_date,
		zone_modified_by			= s.wms_zone_modified_by,
		zone_modified_date			= s.wms_zone_modified_date,
		zone_step					= s.wms_zone_step,
		zone_pick					= s.wms_zone_pick,
		zone_matchpallet_qty		= s.wms_zone_matchpallet_qty,
		zone_batch_allowed			= s.wms_zone_batch_allowed,
		zone_uid_allowed			= s.wms_zone_uid_allowed,
		zone_pick_stage				= s.wms_zone_pick_stage,
		zone_putaway_stage			= s.wms_zone_putaway_stage,
		zone_cap_chk				= s.wms_zone_cap_chk,
		zone_packing				= s.wms_zone_packing,
		zone_adv_pick_strategy		= s.wms_zone_adv_pick_strategy,
		zone_adv_pwy_strategy		= s.wms_zone_adv_pwy_strategy,
		pcs_noofmnth				= s.pcs_noofmnth,	
		
		etlactiveind 				= 1,
		etljobname 					= p_etljobname,
		envsourcecd 				= p_envsourcecd ,
		datasourcecd 				= p_datasourcecd ,
		etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_zone_hdr s		--staging table name in sheet
    WHERE t.zone_code	  		= s.wms_zone_code --unique and primary key
	AND t.zone_ou 				= s.wms_zone_ou
	AND t.zone_loc_code 		= s.wms_zone_loc_code;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_zone -- table name
	(-- logical column names except last 5
		zone_code,			zone_ou,			zone_loc_code,			zone_description,		zone_status,		
		zone_reason,		zone_type,			zone_pick_strategy,		zone_pick_req_confirm,
		zone_block_picking,	zone_pick_label,	zone_pick_per_picklist,	zone_pick_by,
		zone_pick_sequence,	zone_put_strategy,	zone_put_req_confirm,	zone_add_existing_stk,
		zone_block_putaway,	zone_capacity_check,zone_mixed_storage,		zone_mixed_stor_strategy,
		zone_timestamp,		zone_created_by,	zone_created_date,		zone_modified_by,
		zone_modified_date,	zone_step,			zone_pick,				zone_matchpallet_qty,
		zone_batch_allowed,	zone_uid_allowed,	zone_pick_stage,		zone_putaway_stage,
		zone_cap_chk,		zone_packing,		zone_adv_pick_strategy,	zone_adv_pwy_strategy,
		pcs_noofmnth,		etlactiveind,
        etljobname, 		envsourcecd, 		datasourcecd, 			etlcreatedatetime
	)
	
    SELECT  -- normal column name except last 5
		s.wms_zone_code,			s.wms_zone_ou,				s.wms_zone_loc_code,		s.wms_zone_description,		s.wms_zone_status,
		s.wms_zone_reason,			s.wms_zone_type,			s.wms_zone_pick_strategy,	s.wms_zone_pick_req_confirm,		
		s.wms_zone_block_picking,	s.wms_zone_pick_label,		s.wms_zone_pick_per_picklist,s.wms_zone_pick_by,		
		s.wms_zone_pick_sequence,	s.wms_zone_put_strategy,	s.wms_zone_put_req_confirm,	s.wms_zone_add_existing_stk,		
		s.wms_zone_block_putaway,	s.wms_zone_capacity_check,	s.wms_zone_mixed_storage,	s.wms_zone_mixed_stor_strategy,		
		s.wms_zone_timestamp,		s.wms_zone_created_by,		s.wms_zone_created_date,	s.wms_zone_modified_by,		
		s.wms_zone_modified_date,	s.wms_zone_step,			s.wms_zone_pick,			s.wms_zone_matchpallet_qty,		
		s.wms_zone_batch_allowed,	s.wms_zone_uid_allowed,		s.wms_zone_pick_stage,		s.wms_zone_putaway_stage,		
		s.wms_zone_cap_chk,			s.wms_zone_packing,			s.wms_zone_adv_pick_strategy,s.wms_zone_adv_pwy_strategy,		
		s.pcs_noofmnth,				1,		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_wms_zone_hdr s -- staging table name
    LEFT JOIN dwh.d_zone t -- table name
    ON 	s.wms_zone_code  		= t.zone_code -- only unique, no pkeys
	AND s.wms_zone_ou 			= t.zone_ou
	AND s.wms_zone_loc_code		= t.zone_loc_code
    WHERE t.zone_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_zone_hdr --  staging table name
	(
     wms_zone_code, wms_zone_ou, wms_zone_loc_code, wms_zone_description, wms_zone_status,
        wms_zone_reason, wms_zone_type, wms_zone_overflow_zone, wms_zone_singlestep_pick, 
        wms_zone_doublestep_pick, wms_zone_minimum, wms_zone_maximum, wms_zone_uom, 
        wms_zone_pick_strategy, wms_zone_pick_req_confirm, wms_zone_block_picking, 
        wms_zone_pick_label, wms_zone_pick_per_picklist, wms_zone_pick_by, wms_zone_pick_sequence, 
        wms_zone_put_strategy, wms_zone_put_req_confirm, wms_zone_add_existing_stk, wms_zone_block_putaway, 
        wms_zone_capacity_check, wms_zone_mixed_storage, wms_zone_mixed_stor_strategy, wms_zone_timestamp,
        wms_zone_created_by, wms_zone_created_date, wms_zone_modified_by, wms_zone_modified_date, 
        wms_zone_userdefined1, wms_zone_userdefined2, wms_zone_userdefined3, wms_zone_step, wms_zone_pick, 
        wms_zone_matchpallet_qty, wms_zone_batch_allowed, wms_zone_uid_allowed, wms_zone_pick_stage, 
        wms_zone_putaway_stage, wms_zone_cap_chk, wms_zone_packing, wms_zone_adv_pick_strategy, 
        wms_zone_adv_pwy_strategy, pcs_zone_putaway_strategy, pcs_noofmnth, etlcreateddatetime

	)
	SELECT 
     wms_zone_code, wms_zone_ou, wms_zone_loc_code, wms_zone_description, wms_zone_status,
        wms_zone_reason, wms_zone_type, wms_zone_overflow_zone, wms_zone_singlestep_pick, 
        wms_zone_doublestep_pick, wms_zone_minimum, wms_zone_maximum, wms_zone_uom, 
        wms_zone_pick_strategy, wms_zone_pick_req_confirm, wms_zone_block_picking, 
        wms_zone_pick_label, wms_zone_pick_per_picklist, wms_zone_pick_by, wms_zone_pick_sequence, 
        wms_zone_put_strategy, wms_zone_put_req_confirm, wms_zone_add_existing_stk, wms_zone_block_putaway, 
        wms_zone_capacity_check, wms_zone_mixed_storage, wms_zone_mixed_stor_strategy, wms_zone_timestamp,
        wms_zone_created_by, wms_zone_created_date, wms_zone_modified_by, wms_zone_modified_date, 
        wms_zone_userdefined1, wms_zone_userdefined2, wms_zone_userdefined3, wms_zone_step, wms_zone_pick, 
        wms_zone_matchpallet_qty, wms_zone_batch_allowed, wms_zone_uid_allowed, wms_zone_pick_stage, 
        wms_zone_putaway_stage, wms_zone_cap_chk, wms_zone_packing, wms_zone_adv_pick_strategy, 
        wms_zone_adv_pwy_strategy, pcs_zone_putaway_strategy, pcs_noofmnth, etlcreateddatetime
	FROM stg.stg_wms_zone_hdr;
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