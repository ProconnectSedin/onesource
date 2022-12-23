CREATE PROCEDURE click.usp_d_geocitydetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geocitydetail t
    SET
        geo_city_key = s.geo_city_key,
        geo_country_code = s.geo_country_code,
        geo_state_code = s.geo_state_code,
        geo_city_code = s.geo_city_code,
        geo_city_ou = s.geo_city_ou,
        geo_city_lineno = s.geo_city_lineno,
        geo_city_desc = s.geo_city_desc,
        geo_city_timezn = s.geo_city_timezn,
        geo_city_status = s.geo_city_status,
        geo_city_rsn = s.geo_city_rsn,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geocitydetail s
    WHERE t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_city_ou = s.geo_city_ou
    AND t.geo_city_lineno = s.geo_city_lineno;

    INSERT INTO click.d_geocitydetail(geo_city_key, geo_country_code, geo_state_code, geo_city_code, geo_city_ou, geo_city_lineno, geo_city_desc, geo_city_timezn, geo_city_status, geo_city_rsn, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_city_key, s.geo_country_code, s.geo_state_code, s.geo_city_code, s.geo_city_ou, s.geo_city_lineno, s.geo_city_desc, s.geo_city_timezn, s.geo_city_status, s.geo_city_rsn, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geocitydetail s
    LEFT JOIN click.d_geocitydetail t
    ON t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_city_ou = s.geo_city_ou
    AND t.geo_city_lineno = s.geo_city_lineno
    WHERE t.geo_country_code IS NULL;
END;
$$;