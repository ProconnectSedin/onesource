-- PROCEDURE: dwh.usp_f_attrition(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_attrition(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_attrition(
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

		SELECT COUNT(1) INTO srccnt FROM stg.stg_factattrition;
/*
		UPDATE dwh.f_attrition t
		SET 
			loc_key 			= COALESCE(l.loc_key,-1), 
			emp_key 			= COALESCE(e.emp_hdr_key,-1),
			supp_key 			= COALESCE(v.vendor_key,-1),
			wh_key	 			= COALESCE(w.wh_key,-1),
			ou 					= s.ou,
			attendance_month 	= s.attendance_month,
			vendor_code 		= s.vendor_code,
			location_code 		= s.location_code,
			employee_type2 		= s.employee_type2,
			vendor_name 		= s.vendor_name,
			warehouse_code 		= s.warehouse_code,
			warehouse_name 		= s.warehouse_name,
			employee_code 		= s.employee_code,
			job_code 			= s.job_code,
			job_title 			= s.job_title,
			emp_count 			= s.emp_count,
			addition 			= s.addition,
			seperation 			= s.seperation,
			inserted_ts 		= s.inserted_ts,
			createddatetime 	= s.createddatetime,
			etlactiveind 		= 1, 
			etljobname 			= p_etljobname, 
			envsourcecd 		= p_envsourcecd, 
			datasourcecd 		= p_datasourcecd, 
			etlupdatedatetime 	= NOW()
			
		FROM stg.stg_factattrition s
		LEFT JOIN dwh.d_location L 		
			ON s.location_code 			= L.loc_code 
			AND s.ou        		= L.loc_ou
		LEFT JOIN dwh.d_employeeheader e		
			ON  s.employee_code  		= e.emp_employee_code 
        	AND s.ou        	= e.emp_ou	
        LEFT JOIN dwh.d_warehouse w 		
			ON  s.warehouse_code 				= w.wh_code 
			AND s.ou				= w.wh_ou 
		LEFT JOIN dwh.d_vendor V 		
			ON s.vendor_code  = V.vendor_id 
        	AND s.ou        = V.vendor_ou
		WHERE 	t.ou 			= s.ou
		AND t.attendance_month 	= s.attendance_month
		AND t.vendor_code 		= s.vendor_code
		AND t.location_code 	= s.location_code
		AND t.warehouse_code 	= s.warehouse_code
		AND t.employee_code 	= s.employee_code
		AND t.addition 			= s.addition
		AND t.seperation 		= s.seperation;
			
		
		GET DIAGNOSTICS updcnt = ROW_COUNT;
*/

		Truncate table dwh.f_attrition 
		restart identity;
	
		INSERT INTO dwh.f_attrition
		(
			loc_key			, emp_key			, supp_key			, wh_key			, ou		,
			attendance_month, vendor_code		, location_code		, employee_type2	, 	
			vendor_name		, warehouse_code	, warehouse_name	, employee_code		, job_code	, 	job_title, 	emp_count, 
			addition		, seperation		, inserted_ts		, createddatetime	,
			etlactiveind	, etljobname		, envsourcecd		, datasourcecd		, etlcreatedatetime	)
		
		SELECT
			COALESCE(l.loc_key,-1)	, COALESCE(e.emp_hdr_key,-1),COALESCE(v.vendor_key,-1),COALESCE(w.wh_key,-1), s.ou					,
			s.attendance_month		, s.vendor_code		, s.location_code,	s.employee_type2,
			s.vendor_name			, s.warehouse_code	, s.warehouse_name,	s.employee_code,s.job_code	,	s.job_title,	s.emp_count,
			s.addition				, s.seperation		, s.inserted_ts::date		,	s.createddatetime,
					1				, p_etljobname		, p_envsourcecd,	p_datasourcecd,	NOW()
		FROM stg.stg_factattrition s
		LEFT JOIN dwh.d_location L 		
		ON s.location_code 		= L.loc_code 
		AND s.ou        		= L.loc_ou
		LEFT JOIN dwh.d_employeeheader e		
		ON  s.employee_code  	= e.emp_employee_code 
        AND s.ou        		= e.emp_ou	
        LEFT JOIN dwh.d_warehouse w 		
		ON  s.warehouse_code 	= w.wh_code 
		AND s.ou				= w.wh_ou 
		LEFT JOIN dwh.d_vendor V 		
		ON s.vendor_code  = V.vendor_id 
        AND s.ou        = V.vendor_ou;
-- 		LEFT JOIN dwh.f_attrition fd  	
-- 		ON s.ou =fd.ou
-- 		AND s.attendance_month 	= fd.attendance_month
-- 		AND s.vendor_code 		= fd.vendor_code
-- 		AND s.location_code 	= fd.location_code
-- 		AND s.warehouse_code 	= fd.warehouse_code
-- 		AND s.employee_code 	= fd.employee_code
-- 		AND s.addition			= fd.addition
-- 		AND s.seperation		= fd.seperation
-- 		WHERE fd.employee_code IS NULL;

		GET DIAGNOSTICS inscnt = ROW_COUNT;
	
    IF p_rawstorageflag = 1
    THEN
		
		INSERT INTO raw.raw_factattrition
		(
			ou, 	attendance_month, 	vendor_code, 	location_code, 	employee_type2, 	
			vendor_name, 	warehouse_code, 	warehouse_name, 	employee_code, 	job_code, 	job_title, 	emp_count, 
				addition, 	seperation, 	inserted_ts, 	createddatetime
		
		)
		SELECT 
				ou, 	attendance_month, 	vendor_code, 	location_code, 	employee_type2, 	
			vendor_name, 	warehouse_code, 	warehouse_name, 	employee_code, 	job_code, 	job_title, 	emp_count, 
				addition, 	seperation, 	inserted_ts, 	createddatetime
		
		FROM stg.stg_factattrition;

    END IF;
		
	EXCEPTION WHEN others THEN       
		   
	GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
			
	CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
			
	SELECT 0 INTO inscnt;
	SELECT 0 INTO updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_attrition(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
