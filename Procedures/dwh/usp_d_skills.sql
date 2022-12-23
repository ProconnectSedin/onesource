CREATE PROCEDURE dwh.usp_d_skills(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_skill_dtl;

	UPDATE dwh.d_skills t
    SET 

		skl_desc 				= s.wms_skl_desc,
		skl_currency 			= s.wms_skl_currency,
		skl_status 				= s.wms_skl_status,
		skl_timestamp 			= s.wms_skl_timestamp,
		skl_created_by 			= s.wms_skl_created_by,
		skl_created_dt 			= s.wms_skl_created_dt,		
		skl_modified_by 		= s.wms_skl_modified_by,
		skl_modified_dt         = s.wms_skl_modified_dt,                
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	

    FROM stg.stg_wms_skill_dtl s
    WHERE  t.skl_ou 	    	= s.wms_skl_ou
	AND t.skl_code 				= s.wms_skl_code
	AND t.skl_type 				= s.wms_skl_type;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_skills
	(
		skl_ou,	          	skl_code,		    skl_type,		skl_desc,
		skl_currency, 	  	skl_status, 	    skl_timestamp,  skl_created_by, 	
		skl_created_dt,		skl_modified_by,  	skl_modified_dt, 	etlactiveind, 	
		etljobname, 		envsourcecd, 		datasourcecd,	  	etlcreatedatetime
	)
    SELECT 
    	s.wms_skl_ou,			s.wms_skl_code,			s.wms_skl_type,			s.wms_skl_desc,			
		s.wms_skl_currency,		s.wms_skl_status,		s.wms_skl_timestamp,	s.wms_skl_created_by,   
		s.wms_skl_created_dt,	s.wms_skl_modified_by,	s.wms_skl_modified_dt,	1, 
		p_etljobname,			p_envsourcecd,			p_datasourcecd,			NOW ()
	FROM stg.stg_wms_skill_dtl s
    LEFT JOIN dwh.d_skills t
    ON 	s.wms_skl_ou			= t.skl_ou
	AND  s.wms_skl_code 		= t.skl_code
	AND s.wms_skl_type 			= t.skl_type 
    WHERE t.skl_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_skill_dtl
	(
	    wms_skl_ou, wms_skl_code, wms_skl_loc_code, wms_skl_type, wms_skl_desc, wms_skl_rate, 
        wms_skl_currency, wms_skl_per, wms_skl_unit, wms_skl_status, wms_skl_timestamp, 
        wms_skl_created_by, wms_skl_created_dt, wms_skl_modified_by, wms_skl_modified_dt, 
        wms_skl_user_def1, wms_skl_user_def2, wms_skl_user_def3, wms_skl_lineno, etlcreateddatetime
	
	)
	SELECT 
		wms_skl_ou, wms_skl_code, wms_skl_loc_code, wms_skl_type, wms_skl_desc, wms_skl_rate, 
        wms_skl_currency, wms_skl_per, wms_skl_unit, wms_skl_status, wms_skl_timestamp, 
        wms_skl_created_by, wms_skl_created_dt, wms_skl_modified_by, wms_skl_modified_dt, 
        wms_skl_user_def1, wms_skl_user_def2, wms_skl_user_def3, wms_skl_lineno, etlcreateddatetime
	FROM stg.stg_wms_skill_dtl;
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