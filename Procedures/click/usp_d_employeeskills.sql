CREATE PROCEDURE click.usp_d_employeeskills()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeeskills t
    SET
        emp_skill_key = s.emp_skill_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_lineno = s.emp_lineno,
        emp_skill_code = s.emp_skill_code,
        emp_primary_skill = s.emp_primary_skill,
        emp_certificate_no = s.emp_certificate_no,
        emp_certificate_type = s.emp_certificate_type,
        emp_issued_date = s.emp_issued_date,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeeskills s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno;

    INSERT INTO click.d_employeeskills(emp_skill_key, emp_employee_code, emp_ou, emp_lineno, emp_skill_code, emp_primary_skill, emp_certificate_no, emp_certificate_type, emp_issued_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_skill_key, s.emp_employee_code, s.emp_ou, s.emp_lineno, s.emp_skill_code, s.emp_primary_skill, s.emp_certificate_no, s.emp_certificate_type, s.emp_issued_date, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeeskills s
    LEFT JOIN click.d_employeeskills t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno
    WHERE t.emp_employee_code IS NULL;
END;
$$;