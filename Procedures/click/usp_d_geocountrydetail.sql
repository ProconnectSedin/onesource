CREATE OR REPLACE PROCEDURE click.usp_d_geocountrydetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geocountrydetail t
    SET
        geo_country_key = s.geo_country_key,
        geo_country_code = s.geo_country_code,
        geo_country_ou = s.geo_country_ou,
        geo_country_lineno = s.geo_country_lineno,
        geo_country_desc = s.geo_country_desc,
        geo_country_timezn = s.geo_country_timezn,
        geo_country_status = s.geo_country_status,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geocountrydetail s
    WHERE t.geo_country_code = s.geo_country_code
    AND t.geo_country_ou = s.geo_country_ou
    AND t.geo_country_lineno = s.geo_country_lineno;

    INSERT INTO click.d_geocountrydetail(geo_country_key, geo_country_code, geo_country_ou, geo_country_lineno, geo_country_desc, geo_country_timezn, geo_country_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_country_key, s.geo_country_code, s.geo_country_ou, s.geo_country_lineno, s.geo_country_desc, s.geo_country_timezn, s.geo_country_status, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geocountrydetail s
    LEFT JOIN click.d_geocountrydetail t
    ON t.geo_country_code = s.geo_country_code
    AND t.geo_country_ou = s.geo_country_ou
    AND t.geo_country_lineno = s.geo_country_lineno
    WHERE t.geo_country_code IS NULL;
END;
$$;