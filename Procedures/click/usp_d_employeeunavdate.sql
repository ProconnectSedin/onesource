CREATE PROCEDURE click.usp_d_employeeunavdate()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeeunavdate t
    SET
        emp_udate_key = s.emp_udate_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_lineno = s.emp_lineno,
        emp_from_date = s.emp_from_date,
        emp_to_date = s.emp_to_date,
        emp_reason_code = s.emp_reason_code,
        emp_all_shift = s.emp_all_shift,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeeunavdate s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno;

    INSERT INTO click.d_employeeunavdate(emp_udate_key, emp_employee_code, emp_ou, emp_lineno, emp_from_date, emp_to_date, emp_reason_code, emp_all_shift, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_udate_key, s.emp_employee_code, s.emp_ou, s.emp_lineno, s.emp_from_date, s.emp_to_date, s.emp_reason_code, s.emp_all_shift, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeeunavdate s
    LEFT JOIN click.d_employeeunavdate t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno
    WHERE t.emp_employee_code IS NULL;
END;
$$;