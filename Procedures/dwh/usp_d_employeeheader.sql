CREATE PROCEDURE dwh.usp_d_employeeheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_employee_hdr;

	UPDATE dwh.d_employeeheader t
    SET 
		 emp_description			= s.wms_emp_description
		,emp_status					= s.wms_emp_status
		,emp_reason_code			= s.wms_emp_reason_code
		,emp_first_name				= s.wms_emp_first_name
		,emp_last_name				= s.wms_emp_last_name
		,emp_middle_name			= s.wms_emp_middle_name
		,emp_ssn_id_no				= s.wms_emp_ssn_id_no
		,emp_gender					= s.wms_emp_gender
		,emp_owner_type				= s.wms_emp_owner_type
		,emp_nationality			= s.wms_emp_nationality
		,emp_agency_id				= s.wms_emp_agency_id
		,emp_religion				= s.wms_emp_religion
		,emp_agency_contact_num		= s.wms_emp_agency_contact_num
		,emp_dob					= s.wms_emp_dob
		,emp_date_of_confirmation	= s.wms_emp_date_of_confirmation
		,emp_user					= s.wms_emp_user
		,emp_department				= s.wms_emp_department
		,emp_designation            = s.wms_emp_designation
		,emp_date_of_joining        = s.wms_emp_date_of_joining
		,emp_blood_group            = s.wms_emp_blood_group
		,emp_cost_center            = s.wms_emp_cost_center
		,emp_address_line1          = s.wms_emp_address_line1
		,emp_address_line2          = s.wms_emp_address_line2
		,emp_address_line3          = s.wms_emp_address_line3
		,emp_city                   = s.wms_emp_city
		,emp_state                  = s.wms_emp_state
		,emp_country                = s.wms_emp_country
		,emp_postal_code            = s.wms_emp_postal_code
		,emp_primary_phone          = s.wms_emp_primary_phone
		,emp_secondary_phone        = s.wms_emp_secondary_phone
		,emp_email                  = s.wms_emp_email
		,emp_emergency_contact_pers = s.wms_emp_emergency_contact_pers
		,emp_emergency_relationship = s.wms_emp_emergency_relationship
		,emp_phone                  = s.wms_emp_phone
		,emp_default_location       = s.wms_emp_default_location
		,emp_current_location       = s.wms_emp_current_location
		,emp_current_location_since = s.wms_emp_current_location_since
		,emp_shift_pref             = s.wms_emp_shift_pref
		,emp_grade                  = s.wms_emp_grade
		,emp_created_by             = s.wms_emp_created_by
		,emp_created_date           = s.wms_emp_created_date
		,emp_modified_by            = s.wms_emp_modified_by
		,emp_modified_date			= s.wms_emp_modified_date
		,emp_timestamp				= s.wms_emp_timestamp
		,emp_given_name				= s.wms_emp_given_name
		,emp_gen_info_grade			= s.wms_emp_gen_info_grade
		,emp_employment				= s.wms_emp_employment
		,emp_rate_tariffid			= s.wms_emp_rate_tariffid
		,emp_intransit				= s.wms_emp_intransit
		,emp_route					= s.wms_emp_route
		,emp_and					= s.wms_emp_and
		,emp_between				= s.wms_emp_between
		,emp_rate_tariffcontid		= s.wms_emp_rate_tariffcontid
		,emp_raise_int_drfbill		= s.wms_emp_raise_int_drfbill,
		etlactiveind 			    = 1,
		etljobname 				    = p_etljobname,
		envsourcecd 			    = p_envsourcecd ,
		datasourcecd 			    = p_datasourcecd ,
		etlupdatedatetime 		    = NOW()	
    FROM stg.stg_wms_employee_hdr s
    WHERE t.emp_employee_code  		= s.wms_emp_employee_code
	AND   t.emp_ou 			        = s.wms_emp_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_employeeheader
	(
		emp_employee_code,         emp_ou,                   emp_description,         emp_status,                emp_reason_code,
        emp_first_name,            emp_last_name,            emp_middle_name,         emp_ssn_id_no,             emp_gender,
        emp_owner_type,            emp_nationality,          emp_agency_id,           emp_religion,              emp_agency_contact_num,
        emp_dob,                   emp_date_of_confirmation, emp_user,                emp_department,            emp_designation,
        emp_date_of_joining,       emp_blood_group,          emp_cost_center,         emp_address_line1,         emp_address_line2,
        emp_address_line3,         emp_city,                 emp_state,               emp_country,               emp_postal_code,
        emp_primary_phone,         emp_secondary_phone,      emp_email,               emp_emergency_contact_pers,emp_emergency_relationship,
        emp_phone,                 emp_default_location,     emp_current_location,    emp_current_location_since,emp_shift_pref,
        emp_grade,                 emp_created_by,           emp_created_date,        emp_modified_by,           emp_modified_date,
        emp_timestamp,             emp_given_name,           emp_gen_info_grade,      emp_employment,            emp_rate_tariffid,
        emp_intransit,             emp_route,                emp_and,                 emp_between,               emp_rate_tariffcontid,
        emp_raise_int_drfbill,	   etlactiveind,             etljobname, 		      envsourcecd, 	             datasourcecd, 			
        etlcreatedatetime
	)
	
    SELECT 
		s.wms_emp_employee_code,         s.wms_emp_ou,                   s.wms_emp_description,         s.wms_emp_status,                s.wms_emp_reason_code,
        s.wms_emp_first_name,            s.wms_emp_last_name,            s.wms_emp_middle_name,         s.wms_emp_ssn_id_no,             s.wms_emp_gender,
        s.wms_emp_owner_type,            s.wms_emp_nationality,          s.wms_emp_agency_id,           s.wms_emp_religion,              s.wms_emp_agency_contact_num,
        s.wms_emp_dob,                   s.wms_emp_date_of_confirmation, s.wms_emp_user,                s.wms_emp_department,            s.wms_emp_designation,
        s.wms_emp_date_of_joining,       s.wms_emp_blood_group,          s.wms_emp_cost_center,         s.wms_emp_address_line1,         s.wms_emp_address_line2,
        s.wms_emp_address_line3,         s.wms_emp_city,                 s.wms_emp_state,               s.wms_emp_country,               s.wms_emp_postal_code,
        s.wms_emp_primary_phone,         s.wms_emp_secondary_phone,      s.wms_emp_email,               s.wms_emp_emergency_contact_pers,s.wms_emp_emergency_relationship,
        s.wms_emp_phone,                 s.wms_emp_default_location,     s.wms_emp_current_location,    s.wms_emp_current_location_since,s.wms_emp_shift_pref,
        s.wms_emp_grade,                 s.wms_emp_created_by,           s.wms_emp_created_date,        s.wms_emp_modified_by,           s.wms_emp_modified_date,
        s.wms_emp_timestamp,             s.wms_emp_given_name,           s.wms_emp_gen_info_grade,      s.wms_emp_employment,            s.wms_emp_rate_tariffid,
        s.wms_emp_intransit,             s.wms_emp_route,                s.wms_emp_and,                 s.wms_emp_between,               s.wms_emp_rate_tariffcontid,
        s.wms_emp_raise_int_drfbill,	 1,								p_etljobname, 		            p_envsourcecd, 	                 p_datasourcecd, 			
        now()
	FROM stg.stg_wms_employee_hdr s
    LEFT JOIN dwh.d_employeeheader t
    ON 	  t.emp_employee_code  		= s.wms_emp_employee_code
	AND   t.emp_ou 			        = s.wms_emp_ou
    WHERE t.emp_employee_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_employee_hdr
	(
         wms_emp_employee_code, wms_emp_ou, wms_emp_description, wms_emp_status, 
        wms_emp_reason_code, wms_emp_first_name, wms_emp_last_name, wms_emp_middle_name, 
        wms_emp_group, wms_emp_ssn_id_no, wms_emp_gender, wms_emp_owner_type, wms_emp_nationality,
        wms_emp_agency_id, wms_emp_religion, wms_emp_agency_contact_num, wms_emp_dob, wms_emp_effective_from, 
        wms_emp_effective_to, wms_emp_date_of_confirmation, wms_emp_user, wms_emp_department, 
        wms_emp_date_of_retirement, wms_emp_designation, wms_emp_date_of_joining, wms_emp_blood_group, 
        wms_emp_cost_center, wms_emp_height, wms_emp_height_uom, wms_emp_weight, wms_emp_weight_uom, 
        wms_emp_address_line1, wms_emp_address_line2, wms_emp_address_line3, wms_emp_unique_address_id,
        wms_emp_city, wms_emp_state, wms_emp_country, wms_emp_postal_code, wms_emp_primary_phone, 
        wms_emp_secondary_phone, wms_emp_email, wms_emp_fax, wms_emp_emergency_contact_pers, 
        wms_emp_emergency_relationship, wms_emp_phone, wms_emp_default_location, wms_emp_current_location, 
        wms_emp_current_location_since, wms_emp_continuous_drive_hrs, wms_emp_total_limit_day,
        wms_emp_total_limit_week, wms_emp_days_off_week, wms_emp_work_days_week, wms_emp_shift_pref, 
        wms_emp_from_time, wms_emp_to_time, wms_emp_grade, wms_emp_preferred_handler, wms_emp_created_by,
        wms_emp_created_date, wms_emp_modified_by, wms_emp_modified_date, wms_emp_timestamp, wms_emp_userdefined1,
        wms_emp_userdefined2, wms_emp_userdefined3, wms_emp_given_name, wms_emp_gen_info_grade, wms_emp_employment,
        wms_emp_rate_tariffid, wms_emp_intransit, wms_emp_route, wms_emp_and, wms_emp_between,
        wms_emp_rate_tariffcontid, wms_emp_raise_int_drfbill, wms_emp_rest_day, wms_emp_last_bil_date, 
        wms_emp_last_prev_bil_date, etlcreateddatetime
	
	)
	SELECT 
 wms_emp_employee_code, wms_emp_ou, wms_emp_description, wms_emp_status, 
        wms_emp_reason_code, wms_emp_first_name, wms_emp_last_name, wms_emp_middle_name, 
        wms_emp_group, wms_emp_ssn_id_no, wms_emp_gender, wms_emp_owner_type, wms_emp_nationality,
        wms_emp_agency_id, wms_emp_religion, wms_emp_agency_contact_num, wms_emp_dob, wms_emp_effective_from, 
        wms_emp_effective_to, wms_emp_date_of_confirmation, wms_emp_user, wms_emp_department, 
        wms_emp_date_of_retirement, wms_emp_designation, wms_emp_date_of_joining, wms_emp_blood_group, 
        wms_emp_cost_center, wms_emp_height, wms_emp_height_uom, wms_emp_weight, wms_emp_weight_uom, 
        wms_emp_address_line1, wms_emp_address_line2, wms_emp_address_line3, wms_emp_unique_address_id,
        wms_emp_city, wms_emp_state, wms_emp_country, wms_emp_postal_code, wms_emp_primary_phone, 
        wms_emp_secondary_phone, wms_emp_email, wms_emp_fax, wms_emp_emergency_contact_pers, 
        wms_emp_emergency_relationship, wms_emp_phone, wms_emp_default_location, wms_emp_current_location, 
        wms_emp_current_location_since, wms_emp_continuous_drive_hrs, wms_emp_total_limit_day,
        wms_emp_total_limit_week, wms_emp_days_off_week, wms_emp_work_days_week, wms_emp_shift_pref, 
        wms_emp_from_time, wms_emp_to_time, wms_emp_grade, wms_emp_preferred_handler, wms_emp_created_by,
        wms_emp_created_date, wms_emp_modified_by, wms_emp_modified_date, wms_emp_timestamp, wms_emp_userdefined1,
        wms_emp_userdefined2, wms_emp_userdefined3, wms_emp_given_name, wms_emp_gen_info_grade, wms_emp_employment,
        wms_emp_rate_tariffid, wms_emp_intransit, wms_emp_route, wms_emp_and, wms_emp_between,
        wms_emp_rate_tariffcontid, wms_emp_raise_int_drfbill, wms_emp_rest_day, wms_emp_last_bil_date, 
        wms_emp_last_prev_bil_date, etlcreateddatetime 		
	FROM stg.stg_wms_employee_hdr;
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