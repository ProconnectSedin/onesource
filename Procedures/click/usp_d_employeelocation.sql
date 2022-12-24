CREATE OR REPLACE PROCEDURE click.usp_d_employeelocation()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_employeelocation t
    SET
        emp_loc_key = s.emp_loc_key,
        emp_employee_code = s.emp_employee_code,
        emp_ou = s.emp_ou,
        emp_lineno = s.emp_lineno,
        emp_geo_type = s.emp_geo_type,
        emp_division_location = s.emp_division_location,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_employeelocation s
    WHERE t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno;

    INSERT INTO click.d_employeelocation(emp_loc_key, emp_employee_code, emp_ou, emp_lineno, emp_geo_type, emp_division_location, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.emp_loc_key, s.emp_employee_code, s.emp_ou, s.emp_lineno, s.emp_geo_type, s.emp_division_location, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_employeelocation s
    LEFT JOIN click.d_employeelocation t
    ON t.emp_employee_code = s.emp_employee_code
    AND t.emp_ou = s.emp_ou
    AND t.emp_lineno = s.emp_lineno
    WHERE t.emp_employee_code IS NULL;
END;
$$;