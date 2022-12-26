CREATE OR REPLACE PROCEDURE click.usp_d_customerlocationinfo()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerlocationinfo t
    SET
        clo_key = s.clo_key,
        clo_lo = s.clo_lo,
        clo_cust_code = s.clo_cust_code,
        clo_cust_name = s.clo_cust_name,
        clo_cust_name_shd = s.clo_cust_name_shd,
        clo_created_at = s.clo_created_at,
        clo_registration_dt = s.clo_registration_dt,
        clo_portal_user = s.clo_portal_user,
        clo_prosp_cust_code = s.clo_prosp_cust_code,
        clo_parent_cust_code = s.clo_parent_cust_code,
        clo_supp_code = s.clo_supp_code,
        clo_number_type = s.clo_number_type,
        clo_addrline1 = s.clo_addrline1,
        clo_addrline2 = s.clo_addrline2,
        clo_addrline3 = s.clo_addrline3,
        clo_city = s.clo_city,
        clo_state = s.clo_state,
        clo_country = s.clo_country,
        clo_zip = s.clo_zip,
        clo_phone1 = s.clo_phone1,
        clo_phone2 = s.clo_phone2,
        clo_mobile = s.clo_mobile,
        clo_fax = s.clo_fax,
        clo_email = s.clo_email,
        clo_url = s.clo_url,
        clo_cr_chk_at = s.clo_cr_chk_at,
        clo_nature_of_cust = s.clo_nature_of_cust,
        clo_internal_bu = s.clo_internal_bu,
        clo_internal_company = s.clo_internal_company,
        clo_account_group_code = s.clo_account_group_code,
        clo_created_by = s.clo_created_by,
        clo_created_date = s.clo_created_date,
        clo_modified_by = s.clo_modified_by,
        clo_modified_date = s.clo_modified_date,
        clo_timestamp_value = s.clo_timestamp_value,
        clo_cust_long_desc = s.clo_cust_long_desc,
        clo_noc = s.clo_noc,
        clo_template = s.clo_template,
        clo_pannumber = s.clo_pannumber,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerlocationinfo s
    WHERE t.clo_lo = s.clo_lo
    AND t.clo_cust_code = s.clo_cust_code;

    INSERT INTO click.d_customerlocationinfo(clo_key, clo_lo, clo_cust_code, clo_cust_name, clo_cust_name_shd, clo_created_at, clo_registration_dt, clo_portal_user, clo_prosp_cust_code, clo_parent_cust_code, clo_supp_code, clo_number_type, clo_addrline1, clo_addrline2, clo_addrline3, clo_city, clo_state, clo_country, clo_zip, clo_phone1, clo_phone2, clo_mobile, clo_fax, clo_email, clo_url, clo_cr_chk_at, clo_nature_of_cust, clo_internal_bu, clo_internal_company, clo_account_group_code, clo_created_by, clo_created_date, clo_modified_by, clo_modified_date, clo_timestamp_value, clo_cust_long_desc, clo_noc, clo_template, clo_pannumber, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.clo_key, s.clo_lo, s.clo_cust_code, s.clo_cust_name, s.clo_cust_name_shd, s.clo_created_at, s.clo_registration_dt, s.clo_portal_user, s.clo_prosp_cust_code, s.clo_parent_cust_code, s.clo_supp_code, s.clo_number_type, s.clo_addrline1, s.clo_addrline2, s.clo_addrline3, s.clo_city, s.clo_state, s.clo_country, s.clo_zip, s.clo_phone1, s.clo_phone2, s.clo_mobile, s.clo_fax, s.clo_email, s.clo_url, s.clo_cr_chk_at, s.clo_nature_of_cust, s.clo_internal_bu, s.clo_internal_company, s.clo_account_group_code, s.clo_created_by, s.clo_created_date, s.clo_modified_by, s.clo_modified_date, s.clo_timestamp_value, s.clo_cust_long_desc, s.clo_noc, s.clo_template, s.clo_pannumber, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerlocationinfo s
    LEFT JOIN click.d_customerlocationinfo t
    ON t.clo_lo = s.clo_lo
    AND t.clo_cust_code = s.clo_cust_code
    WHERE t.clo_lo IS NULL;
END;
$$;