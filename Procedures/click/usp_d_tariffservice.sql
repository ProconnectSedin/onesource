CREATE PROCEDURE click.usp_d_tariffservice()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_tariffservice t
    SET
        tf_key = s.tf_key,
        tf_ser_id = s.tf_ser_id,
        tf_ser_ou = s.tf_ser_ou,
        tf_ser_desc = s.tf_ser_desc,
        tf_ser_status = s.tf_ser_status,
        tf_ser_valid_from = s.tf_ser_valid_from,
        tf_ser_valid_to = s.tf_ser_valid_to,
        tf_ser_service_period = s.tf_ser_service_period,
        tf_ser_uom = s.tf_ser_uom,
        tf_ser_service_level_per = s.tf_ser_service_level_per,
        tf_ser_reason_code = s.tf_ser_reason_code,
        tf_ser_timestamp = s.tf_ser_timestamp,
        tf_ser_created_by = s.tf_ser_created_by,
        tf_ser_created_dt = s.tf_ser_created_dt,
        tf_ser_modified_by = s.tf_ser_modified_by,
        tf_ser_modified_dt = s.tf_ser_modified_dt,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_tariffservice s
    WHERE t.tf_ser_id = s.tf_ser_id
    AND t.tf_ser_ou = s.tf_ser_ou;

    INSERT INTO click.d_tariffservice(tf_key, tf_ser_id, tf_ser_ou, tf_ser_desc, tf_ser_status, tf_ser_valid_from, tf_ser_valid_to, tf_ser_service_period, tf_ser_uom, tf_ser_service_level_per, tf_ser_reason_code, tf_ser_timestamp, tf_ser_created_by, tf_ser_created_dt, tf_ser_modified_by, tf_ser_modified_dt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tf_key, s.tf_ser_id, s.tf_ser_ou, s.tf_ser_desc, s.tf_ser_status, s.tf_ser_valid_from, s.tf_ser_valid_to, s.tf_ser_service_period, s.tf_ser_uom, s.tf_ser_service_level_per, s.tf_ser_reason_code, s.tf_ser_timestamp, s.tf_ser_created_by, s.tf_ser_created_dt, s.tf_ser_modified_by, s.tf_ser_modified_dt, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_tariffservice s
    LEFT JOIN click.d_tariffservice t
    ON t.tf_ser_id = s.tf_ser_id
    AND t.tf_ser_ou = s.tf_ser_ou
    WHERE t.tf_ser_id IS NULL;
END;
$$;