CREATE PROCEDURE click.usp_d_custprospectinfo()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_custprospectinfo t
    SET
        cpr_key = s.cpr_key,
        cpr_lo = s.cpr_lo,
        cpr_prosp_cust_code = s.cpr_prosp_cust_code,
        cpr_prosp_cust_name = s.cpr_prosp_cust_name,
        cpr_prosp_custname_shd = s.cpr_prosp_custname_shd,
        cpr_registration_dt = s.cpr_registration_dt,
        cpr_created_at = s.cpr_created_at,
        cpr_number_type = s.cpr_number_type,
        cpr_created_transaction = s.cpr_created_transaction,
        cpr_addrline1 = s.cpr_addrline1,
        cpr_addrline2 = s.cpr_addrline2,
        cpr_addrline3 = s.cpr_addrline3,
        cpr_city = s.cpr_city,
        cpr_state = s.cpr_state,
        cpr_country = s.cpr_country,
        cpr_zip = s.cpr_zip,
        cpr_phone1 = s.cpr_phone1,
        cpr_mobile = s.cpr_mobile,
        cpr_fax = s.cpr_fax,
        cpr_email = s.cpr_email,
        cpr_status = s.cpr_status,
        cpr_created_by = s.cpr_created_by,
        cpr_created_date = s.cpr_created_date,
        cpr_modified_by = s.cpr_modified_by,
        cpr_modified_date = s.cpr_modified_date,
        cpr_timestamp_value = s.cpr_timestamp_value,
        cpr_cont_person = s.cpr_cont_person,
        cpr_prosp_long_desc = s.cpr_prosp_long_desc,
        cpr_industry = s.cpr_industry,
        cpr_priority = s.cpr_priority,
        cpr_region = s.cpr_region,
        cpr_prosp_contact_name = s.cpr_prosp_contact_name,
        cpr_registration_no = s.cpr_registration_no,
        cpr_registration_type = s.cpr_registration_type,
        cpr_address_id = s.cpr_address_id,
        cpr_crm_flag = s.cpr_crm_flag,
        cpr_segment = s.cpr_segment,
        cpr_sp_code = s.cpr_sp_code,
        cpr_cust_loyalty = s.cpr_cust_loyalty,
        cpr_pannumber = s.cpr_pannumber,
        cpr_job_title = s.cpr_job_title,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_custprospectinfo s
    WHERE t.cpr_lo = s.cpr_lo
    AND t.cpr_prosp_cust_code = s.cpr_prosp_cust_code;

    INSERT INTO click.d_custprospectinfo(cpr_key, cpr_lo, cpr_prosp_cust_code, cpr_prosp_cust_name, cpr_prosp_custname_shd, cpr_registration_dt, cpr_created_at, cpr_number_type, cpr_created_transaction, cpr_addrline1, cpr_addrline2, cpr_addrline3, cpr_city, cpr_state, cpr_country, cpr_zip, cpr_phone1, cpr_mobile, cpr_fax, cpr_email, cpr_status, cpr_created_by, cpr_created_date, cpr_modified_by, cpr_modified_date, cpr_timestamp_value, cpr_cont_person, cpr_prosp_long_desc, cpr_industry, cpr_priority, cpr_region, cpr_prosp_contact_name, cpr_registration_no, cpr_registration_type, cpr_address_id, cpr_crm_flag, cpr_segment, cpr_sp_code, cpr_cust_loyalty, cpr_pannumber, cpr_job_title, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.cpr_key, s.cpr_lo, s.cpr_prosp_cust_code, s.cpr_prosp_cust_name, s.cpr_prosp_custname_shd, s.cpr_registration_dt, s.cpr_created_at, s.cpr_number_type, s.cpr_created_transaction, s.cpr_addrline1, s.cpr_addrline2, s.cpr_addrline3, s.cpr_city, s.cpr_state, s.cpr_country, s.cpr_zip, s.cpr_phone1, s.cpr_mobile, s.cpr_fax, s.cpr_email, s.cpr_status, s.cpr_created_by, s.cpr_created_date, s.cpr_modified_by, s.cpr_modified_date, s.cpr_timestamp_value, s.cpr_cont_person, s.cpr_prosp_long_desc, s.cpr_industry, s.cpr_priority, s.cpr_region, s.cpr_prosp_contact_name, s.cpr_registration_no, s.cpr_registration_type, s.cpr_address_id, s.cpr_crm_flag, s.cpr_segment, s.cpr_sp_code, s.cpr_cust_loyalty, s.cpr_pannumber, s.cpr_job_title, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_custprospectinfo s
    LEFT JOIN click.d_custprospectinfo t
    ON t.cpr_lo = s.cpr_lo
    AND t.cpr_prosp_cust_code = s.cpr_prosp_cust_code
    WHERE t.cpr_lo IS NULL;
END;
$$;