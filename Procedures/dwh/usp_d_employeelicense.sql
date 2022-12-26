CREATE OR REPLACE PROCEDURE dwh.usp_d_employeelicense(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_employee_license_dtl;

	UPDATE dwh.d_employeelicense t
    SET 
			emp_license_type			=	s.wms_emp_license_type,			
			emp_license_num				=	s.wms_emp_license_num,
			emp_description				=	s.wms_emp_description,
			emp_issued_date				=	s.wms_emp_issued_date,
			emp_valid_from				=	s.wms_emp_valid_from,
			emp_valid_till				=	s.wms_emp_valid_till,
			emp_issuing_authority		=	s.wms_emp_issuing_authority,
			etlactiveind 				=	1,
			etljobname 					=	p_etljobname,
			envsourcecd 				=	p_envsourcecd,
			datasourcecd 				=	p_datasourcecd,
			etlupdatedatetime 			=	NOW()
    FROM    stg.stg_wms_employee_license_dtl s
    WHERE	t.emp_employee_code			=	s.wms_emp_employee_code
	AND		t.emp_ou 					=	s.wms_emp_ou
	AND     t.emp_lineno				=   s.wms_emp_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_employeelicense
	(
		emp_employee_code				,emp_ou							,emp_lineno						,emp_license_type
		,emp_license_num				,emp_description				,emp_issued_date				,emp_valid_from
		,emp_valid_till					,emp_issuing_authority
		,etlactiveind					,etljobname						,envsourcecd					,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		wms_emp_employee_code				,wms_emp_ou								,wms_emp_lineno						,wms_emp_license_type
		,wms_emp_license_num				,wms_emp_description					,wms_emp_issued_date				,wms_emp_valid_from
		,wms_emp_valid_till					,wms_emp_issuing_authority
		,1									,p_etljobname							,p_envsourcecd						,p_datasourcecd			,NOW()
	FROM stg.stg_wms_employee_license_dtl s
    LEFT JOIN dwh.d_employeelicense t
    ON 	s.wms_emp_employee_code  		= t.emp_employee_code
	AND s.wms_emp_ou 					= t.emp_ou
	AND s.wms_emp_lineno				= t.emp_lineno
    WHERE t.emp_employee_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_employee_license_dtl
	(
		wms_emp_employee_code				,wms_emp_ou								,wms_emp_lineno						,wms_emp_license_type
		,wms_emp_license_num				,wms_emp_description					,wms_emp_issued_date				,wms_emp_valid_from
		,wms_emp_valid_till					,wms_emp_issuing_authority
		,etlcreateddatetime
	)
	SELECT 
		wms_emp_employee_code				,wms_emp_ou								,wms_emp_lineno						,wms_emp_license_type
		,wms_emp_license_num				,wms_emp_description					,wms_emp_issued_date				,wms_emp_valid_from
		,wms_emp_valid_till					,wms_emp_issuing_authority
		,etlcreateddatetime
	FROM stg.stg_wms_employee_license_dtl;
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