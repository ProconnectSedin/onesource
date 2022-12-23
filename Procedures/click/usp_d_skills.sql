CREATE PROCEDURE click.usp_d_skills()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_skills t
    SET
        skl_key = s.skl_key,
        skl_ou = s.skl_ou,
        skl_code = s.skl_code,
        skl_type = s.skl_type,
        skl_desc = s.skl_desc,
        skl_currency = s.skl_currency,
        skl_status = s.skl_status,
        skl_timestamp = s.skl_timestamp,
        skl_created_by = s.skl_created_by,
        skl_created_dt = s.skl_created_dt,
        skl_modified_by = s.skl_modified_by,
        skl_modified_dt = s.skl_modified_dt,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_skills s
    WHERE t.skl_ou = s.skl_ou
    AND t.skl_code = s.skl_code
    AND t.skl_type = s.skl_type;

    INSERT INTO click.d_skills(skl_key, skl_ou, skl_code, skl_type, skl_desc, skl_currency, skl_status, skl_timestamp, skl_created_by, skl_created_dt, skl_modified_by, skl_modified_dt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.skl_key, s.skl_ou, s.skl_code, s.skl_type, s.skl_desc, s.skl_currency, s.skl_status, s.skl_timestamp, s.skl_created_by, s.skl_created_dt, s.skl_modified_by, s.skl_modified_dt, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_skills s
    LEFT JOIN click.d_skills t
    ON t.skl_ou = s.skl_ou
    AND t.skl_code = s.skl_code
    AND t.skl_type = s.skl_type
    WHERE t.skl_ou IS NULL;
END;
$$;