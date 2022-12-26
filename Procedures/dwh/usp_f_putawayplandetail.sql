-- PROCEDURE: dwh.usp_f_putawayplandetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_putawayplandetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_putawayplandetail(
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_putaway_plan_dtl;

	UPDATE dwh.F_PutawayPlanDetail t
    SET 
		 
		  pway_pln_dtl_loc_key			= COALESCE(l.loc_key,-1)
		, pway_pln_dtl_date_key			= COALESCE(d.datekey,-1)
		, pway_pln_dtl_stg_mas_key		= COALESCE(g.stg_mas_key,-1)
		, pway_pln_dtl_emp_hdr_key		= COALESCE(e.emp_hdr_key,-1)
		, pway_pln_date                 = s.wms_pway_pln_date 
		, pway_pln_status               = s.wms_pway_pln_status 
		, pway_stag_id                  = s.wms_pway_stag_id 
		, pway_mhe_id                   = s.wms_pway_mhe_id 
		, pway_employee_id              = s.wms_pway_employee_id 
		, pway_source_stage             = s.wms_pway_source_stage 
		, pway_source_docno             = s.wms_pway_source_docno 
		, pway_created_by               = s.wms_pway_created_by 
		, pway_created_date             = s.wms_pway_created_date 
		, pway_modified_by              = s.wms_pway_modified_by 
		, pway_modified_date            = s.wms_pway_modified_date 
		, pway_timestamp                = s.wms_pway_timestamp 
		, pway_output_pln               = s.wms_pway_output_pln 
		, pway_type                     = s.wms_pway_type 
		, pway_comp_flag                = s.wms_pway_comp_flag 
		, pway_first_pln_no             = s.wms_pway_first_pln_no 
		, pway_by_flag                  = s.wms_pway_by_flag 
    	, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_putaway_plan_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 		= l.loc_code 
        AND s.wms_pway_pln_ou        	= l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON s.wms_pway_pln_date::date 	= d.dateactual
	LEFT JOIN dwh.d_stage g 		
		ON s.wms_pway_stag_id  			= g.stg_mas_id 
        AND s.wms_pway_pln_ou        	= g.stg_mas_ou
        AND s.wms_pway_loc_code         = g.stg_mas_loc
	LEFT JOIN dwh.d_employeeheader e 		
		ON s.wms_pway_employee_id  		= e.emp_employee_code 
        AND s.wms_pway_pln_ou        	= e.emp_ou	
    WHERE   t.pway_loc_code 			= s.wms_pway_loc_code
		AND	t.pway_pln_no 				= s.wms_pway_pln_no
		AND	t.pway_pln_ou 				= s.wms_pway_pln_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.F_PutawayPlanDetail
	(
		    pway_pln_dtl_loc_key	, pway_pln_dtl_date_key	, pway_pln_dtl_stg_mas_key	, pway_pln_dtl_emp_hdr_key 		
            , pway_loc_code    		, pway_pln_no      		, pway_pln_ou      			, pway_pln_date    			, pway_pln_status  
            , pway_stag_id     		, pway_mhe_id      		, pway_employee_id 			, pway_source_stage			, pway_source_docno
            , pway_created_by  		, pway_created_date		, pway_modified_by 			, pway_modified_date		, pway_timestamp   
            , pway_output_pln  		, pway_type        		, pway_comp_flag   			, pway_first_pln_no			, pway_by_flag,
            etlactiveind			, etljobname			, envsourcecd				, datasourcecd	            , etlcreatedatetime
	)
	
	SELECT 
		   COALESCE(l.loc_key,-1)	        , d.datekey	                    ,COALESCE(g.stg_mas_key,-1)	        ,COALESCE(e.emp_hdr_key,-1) 		
		   , s.wms_pway_loc_code    		, s.wms_pway_pln_no      		, s.wms_pway_pln_ou      			, s.wms_pway_pln_date    			, s.wms_pway_pln_status  
           , s.wms_pway_stag_id     		, s.wms_pway_mhe_id      		, s.wms_pway_employee_id 			, s.wms_pway_source_stage			, s.wms_pway_source_docno
           , s.wms_pway_created_by  		, s.wms_pway_created_date		, s.wms_pway_modified_by 			, s.wms_pway_modified_date			, s.wms_pway_timestamp   
           , s.wms_pway_output_pln  		, s.wms_pway_type        		, s.wms_pway_comp_flag   			, s.wms_pway_first_pln_no			, s.wms_pway_by_flag,
           1 AS etlactiveind			    , p_etljobname				    , p_envsourcecd				        , p_datasourcecd	                , NOW()
	FROM stg.stg_wms_putaway_plan_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 		= l.loc_code 
        AND s.wms_pway_pln_ou        	= l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON s.wms_pway_pln_date::date 	= d.dateactual
	LEFT JOIN dwh.d_stage g 		
		ON s.wms_pway_stag_id  			= g.stg_mas_id 
        AND s.wms_pway_pln_ou        	= g.stg_mas_ou
        AND s.wms_pway_loc_code         = g.stg_mas_loc
	LEFT JOIN dwh.d_employeeheader e 		
		ON s.wms_pway_employee_id  		= e.emp_employee_code 
        AND s.wms_pway_pln_ou        	= e.emp_ou		
	LEFT JOIN dwh.F_PutawayPlanDetail fh  	
		ON  fh.pway_loc_code 			= s.wms_pway_loc_code
		AND	fh.pway_pln_no 				= s.wms_pway_pln_no
		AND	fh.pway_pln_ou 				= s.wms_pway_pln_ou
    WHERE fh.pway_pln_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_putaway_plan_dtl
	(
		wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_pln_date, wms_pway_pln_status,
		wms_pway_stag_id, wms_pway_mhe_id, wms_pway_employee_id, wms_pway_source_stage,
		wms_pway_source_docno, wms_pway_created_by, wms_pway_created_date, wms_pway_modified_by,
		wms_pway_modified_date, wms_pway_timestamp, wms_pway_output_pln, wms_pway_userdefined1,
		wms_pway_userdefined2, wms_pway_userdefined3, wms_pway_type, wms_pway_comp_flag,
		wms_pway_first_pln_no, wms_pway_by_flag, etlcreateddatetime
	
	)
	SELECT 
		wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_pln_date, wms_pway_pln_status,
		wms_pway_stag_id, wms_pway_mhe_id, wms_pway_employee_id, wms_pway_source_stage,
		wms_pway_source_docno, wms_pway_created_by, wms_pway_created_date, wms_pway_modified_by,
		wms_pway_modified_date, wms_pway_timestamp, wms_pway_output_pln, wms_pway_userdefined1,
		wms_pway_userdefined2, wms_pway_userdefined3, wms_pway_type, wms_pway_comp_flag,
		wms_pway_first_pln_no, wms_pway_by_flag, etlcreateddatetime
	FROM stg.stg_wms_putaway_plan_dtl;
    END IF;	
	
    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
        
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt; 	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_putawayplandetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
