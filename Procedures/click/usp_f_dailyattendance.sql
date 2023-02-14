-- PROCEDURE: click.usp_f_dailyattendance()

-- DROP PROCEDURE IF EXISTS click.usp_f_dailyattendance();

CREATE OR REPLACE PROCEDURE click.usp_f_dailyattendance(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	TRUNCATE TABLE click.f_dailyattendance
	RESTART IDENTITY;

	INSERT INTO click.f_dailyattendance
	(
		dailyattendance_key	, loc_key				, date_key,
		emp_key				, ou					, attendance_date,
		location_code		, location_name			, employee_code,
		employee_name		, dpeartment_name		, job_title,
		category_name		, shift_start_time		, shift_end_time,
		punch_in_time		, punch_out_time		, break_out_time,
		break_in_time		, came_late_by			, left_early_by, 
		break_out_early_by	, break_in_late_by		, attendance_status, 
		work_hours			, work_location_name	, last_updated_ts,
		shift_name			, normal_ot				, night_ot,
		weekoff_ot			, holiday_ot			, approved_ot,
		custom_menu			, account_no			, inserted_ts,
		dept_code			, job_code				, job_eeo_class, 
		job_grade_set_code	, job_grade_code		, budgeted_count,
		budgeted_ctc		, rqd_count_day			, shift_1, 
		shift_2				, shift_3				, general, 
		createdatetime		, etlactiveind			, etljobname,
		envsourcecd			, datasourcecd			, etlcreatedatetime,
		etlupdatedatetime	, createddate
	)
	SELECT
		t.dailyattendance_key	, t.loc_key					, t.date_key,
		t.emp_key				, t.ou						, t.attendance_date,
		t.location_code			, t.location_name			, t.employee_code,
		t.employee_name			, t.dpeartment_name			, t.job_title,
		t.category_name			, t.shift_start_time		, t.shift_end_time,
		t.punch_in_time			, t.punch_out_time			, t.break_out_time,
		t.break_in_time			, t.came_late_by			, t.left_early_by, 
		t.break_out_early_by	, t.break_in_late_by		, t.attendance_status, 
		t.work_hours			, t.work_location_name		, t.last_updated_ts,
		t.shift_name			, t.normal_ot				, t.night_ot,
		t.weekoff_ot			, t.holiday_ot				, t.approved_ot,
		t.custom_menu			, t.account_no				, t.inserted_ts,
		t.dept_code				, t.job_code				, t.job_eeo_class, 
		t.job_grade_set_code	, t.job_grade_code			, t.budgeted_count,
		t.budgeted_ctc			, t.rqd_count_day			, t.shift_1, 
		t.shift_2				, t.shift_3					, t.general, 
		t.createdatetime		, t.etlactiveind			, t.etljobname,
		t.envsourcecd			, t.datasourcecd			, t.etlcreatedatetime,
		t.etlupdatedatetime		, NOW()
	from dwh.f_dailyattendance t;
/*	
	else
	
	update click.f_dailyattendance t
	set
		dailyattendance_key		= d.dailyattendance_key,
		loc_key					= d.loc_key,
		date_key				= d.date_key,
		emp_key					= d.emp_key,
		ou						= d.ou,
		attendance_date			= d.attendance_date,
		location_code			= d.location_code,
		location_name			= d.location_name,
		employee_code			= d.employee_code,
		employee_name			= d.employee_name,
		dpeartment_name			= d.dpeartment_name,
		job_title				= d.job_title,
		category_name			= d.category_name,
		shift_start_time		= d.shift_start_time,
		shift_end_time			= d.shift_end_time,
		punch_in_time			= d.punch_in_time,
		punch_out_time			= d.punch_out_time,
		break_out_time			= d.break_out_time,
		break_in_time			= d.break_in_time,
		came_late_by			= d.came_late_by,
		left_early_by			= d.left_early_by,
		break_out_early_by		= d.break_out_early_by,
		break_in_late_by		= d.break_in_late_by,
		attendance_status		= d.attendance_status,
		work_hours				= d.work_hours,
		work_location_name		= d.work_location_name,
		last_updated_ts			= d.last_updated_ts,
		shift_name				= d.shift_name,
		normal_ot				= d.normal_ot,
		night_ot				= d.night_ot,
		weekoff_ot				= d.weekoff_ot,
		holiday_ot				= d.holiday_ot,
		approved_ot				= d.approved_ot,
		custom_menu				= d.custom_menu,
		account_no				= d.account_no,
		inserted_ts				= d.inserted_ts,
		dept_code				= d.dept_code,
		job_code				= d.job_code,
		job_eeo_class			= d.job_eeo_class,
		job_grade_set_code		= d.job_grade_set_code,
		job_grade_code			= d.job_grade_code,
		budgeted_count			= d.budgeted_count,
		budgeted_ctc			= d.budgeted_ctc,
		rqd_count_day			= d.rqd_count_day,
		shift_1					= d.shift_1,
		shift_2					= d.shift_2,
		shift_3					= d.shift_3,
		general					= d.general,
		createdatetime			= d.createdatetime,
		etlactiveind			= d.etlactiveind,
		etljobname				= d.etljobname,
		envsourcecd				= d.envsourcecd,
		datasourcecd			= d.datasourcecd,
		etlcreatedatetime		= d.etlcreatedatetime,
		etlupdatedatetime		= d.etlupdatedatetime,
		updatedatetime			= d.updatedatetime,
	from dwh.f_dailyattendance d
	where t.dailyattendance_key		= d.dailyattendance_key
	and coalesce(d.etlupdatedatetime, d.etlcreatedatetime) >= 
	
	
	insert into click.f_dailyattendance
	(
		dailyattendance_key	, loc_key				, date_key,
		emp_key				, ou					, attendance_date,
		location_code		, location_name			, employee_code,
		employee_name		, dpeartment_name		, job_title,
		category_name		, shift_start_time		, shift_end_time,
		punch_in_time		, punch_out_time		, break_out_time,
		break_in_time		, came_late_by			, left_early_by, 
		break_out_early_by	, break_in_late_by		, attendance_status, 
		work_hours			, work_location_name	, last_updated_ts,
		shift_name			, normal_ot				, night_ot,
		weekoff_ot			, holiday_ot			, approved_ot,
		custom_menu			, account_no			, inserted_ts,
		dept_code			, job_code				, job_eeo_class, 
		job_grade_set_code	, job_grade_code		, budgeted_count,
		budgeted_ctc		, rqd_count_day			, shift_1, 
		shift_2				, shift_3				, general, 
		createdatetime		, etlactiveind			, etljobname,
		envsourcecd			, datasourcecd			, etlcreatedatetime,
		etlupdatedatetime	, createddate
	)
	SELECT
		t.dailyattendance_key	, t.loc_key					, t.date_key,
		t.emp_key				, t.ou						, t.attendance_date,
		t.location_code			, t.location_name			, t.employee_code,
		t.employee_name			, t.dpeartment_name			, t.job_title,
		t.category_name			, t.shift_start_time		, t.shift_end_time,
		t.punch_in_time			, t.punch_out_time			, t.break_out_time,
		t.break_in_time			, t.came_late_by			, t.left_early_by, 
		t.break_out_early_by	, t.break_in_late_by		, t.attendance_status, 
		t.work_hours			, t.work_location_name		, t.last_updated_ts,
		t.shift_name			, t.normal_ot				, t.night_ot,
		t.weekoff_ot			, t.holiday_ot				, t.approved_ot,
		t.custom_menu			, t.account_no				, t.inserted_ts,
		t.dept_code				, t.job_code				, t.job_eeo_class, 
		t.job_grade_set_code	, t.job_grade_code			, t.budgeted_count,
		t.budgeted_ctc			, t.rqd_count_day			, t.shift_1, 
		t.shift_2				, t.shift_3					, t.general, 
		t.createdatetime		, t.etlactiveind			, t.etljobname,
		t.envsourcecd			, t.datasourcecd			, t.etlcreatedatetime,
		t.etlupdatedatetime		, NOW()
	from dwh.f_dailyattendance t
	inner join click.f_dailyattendance d
	t.dailyattendance_key		= d.dailyattendance_key
	and coalesce(d.etlupdatedatetime, d.etlcreatedatetime) >= 
*/

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_dailyattendance','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_dailyattendance()
    OWNER TO proconnect;
