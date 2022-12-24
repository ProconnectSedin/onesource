CREATE OR REPLACE PROCEDURE click.usp_d_employeeheader()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeeheader t
    SET
        emp_hdr_key = s.emp_hdr_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_description = s.emp_description,
        emp_status = s.emp_status,
        emp_reason_code = s.emp_reason_code,
        emp_first_name = s.emp_first_name,
        emp_last_name = s.emp_last_name,
        emp_middle_name = s.emp_middle_name,
        emp_ssn_id_no = s.emp_ssn_id_no,
        emp_gender = s.emp_gender,
        emp_owner_type = s.emp_owner_type,
        emp_nationality = s.emp_nationality,
        emp_agency_id = s.emp_agency_id,
        emp_religion = s.emp_religion,
        emp_agency_contact_num = s.emp_agency_contact_num,
        emp_dob = s.emp_dob,
        emp_date_of_confirmation = s.emp_date_of_confirmation,
        emp_user = s.emp_user,
        emp_department = s.emp_department,
        emp_designation = s.emp_designation,
        emp_date_of_joining = s.emp_date_of_joining,
        emp_blood_group = s.emp_blood_group,
        emp_cost_center = s.emp_cost_center,
        emp_address_line1 = s.emp_address_line1,
        emp_address_line2 = s.emp_address_line2,
        emp_address_line3 = s.emp_address_line3,
        emp_city = s.emp_city,
        emp_state = s.emp_state,
        emp_country = s.emp_country,
        emp_postal_code = s.emp_postal_code,
        emp_primary_phone = s.emp_primary_phone,
        emp_secondary_phone = s.emp_secondary_phone,
        emp_email = s.emp_email,
        emp_emergency_contact_pers = s.emp_emergency_contact_pers,
        emp_emergency_relationship = s.emp_emergency_relationship,
        emp_phone = s.emp_phone,
        emp_default_location = s.emp_default_location,
        emp_current_location = s.emp_current_location,
        emp_current_location_since = s.emp_current_location_since,
        emp_shift_pref = s.emp_shift_pref,
        emp_grade = s.emp_grade,
        emp_created_by = s.emp_created_by,
        emp_created_date = s.emp_created_date,
        emp_modified_by = s.emp_modified_by,
        emp_modified_date = s.emp_modified_date,
        emp_timestamp = s.emp_timestamp,
        emp_given_name = s.emp_given_name,
        emp_gen_info_grade = s.emp_gen_info_grade,
        emp_employment = s.emp_employment,
        emp_rate_tariffid = s.emp_rate_tariffid,
        emp_intransit = s.emp_intransit,
        emp_route = s.emp_route,
        emp_and = s.emp_and,
        emp_between = s.emp_between,
        emp_rate_tariffcontid = s.emp_rate_tariffcontid,
        emp_raise_int_drfbill = s.emp_raise_int_drfbill,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeeheader s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou;

    INSERT INTO click.d_employeeheader(emp_hdr_key, emp_employee_code, emp_ou, emp_description, emp_status, emp_reason_code, emp_first_name, emp_last_name, emp_middle_name, emp_ssn_id_no, emp_gender, emp_owner_type, emp_nationality, emp_agency_id, emp_religion, emp_agency_contact_num, emp_dob, emp_date_of_confirmation, emp_user, emp_department, emp_designation, emp_date_of_joining, emp_blood_group, emp_cost_center, emp_address_line1, emp_address_line2, emp_address_line3, emp_city, emp_state, emp_country, emp_postal_code, emp_primary_phone, emp_secondary_phone, emp_email, emp_emergency_contact_pers, emp_emergency_relationship, emp_phone, emp_default_location, emp_current_location, emp_current_location_since, emp_shift_pref, emp_grade, emp_created_by, emp_created_date, emp_modified_by, emp_modified_date, emp_timestamp, emp_given_name, emp_gen_info_grade, emp_employment, emp_rate_tariffid, emp_intransit, emp_route, emp_and, emp_between, emp_rate_tariffcontid, emp_raise_int_drfbill, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_hdr_key, s.emp_employee_code, s.emp_ou, s.emp_description, s.emp_status, s.emp_reason_code, s.emp_first_name, s.emp_last_name, s.emp_middle_name, s.emp_ssn_id_no, s.emp_gender, s.emp_owner_type, s.emp_nationality, s.emp_agency_id, s.emp_religion, s.emp_agency_contact_num, s.emp_dob, s.emp_date_of_confirmation, s.emp_user, s.emp_department, s.emp_designation, s.emp_date_of_joining, s.emp_blood_group, s.emp_cost_center, s.emp_address_line1, s.emp_address_line2, s.emp_address_line3, s.emp_city, s.emp_state, s.emp_country, s.emp_postal_code, s.emp_primary_phone, s.emp_secondary_phone, s.emp_email, s.emp_emergency_contact_pers, s.emp_emergency_relationship, s.emp_phone, s.emp_default_location, s.emp_current_location, s.emp_current_location_since, s.emp_shift_pref, s.emp_grade, s.emp_created_by, s.emp_created_date, s.emp_modified_by, s.emp_modified_date, s.emp_timestamp, s.emp_given_name, s.emp_gen_info_grade, s.emp_employment, s.emp_rate_tariffid, s.emp_intransit, s.emp_route, s.emp_and, s.emp_between, s.emp_rate_tariffcontid, s.emp_raise_int_drfbill, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeeheader s
    LEFT JOIN click.d_employeeheader t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    WHERE t.emp_employee_code IS NULL;
END;
$$;