CREATE PROCEDURE click.usp_d_employeetype()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeetype t
    SET
        emp_employee_key = s.emp_employee_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_lineno = s.emp_lineno,
        emp_type = s.emp_type,
        emp_priority = s.emp_priority,
        emp_mapped = s.emp_mapped,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeetype s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno;

    INSERT INTO click.d_employeetype(emp_employee_key, emp_employee_code, emp_ou, emp_lineno, emp_type, emp_priority, emp_mapped, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_employee_key, s.emp_employee_code, s.emp_ou, s.emp_lineno, s.emp_type, s.emp_priority, s.emp_mapped, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeetype s
    LEFT JOIN click.d_employeetype t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno
    WHERE t.emp_employee_code IS NULL;
END;
$$;