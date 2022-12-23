CREATE PROCEDURE click.usp_d_yard()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_yard t
    SET
        yard_key = s.yard_key,
        yard_id = s.yard_id,
        yard_loc_code = s.yard_loc_code,
        yard_ou = s.yard_ou,
        yard_desc = s.yard_desc,
        yard_type = s.yard_type,
        yard_status = s.yard_status,
        yard_reason = s.yard_reason,
        yard_timestamp = s.yard_timestamp,
        yard_created_by = s.yard_created_by,
        yard_created_dt = s.yard_created_dt,
        yard_modified_by = s.yard_modified_by,
        yard_modified_dt = s.yard_modified_dt,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_yard s
    WHERE t.yard_id = s.yard_id
    AND t.yard_loc_code = s.yard_loc_code
    AND t.yard_ou = s.yard_ou;

    INSERT INTO click.d_yard(yard_key, yard_id, yard_loc_code, yard_ou, yard_desc, yard_type, yard_status, yard_reason, yard_timestamp, yard_created_by, yard_created_dt, yard_modified_by, yard_modified_dt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.yard_key, s.yard_id, s.yard_loc_code, s.yard_ou, s.yard_desc, s.yard_type, s.yard_status, s.yard_reason, s.yard_timestamp, s.yard_created_by, s.yard_created_dt, s.yard_modified_by, s.yard_modified_dt, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_yard s
    LEFT JOIN click.d_yard t
    ON t.yard_id = s.yard_id
    AND t.yard_loc_code = s.yard_loc_code
    AND t.yard_ou = s.yard_ou
    WHERE t.yard_id IS NULL;
END;
$$;