CREATE PROCEDURE click.usp_d_division()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_division t
    SET
        div_key = s.div_key,
        div_ou = s.div_ou,
        div_code = s.div_code,
        div_desc = s.div_desc,
        div_status = s.div_status,
        div_type = s.div_type,
        div_reason_code = s.div_reason_code,
        div_user_def1 = s.div_user_def1,
        div_user_def2 = s.div_user_def2,
        div_user_def3 = s.div_user_def3,
        div_timestamp = s.div_timestamp,
        div_created_by = s.div_created_by,
        div_created_dt = s.div_created_dt,
        div_modified_by = s.div_modified_by,
        div_modified_dt = s.div_modified_dt,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_division s
    WHERE t.div_ou = s.div_ou
    AND t.div_code = s.div_code;

    INSERT INTO click.d_division(div_key, div_ou, div_code, div_desc, div_status, div_type, div_reason_code, div_user_def1, div_user_def2, div_user_def3, div_timestamp, div_created_by, div_created_dt, div_modified_by, div_modified_dt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.div_key, s.div_ou, s.div_code, s.div_desc, s.div_status, s.div_type, s.div_reason_code, s.div_user_def1, s.div_user_def2, s.div_user_def3, s.div_timestamp, s.div_created_by, s.div_created_dt, s.div_modified_by, s.div_modified_dt, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_division s
    LEFT JOIN click.d_division t
    ON t.div_ou = s.div_ou
    AND t.div_code = s.div_code
    WHERE t.div_ou IS NULL;
END;
$$;