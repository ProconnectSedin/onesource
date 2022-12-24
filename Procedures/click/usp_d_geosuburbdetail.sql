CREATE OR REPLACE PROCEDURE click.usp_d_geosuburbdetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geosuburbdetail t
    SET
        geo_state_key = s.geo_state_key,
        geo_country_code = s.geo_country_code,
        geo_state_code = s.geo_state_code,
        geo_city_code = s.geo_city_code,
        geo_postal_code = s.geo_postal_code,
        geo_suburb_code = s.geo_suburb_code,
        geo_suburb_ou = s.geo_suburb_ou,
        geo_suburb_lineno = s.geo_suburb_lineno,
        geo_suburb_desc = s.geo_suburb_desc,
        geo_suburb_status = s.geo_suburb_status,
        geo_suburb_rsn = s.geo_suburb_rsn,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geosuburbdetail s
    WHERE t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_postal_code = s.geo_postal_code
    AND t.geo_suburb_code = s.geo_suburb_code
    AND t.geo_suburb_ou = s.geo_suburb_ou
    AND t.geo_suburb_lineno = s.geo_suburb_lineno;

    INSERT INTO click.d_geosuburbdetail(geo_state_key, geo_country_code, geo_state_code, geo_city_code, geo_postal_code, geo_suburb_code, geo_suburb_ou, geo_suburb_lineno, geo_suburb_desc, geo_suburb_status, geo_suburb_rsn, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_state_key, s.geo_country_code, s.geo_state_code, s.geo_city_code, s.geo_postal_code, s.geo_suburb_code, s.geo_suburb_ou, s.geo_suburb_lineno, s.geo_suburb_desc, s.geo_suburb_status, s.geo_suburb_rsn, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geosuburbdetail s
    LEFT JOIN click.d_geosuburbdetail t
    ON t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_postal_code = s.geo_postal_code
    AND t.geo_suburb_code = s.geo_suburb_code
    AND t.geo_suburb_ou = s.geo_suburb_ou
    AND t.geo_suburb_lineno = s.geo_suburb_lineno
    WHERE t.geo_country_code IS NULL;
END;
$$;