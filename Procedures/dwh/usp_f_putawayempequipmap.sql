CREATE PROCEDURE dwh.usp_f_putawayempequipmap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	p_etljobname VARCHAR(100);
	p_envsourcecd VARCHAR(50);
	p_datasourcecd VARCHAR(50);
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;	

    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
    
    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_putaway_emp_equip_map_dtl;

	UPDATE dwh.f_putawayempequipmap t
    SET 
		  pway_eqp_map_loc_key			= COALESCE(l.loc_key,-1)
		, pway_eqp_map_zone_key			= COALESCE(z.zone_key,-1)
		, pway_eqp_map_eqp_key		    = COALESCE(q.eqp_key,-1)
		, pway_eqp_map_emp_hdr_key		= COALESCE(e.emp_hdr_key,-1)
		, putaway_shift_code            = s.wms_putaway_shift_code
		, putaway_emp_code 	            = s.wms_putaway_emp_code
		, putaway_euip_code             = s.wms_putaway_euip_code
		, putaway_area 		            = s.wms_putaway_area
		, putaway_zone 		            = s.wms_putaway_zone 
    	, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_putaway_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_putaway_loc_code 		= l.loc_code 
        AND s.wms_putaway_ou        	= l.loc_ou
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_putaway_zone 	        = z.zone_code
        AND s.wms_putaway_ou        	= z.zone_ou
	LEFT JOIN dwh.d_equipment q 		
		ON  s.wms_putaway_euip_code  	= q.eqp_equipment_id 
        AND s.wms_putaway_ou        	= q.eqp_ou
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_putaway_emp_code  	= e.emp_employee_code 
        AND s.wms_putaway_ou        	= e.emp_ou	
    WHERE   t.putaway_loc_code 			= s.wms_putaway_loc_code
		AND	t.putaway_ou 				= s.wms_putaway_ou
		AND	t.putaway_lineno 			= s.wms_putaway_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_putawayempequipmap
	(
           pway_eqp_map_loc_key	    ,pway_eqp_map_zone_key	,pway_eqp_map_eqp_key	    ,pway_eqp_map_emp_hdr_key 		
            ,putaway_loc_code			,putaway_ou				,putaway_lineno				,putaway_shift_code
		    ,putaway_emp_code			,putaway_euip_code		,putaway_area				,putaway_zone
            ,etlactiveind			    ,etljobname			    ,envsourcecd				,datasourcecd	            
            ,etlcreatedatetime
	)
	
	SELECT 
           COALESCE(l.loc_key,-1)	        , COALESCE(z.zone_key,-1)	    ,COALESCE(q.eqp_key,-1)	        ,COALESCE(e.emp_hdr_key,-1)		
		   , s.wms_putaway_loc_code			, s.wms_putaway_ou				, s.wms_putaway_lineno			, s.wms_putaway_shift_code
		   , s.wms_putaway_emp_code			, s.wms_putaway_euip_code		, s.wms_putaway_area			, s.wms_putaway_zone
           , 1 AS etlactiveind			    , p_etljobname				    , p_envsourcecd				    , p_datasourcecd	                
           , NOW()
	FROM stg.stg_wms_putaway_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_putaway_loc_code 		= l.loc_code 
        AND s.wms_putaway_ou        	= l.loc_ou
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_putaway_zone 	        = z.zone_code
        AND s.wms_putaway_ou        	= z.zone_ou
		AND s.wms_putaway_loc_code		= z.zone_loc_code
	LEFT JOIN dwh.d_equipment q 		
		ON  s.wms_putaway_euip_code  	= q.eqp_equipment_id 
        AND s.wms_putaway_ou        	= q.eqp_ou
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_putaway_emp_code  	= e.emp_employee_code 
        AND s.wms_putaway_ou        	= e.emp_ou	
	LEFT JOIN dwh.f_putawayempequipmap t  	
		ON  t.putaway_loc_code 			= s.wms_putaway_loc_code
		AND	t.putaway_ou 				= s.wms_putaway_ou
		AND	t.putaway_lineno 			= s.wms_putaway_lineno
    WHERE t.putaway_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_putaway_emp_equip_map_dtl
	(
		wms_putaway_loc_code, 			wms_putaway_ou, 			wms_putaway_lineno, 		wms_putaway_shift_code, 
		wms_putaway_emp_code, 			wms_putaway_euip_code, 		wms_putaway_area, 			wms_putaway_zone, 
		etlcreateddatetime
	)
	SELECT 
		wms_putaway_loc_code, 			wms_putaway_ou, 			wms_putaway_lineno, 		wms_putaway_shift_code, 
		wms_putaway_emp_code, 			wms_putaway_euip_code, 		wms_putaway_area, 			wms_putaway_zone, 
		etlcreateddatetime
	FROM stg.stg_wms_putaway_emp_equip_map_dtl;
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