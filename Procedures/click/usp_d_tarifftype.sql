CREATE PROCEDURE click.usp_d_tarifftype()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_tarifftype t
    SET
        tar_key = s.tar_key,
        tar_lineno = s.tar_lineno,
        tar_ou = s.tar_ou,
        tar_applicability = s.tar_applicability,
        tar_scr_code = s.tar_scr_code,
        tar_type_code = s.tar_type_code,
        tar_tf_type = s.tar_tf_type,
        tar_display_tf_type = s.tar_display_tf_type,
        tar_created_by = s.tar_created_by,
        tar_created_date = s.tar_created_date,
        tar_modified_by = s.tar_modified_by,
        tar_modified_date = s.tar_modified_date,
        tar_timestamp = s.tar_timestamp,
        tar_revenue_split = s.tar_revenue_split,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_tarifftype s
    WHERE t.tar_lineno = s.tar_lineno
    AND t.tar_ou = s.tar_ou;

    INSERT INTO click.d_tarifftype(tar_key, tar_lineno, tar_ou, tar_applicability, tar_scr_code, tar_type_code, tar_tf_type, tar_display_tf_type, tar_created_by, tar_created_date, tar_modified_by, tar_modified_date, tar_timestamp, tar_revenue_split, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tar_key, s.tar_lineno, s.tar_ou, s.tar_applicability, s.tar_scr_code, s.tar_type_code, s.tar_tf_type, s.tar_display_tf_type, s.tar_created_by, s.tar_created_date, s.tar_modified_by, s.tar_modified_date, s.tar_timestamp, s.tar_revenue_split, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_tarifftype s
    LEFT JOIN click.d_tarifftype t
    ON t.tar_lineno = s.tar_lineno
    AND t.tar_ou = s.tar_ou
    WHERE t.tar_lineno IS NULL;
END;
$$;