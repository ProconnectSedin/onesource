-- PROCEDURE: dwh.usp_f_dailyattendance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dailyattendance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dailyattendance(
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

		SELECT COUNT(1) INTO srccnt FROM stg.stg_dailyattendance;

		UPDATE dwh.f_dailyattendance t
		SET 
			loc_key = COALESCE(l.loc_key,-1), 
			date_key = COALESCE(d.datekey,-1), 
			emp_key = COALESCE(e.emp_hdr_key,-1), 
			ou = s.ou, 
			attendance_date = s.attendance_date, 
			location_code = s.location_code, 
			location_name = s.location_name, 
			employee_code = s.employee_code, 
			employee_name = s.employee_name, 
			dpeartment_name = s.dpeartment_name, 
			job_title = s.job_title, 
			category_name = s.category_name, 
			shift_start_time = s.shift_start_time, 
			shift_end_time = s.shift_end_time, 
			punch_in_time = s.punch_in_time, 
			punch_out_time = s.punch_out_time, 
			break_out_time = s.break_out_time, 
			break_in_time = s.break_in_time, 
			came_late_by = s.came_late_by, 
			left_early_by = s.left_early_by, 
			break_out_early_by = s.break_out_early_by, 
			break_in_late_by = s.break_in_late_by, 
			attendance_status = s.attendance_status, 
			work_hours = s.work_hours, 
			work_location_name = s.work_location_name, 
			last_updated_ts = s.last_updated_ts, 
			shift_name = s.shift_name, 
			normal_ot = s.normal_ot, 
			night_ot = s.night_ot, 
			weekoff_ot = s.weekoff_ot, 
			holiday_ot = s.holiday_ot, 
			approved_ot = s.approved_ot, 
			custom_menu = s.custom_menu, 
			account_no = s.account_no, 
			inserted_ts = s.inserted_ts, 
			dept_code = s.dept_code, 
			job_code = s.job_code, 
			job_eeo_class = s.job_eeo_class, 
			job_grade_set_code = s.job_grade_set_code, 
			job_grade_code = s.job_grade_code, 
			budgeted_count = s.budgeted_count, 
			budgeted_ctc = s.budgeted_ctc, 
			rqd_count_day = s.rqd_count_day, 
			shift_1 = s.shift_1, 
			shift_2 = s.shift_2, 
			shift_3 = s.shift_3, 
			general = s.general, 
			createdatetime = s.createdatetime, 
			etlactiveind = 1, 
			etljobname = p_etljobname, 
			envsourcecd = p_envsourcecd, 
			datasourcecd = p_datasourcecd, 
			etlupdatedatetime = NOW()

		FROM stg.stg_dailyattendance s
		LEFT JOIN dwh.d_location L 		
			ON s.location_code 			= L.loc_code 
			AND s.ou        		= L.loc_ou
		LEFT JOIN dwh.d_date D 			
			ON  s.attendance_date::date 	= D.dateactual
		LEFT JOIN dwh.d_employeeheader e		
			ON  s.employee_code  		= e.emp_employee_code 
        AND s.ou        	= e.emp_ou	
		
		WHERE 		t.ou = s.ou
			AND 	t.attendance_date 	= s.attendance_date
			AND		t.employee_code 	= s.employee_code;
		
		GET DIAGNOSTICS updcnt = ROW_COUNT;

		INSERT INTO dwh.f_dailyattendance
		(
			loc_key,			date_key,			emp_key,		ou,				attendance_date,		location_code,			location_name,		employee_code,
			employee_name,		dpeartment_name,	job_title,		category_name,	shift_start_time,		shift_end_time,			punch_in_time,		punch_out_time,	
			break_out_time,		break_in_time,		came_late_by,	left_early_by,	break_out_early_by,		break_in_late_by,		attendance_status,	work_hours,	
			work_location_name,	last_updated_ts,	shift_name,		normal_ot,		night_ot,				weekoff_ot,				holiday_ot,			approved_ot,
			custom_menu,		account_no,			inserted_ts,	dept_code,		job_code,				job_eeo_class,			job_grade_set_code,	job_grade_code,
			budgeted_count,		budgeted_ctc,		rqd_count_day,	shift_1,		shift_2,				shift_3,				general,			createdatetime,	
			etlactiveind,		etljobname,			envsourcecd,	datasourcecd,	etlupdatedatetime	)
		
		SELECT 
			COALESCE(l.loc_key,	-1),	COALESCE(d.datekey,	-1),	COALESCE(e.emp_hdr_key,	-1),	s.ou,					s.attendance_date,	s.location_code,	s.location_name,
			s.employee_code,			s.employee_name,			s.dpeartment_name,				s.job_title,			s.category_name,	s.shift_start_time,	s.shift_end_time,
			s.punch_in_time,			s.punch_out_time,			s.break_out_time,				s.break_in_time,		s.came_late_by,		s.left_early_by,	s.break_out_early_by,
			s.break_in_late_by,			s.attendance_status,		s.work_hours,					s.work_location_name,	s.last_updated_ts,	s.shift_name,		s.normal_ot,				s.night_ot,	s.weekoff_ot,	s.holiday_ot,	s.approved_ot,	s.custom_menu,	s.account_no,	s.inserted_ts,	s.dept_code,	
			s.job_code,	s.job_eeo_class,	s.job_grade_set_code,	s.job_grade_code,	s.budgeted_count,	s.budgeted_ctc,	s.rqd_count_day,
			s.shift_1,	s.shift_2,	s.shift_3,	s.general,	s.createdatetime,	1,	p_etljobname,	p_envsourcecd,	p_datasourcecd,	NOW()
		FROM stg.stg_dailyattendance s

	LEFT JOIN dwh.d_location L 		
			ON s.location_code 		= L.loc_code 
			AND s.ou        		= L.loc_ou
		LEFT JOIN dwh.d_date D 			
			ON  s.attendance_date::date 	= D.dateactual
		LEFT JOIN dwh.d_employeeheader e		
			ON  s.employee_code  	= e.emp_employee_code 
       		 AND s.ou        		= e.emp_ou	
		
		LEFT JOIN dwh.f_dailyattendance fd  	
			ON  s.ou = fd.ou
			AND s.attendance_date 				= fd.attendance_date 
			AND s.employee_code 				= fd.employee_code
		WHERE fd.employee_code IS NULL;
		
		GET DIAGNOSTICS inscnt = ROW_COUNT;
	
    IF p_rawstorageflag = 1
    THEN
		
		INSERT INTO raw.raw_dailyattendance
		(
			ou,	 			attendance_date,	location_code,		location_name,		employee_code,	employee_name,		dpeartment_name,	job_title,	
			category_name,	shift_start_time,	shift_end_time,		punch_in_time,		punch_out_time,	break_out_time,		break_in_time,		came_late_by,	
			left_early_by,	break_out_early_by,	break_in_late_by,	attendance_status,	work_hours,		work_location_name,	last_updated_ts,	shift_name,	
			normal_ot,		night_ot,			weekoff_ot,			holiday_ot,			approved_ot,	custom_menu,		account_no,			inserted_ts,	
			dept_code,		job_code,			job_eeo_class,		job_grade_set_code,	job_grade_code,	budgeted_count,		budgeted_ctc,		rqd_count_day,
			shift_1,		shift_2,			shift_3,			general,			createdatetime
		
		)
		SELECT 
				ou,	 			attendance_date,	location_code,		location_name,		employee_code,	employee_name,		dpeartment_name,	job_title,	
			category_name,	shift_start_time,	shift_end_time,		punch_in_time,		punch_out_time,	break_out_time,		break_in_time,		came_late_by,	
			left_early_by,	break_out_early_by,	break_in_late_by,	attendance_status,	work_hours,		work_location_name,	last_updated_ts,	shift_name,	
			normal_ot,		night_ot,			weekoff_ot,			holiday_ot,			approved_ot,	custom_menu,		account_no,			inserted_ts,	
			dept_code,		job_code,			job_eeo_class,		job_grade_set_code,	job_grade_code,	budgeted_count,		budgeted_ctc,		rqd_count_day,
			shift_1,		shift_2,			shift_3,			general,			createdatetime
		
		FROM stg.stg_dailyattendance;

    END IF;
		
	EXCEPTION WHEN others THEN       
		   
	GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
			
	CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
			
	SELECT 0 INTO inscnt;
	SELECT 0 INTO updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_dailyattendance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
