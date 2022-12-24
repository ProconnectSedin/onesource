-- PROCEDURE: dwh.usp_f_putawayexecdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_putawayexecdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_putawayexecdetail(
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
     p_depsource VARCHAR(100);
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
        
    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN
    
    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_putaway_exec_dtl;

	UPDATE dwh.f_putawayexecdetail t
    SET 
		  pway_pln_dtl_key			    = fh.pway_pln_dtl_key,
		  pway_exe_dtl_loc_key			= COALESCE(l.loc_key,-1)
		, pway_exe_dtl_eqp_key			= COALESCE(d.eqp_key,-1)
		, pway_exe_dtl_stg_mas_key		= COALESCE(g.stg_mas_key,-1)
		, pway_exe_dtl_emp_hdr_key		= COALESCE(e.emp_hdr_key,-1)
		, pway_pln_no                   = s.wms_pway_pln_no
		, pway_pln_ou                   = s.wms_pway_pln_ou
		, pway_exec_status              = s.wms_pway_exec_status
		, pway_stag_id                  = s.wms_pway_stag_id
		, pway_mhe_id                   = s.wms_pway_mhe_id
		, pway_employee_id              = s.wms_pway_employee_id
		, pway_exec_start_date          = s.wms_pway_exec_start_date
		, pway_exec_end_date            = s.wms_pway_exec_end_date
		, pway_completed                = s.wms_pway_completed
		, pway_created_by               = s.wms_pway_created_by
		, pway_created_date             = s.wms_pway_created_date
		, pway_modified_by              = s.wms_pway_modified_by
		, pway_modified_date            = s.wms_pway_modified_date
		, pway_timestamp                = s.wms_pway_timestamp
		, pway_type                     = s.wms_pway_type
		, pway_by_flag                  = s.wms_pway_by_flag
		, pway_gen_from                 = s.wms_pway_gen_from
    	, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_putaway_exec_dtl s
    LEFT JOIN 	dwh.f_putawayplandetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_pln_no 	= fh.pway_pln_no 
			AND s.wms_pway_pln_ou 	= fh.pway_pln_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 		= l.loc_code 
        AND s.wms_pway_pln_ou        	= l.loc_ou
	LEFT JOIN dwh.d_equipment d 			
		ON  s.wms_pway_mhe_id 	        = d.eqp_equipment_id
        AND s.wms_pway_pln_ou        	= d.eqp_ou
	LEFT JOIN dwh.d_stage g 		
		ON  s.wms_pway_stag_id  		= g.stg_mas_id 
        AND s.wms_pway_pln_ou        	= g.stg_mas_ou
		AND s.wms_pway_loc_code			= g.stg_mas_loc
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_pway_employee_id  	= e.emp_employee_code 
        AND s.wms_pway_pln_ou        	= e.emp_ou	
    WHERE   t.pway_loc_code 			= s.wms_pway_loc_code
		AND	t.pway_exec_no 				= s.wms_pway_exec_no
		AND	t.pway_exec_ou 				= s.wms_pway_exec_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_putawayexecdetail
	(
		pway_pln_dtl_key,           pway_exe_dtl_loc_key	    , pway_exe_dtl_eqp_key	    , pway_exe_dtl_stg_mas_key	, pway_exe_dtl_emp_hdr_key 		
        , pway_loc_code				, pway_exec_no				, pway_exec_ou				, pway_pln_no			, pway_pln_ou
		, pway_exec_status			, pway_stag_id				, pway_mhe_id				, pway_employee_id		, pway_exec_start_date
		, pway_exec_end_date		, pway_completed			, pway_created_by			, pway_created_date		, pway_modified_by
		, pway_modified_date		, pway_timestamp			, pway_type					, pway_by_flag			, pway_gen_from
        , etlactiveind			    , etljobname			    , envsourcecd				, datasourcecd	        , etlcreatedatetime
	)
	
	SELECT 
		fh.pway_pln_dtl_key,                COALESCE(l.loc_key,-1)	            , COALESCE(d.eqp_key,-1)	        , COALESCE(g.stg_mas_key,-1)	    , COALESCE(e.emp_hdr_key,-1) 		
		, s.wms_pway_loc_code				, s.wms_pway_exec_no				, s.wms_pway_exec_ou				, s.wms_pway_pln_no				, s.wms_pway_pln_ou
		, s.wms_pway_exec_status			, s.wms_pway_stag_id				, s.wms_pway_mhe_id					, s.wms_pway_employee_id		, s.wms_pway_exec_start_date
		, s.wms_pway_exec_end_date			, s.wms_pway_completed				, s.wms_pway_created_by				, s.wms_pway_created_date		, s.wms_pway_modified_by
		, s.wms_pway_modified_date			, s.wms_pway_timestamp				, s.wms_pway_type					, s.wms_pway_by_flag			, s.wms_pway_gen_from
        , 1 AS etlactiveind			        , p_etljobname				        , p_envsourcecd				        , p_datasourcecd	            , NOW()
	FROM stg.stg_wms_putaway_exec_dtl s
    LEFT JOIN 	dwh.f_putawayplandetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_pln_no 	= fh.pway_pln_no 
			AND s.wms_pway_pln_ou 	= fh.pway_pln_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 		= l.loc_code 
        AND s.wms_pway_pln_ou        	= l.loc_ou
	LEFT JOIN dwh.d_equipment d 			
		ON  s.wms_pway_mhe_id 	        = d.eqp_equipment_id
        AND s.wms_pway_pln_ou        	= d.eqp_ou
	LEFT JOIN dwh.d_stage g 		
		ON  s.wms_pway_stag_id  		= g.stg_mas_id 
        AND s.wms_pway_pln_ou        	= g.stg_mas_ou
		AND s.wms_pway_loc_code			= g.stg_mas_loc
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_pway_employee_id  	= e.emp_employee_code 
        AND s.wms_pway_pln_ou        	= e.emp_ou		
	LEFT JOIN dwh.f_putawayexecdetail t  	
		ON  t.pway_loc_code 			= s.wms_pway_loc_code
		AND	t.pway_exec_no 			= s.wms_pway_exec_no
		AND	t.pway_exec_ou 			= s.wms_pway_exec_ou
    WHERE t.pway_exec_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_putaway_exec_dtl
	(
		wms_pway_loc_code, 				wms_pway_exec_no, 				wms_pway_exec_ou, 				wms_pway_pln_no, 				wms_pway_pln_ou, 
		wms_pway_exec_status, 			wms_pway_stag_id, 				wms_pway_mhe_id, 				wms_pway_employee_id, 			wms_pway_exec_start_date, 
		wms_pway_exec_end_date, 		wms_pway_completed, 			wms_pway_created_by, 			wms_pway_created_date, 			wms_pway_modified_by, 
		wms_pway_modified_date, 		wms_pway_timestamp, 			wms_pway_userdefined1, 			wms_pway_userdefined2, 			wms_pway_userdefined3, 
		wms_pway_billing_status, 		wms_pway_bill_value, 			wms_pway_hdlpway_bil_status, 	wms_pway_lbchprhr_bil_status, 	wms_pway_pwaytchr_bil_status, 
		wms_pway_hdlchcar_bil_status, 	wms_pway_type, 					wms_pway_by_flag, 				wms_pway_gen_from, 				etlcreateddatetime	
	
	)
	SELECT 
		wms_pway_loc_code, 		        wms_pway_exec_no, 				wms_pway_exec_ou, 				wms_pway_pln_no, 				wms_pway_pln_ou, 
		wms_pway_exec_status, 			wms_pway_stag_id, 				wms_pway_mhe_id, 				wms_pway_employee_id, 			wms_pway_exec_start_date, 
		wms_pway_exec_end_date, 		wms_pway_completed, 			wms_pway_created_by, 			wms_pway_created_date, 			wms_pway_modified_by, 
		wms_pway_modified_date, 		wms_pway_timestamp, 			wms_pway_userdefined1, 			wms_pway_userdefined2, 			wms_pway_userdefined3, 
		wms_pway_billing_status, 		wms_pway_bill_value, 			wms_pway_hdlpway_bil_status, 	wms_pway_lbchprhr_bil_status, 	wms_pway_pwaytchr_bil_status, 
		wms_pway_hdlchcar_bil_status, 	wms_pway_type, 					wms_pway_by_flag, 				wms_pway_gen_from, 				etlcreateddatetime
	FROM stg.stg_wms_putaway_exec_dtl;
    END IF;	
    
	ELSE	
		 p_errorid   := 0;
		 select 0 into inscnt;
       	 select 0 into updcnt;
		 select 0 into srccnt;	
		 
		 IF p_depsource IS NULL
		 THEN 
		 p_errordesc := 'The Dependent source cannot be NULL.';
		 ELSE
		 p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
		 END IF;
		 CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
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
ALTER PROCEDURE dwh.usp_f_putawayexecdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
