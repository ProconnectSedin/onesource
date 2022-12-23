CREATE PROCEDURE click.usp_d_geostatedetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geostatedetail t
    SET
        geo_state_key = s.geo_state_key,
        geo_country_code = s.geo_country_code,
        geo_state_code = s.geo_state_code,
        geo_state_ou = s.geo_state_ou,
        geo_state_lineno = s.geo_state_lineno,
        geo_state_desc = s.geo_state_desc,
        geo_state_timezn = s.geo_state_timezn,
        geo_state_status = s.geo_state_status,
        geo_state_rsn = s.geo_state_rsn,
        ge_holidays = s.ge_holidays,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geostatedetail s
    WHERE t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_state_ou = s.geo_state_ou
    AND t.geo_state_lineno = s.geo_state_lineno;

    INSERT INTO click.d_geostatedetail(geo_state_key, geo_country_code, geo_state_code, geo_state_ou, geo_state_lineno, geo_state_desc, geo_state_timezn, geo_state_status, geo_state_rsn, ge_holidays, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_state_key, s.geo_country_code, s.geo_state_code, s.geo_state_ou, s.geo_state_lineno, s.geo_state_desc, s.geo_state_timezn, s.geo_state_status, s.geo_state_rsn, s.ge_holidays, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geostatedetail s
    LEFT JOIN click.d_geostatedetail t
    ON t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_state_ou = s.geo_state_ou
    AND t.geo_state_lineno = s.geo_state_lineno
    WHERE t.geo_country_code IS NULL;
END;
$$;