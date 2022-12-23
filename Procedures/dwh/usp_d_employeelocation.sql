CREATE PROCEDURE dwh.usp_d_employeelocation(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_employee_location_dtl;

	UPDATE dwh.D_EmployeeLocation t
    SET 
		 emp_geo_type 			= s.wms_emp_geo_type
		,emp_division_location 	= s.wms_emp_division_location
		,etlactiveind 			= 1
		,etljobname 			= p_etljobname
		,envsourcecd 			= p_envsourcecd 
		,datasourcecd 			= p_datasourcecd
		,etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_employee_location_dtl s
    WHERE t.emp_employee_code 	= s.wms_emp_employee_code
	AND	t.emp_ou 				= s.wms_emp_ou
	AND t.emp_lineno			= s.wms_emp_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_EmployeeLocation
	(
		emp_employee_code,			emp_ou			,emp_lineno,		emp_geo_type		,emp_division_location,
		etlactiveind,				etljobname		,envsourcecd		,datasourcecd,
		etlcreatedatetime
	)
	
    SELECT 
		s.wms_emp_employee_code,	s.wms_emp_ou	,s.wms_emp_lineno,	s.wms_emp_geo_type	,s.wms_emp_division_location,		
		1,							p_etljobname	,p_envsourcecd		,p_datasourcecd,
		NOW()
	FROM stg.stg_wms_employee_location_dtl s
    LEFT JOIN dwh.D_EmployeeLocation t
    ON 	s.wms_emp_employee_code = t.emp_employee_code
	AND s.wms_emp_ou 			= t.emp_ou
	AND s.wms_emp_lineno 		= t.emp_lineno
    WHERE t.emp_employee_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
 
	
	INSERT INTO raw.raw_wms_employee_location_dtl
	(
		wms_emp_employee_code,wms_emp_ou,wms_emp_lineno,wms_emp_geo_type,wms_emp_division_location, etlcreateddatetime	
	)
	SELECT 
		wms_emp_employee_code,wms_emp_ou,wms_emp_lineno,wms_emp_geo_type,wms_emp_division_location, etlcreateddatetime
	FROM stg.stg_wms_employee_location_dtl;
	END IF;
	
	EXCEPTION WHEN others THEN       
       
    get stacked diagnostics p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,null);
    
        
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt; 
END;
$$;