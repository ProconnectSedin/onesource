CREATE PROCEDURE click.usp_d_equipmentgroup()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_equipmentgroup t
    SET
        egrp_key = s.egrp_key,
        egrp_ou = s.egrp_ou,
        egrp_id = s.egrp_id,
        egrp_desc = s.egrp_desc,
        egrp_status = s.egrp_status,
        egrp_created_by = s.egrp_created_by,
        egrp_created_date = s.egrp_created_date,
        egrp_modified_by = s.egrp_modified_by,
        egrp_modified_date = s.egrp_modified_date,
        egrp_timestamp = s.egrp_timestamp,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_equipmentgroup s
    WHERE t.egrp_ou = s.egrp_ou
    AND t.egrp_id = s.egrp_id;

    INSERT INTO click.d_equipmentgroup(egrp_key, egrp_ou, egrp_id, egrp_desc, egrp_status, egrp_created_by, egrp_created_date, egrp_modified_by, egrp_modified_date, egrp_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.egrp_key, s.egrp_ou, s.egrp_id, s.egrp_desc, s.egrp_status, s.egrp_created_by, s.egrp_created_date, s.egrp_modified_by, s.egrp_modified_date, s.egrp_timestamp, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_equipmentgroup s
    LEFT JOIN click.d_equipmentgroup t
    ON t.egrp_ou = s.egrp_ou
    AND t.egrp_id = s.egrp_id
    WHERE t.egrp_ou IS NULL;
END;
$$;