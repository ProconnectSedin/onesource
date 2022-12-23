CREATE PROCEDURE click.usp_d_locationusermapping()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_locationusermapping t
    SET
        loc_user_mapping_key = s.loc_user_mapping_key,
        loc_ou = s.loc_ou,
        loc_code = s.loc_code,
        loc_lineno = s.loc_lineno,
        loc_user_name = s.loc_user_name,
        loc_user_admin = s.loc_user_admin,
        loc_user_planner = s.loc_user_planner,
        loc_user_executor = s.loc_user_executor,
        loc_user_controller = s.loc_user_controller,
        loc_user_default = s.loc_user_default,
        loc_status = s.loc_status,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_locationusermapping s
    WHERE t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_lineno = s.loc_lineno;

    INSERT INTO click.d_locationusermapping(loc_user_mapping_key, loc_ou, loc_code, loc_lineno, loc_user_name, loc_user_admin, loc_user_planner, loc_user_executor, loc_user_controller, loc_user_default, loc_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_user_mapping_key, s.loc_ou, s.loc_code, s.loc_lineno, s.loc_user_name, s.loc_user_admin, s.loc_user_planner, s.loc_user_executor, s.loc_user_controller, s.loc_user_default, s.loc_status, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_locationusermapping s
    LEFT JOIN click.d_locationusermapping t
    ON t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_lineno = s.loc_lineno
    WHERE t.loc_ou IS NULL;
END;
$$;