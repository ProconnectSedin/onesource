CREATE PROCEDURE click.usp_d_gateemployeemapping()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_gateemployeemapping t
    SET
        gate_emp_map_key = s.gate_emp_map_key,
        gate_loc_code = s.gate_loc_code,
        gate_ou = s.gate_ou,
        gate_lineno = s.gate_lineno,
        gate_shift_code = s.gate_shift_code,
        gate_emp_code = s.gate_emp_code,
        gate_area = s.gate_area,
        gate_timestamp = s.gate_timestamp,
        gate_created_by = s.gate_created_by,
        gate_created_date = s.gate_created_date,
        gate_modified_by = s.gate_modified_by,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_gateemployeemapping s
    WHERE t.gate_loc_code = s.gate_loc_code
    AND t.gate_ou = s.gate_ou
    AND t.gate_lineno = s.gate_lineno;

    INSERT INTO click.d_gateemployeemapping(gate_emp_map_key, gate_loc_code, gate_ou, gate_lineno, gate_shift_code, gate_emp_code, gate_area, gate_timestamp, gate_created_by, gate_created_date, gate_modified_by, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.gate_emp_map_key, s.gate_loc_code, s.gate_ou, s.gate_lineno, s.gate_shift_code, s.gate_emp_code, s.gate_area, s.gate_timestamp, s.gate_created_by, s.gate_created_date, s.gate_modified_by, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_gateemployeemapping s
    LEFT JOIN click.d_gateemployeemapping t
    ON t.gate_loc_code = s.gate_loc_code
    AND t.gate_ou = s.gate_ou
    AND t.gate_lineno = s.gate_lineno
    WHERE t.gate_loc_code IS NULL;
END;
$$;