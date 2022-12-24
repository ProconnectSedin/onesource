CREATE OR REPLACE PROCEDURE click.usp_d_employeelicense()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeelicense t
    SET
        emp_key = s.emp_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_lineno = s.emp_lineno,
        emp_license_type = s.emp_license_type,
        emp_license_num = s.emp_license_num,
        emp_description = s.emp_description,
        emp_issued_date = s.emp_issued_date,
        emp_valid_from = s.emp_valid_from,
        emp_valid_till = s.emp_valid_till,
        emp_issuing_authority = s.emp_issuing_authority,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeelicense s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno;

    INSERT INTO click.d_employeelicense(emp_key, emp_employee_code, emp_ou, emp_lineno, emp_license_type, emp_license_num, emp_description, emp_issued_date, emp_valid_from, emp_valid_till, emp_issuing_authority, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_key, s.emp_employee_code, s.emp_ou, s.emp_lineno, s.emp_license_type, s.emp_license_num, s.emp_description, s.emp_issued_date, s.emp_valid_from, s.emp_valid_till, s.emp_issuing_authority, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeelicense s
    LEFT JOIN click.d_employeelicense t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno
    WHERE t.emp_employee_code IS NULL;
END;
$$;