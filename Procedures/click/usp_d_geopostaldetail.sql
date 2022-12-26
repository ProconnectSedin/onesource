CREATE OR REPLACE PROCEDURE click.usp_d_geopostaldetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geopostaldetail t
    SET
        geo_postal_key = s.geo_postal_key,
        geo_country_code = s.geo_country_code,
        geo_state_code = s.geo_state_code,
        geo_city_code = s.geo_city_code,
        geo_postal_code = s.geo_postal_code,
        geo_postal_ou = s.geo_postal_ou,
        geo_postal_lineno = s.geo_postal_lineno,
        geo_postal_desc = s.geo_postal_desc,
        geo_postal_status = s.geo_postal_status,
        geo_postal_rsn = s.geo_postal_rsn,
        geo_postal_lantitude = s.geo_postal_lantitude,
        geo_postal_longitude = s.geo_postal_longitude,
        geo_postal_geo_fen_name = s.geo_postal_geo_fen_name,
        geo_postal_geo_fen_range = s.geo_postal_geo_fen_range,
        geo_postal_range_uom = s.geo_postal_range_uom,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geopostaldetail s
    WHERE t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_postal_code = s.geo_postal_code
    AND t.geo_postal_ou = s.geo_postal_ou
    AND t.geo_postal_lineno = s.geo_postal_lineno;

    INSERT INTO click.d_geopostaldetail(geo_postal_key, geo_country_code, geo_state_code, geo_city_code, geo_postal_code, geo_postal_ou, geo_postal_lineno, geo_postal_desc, geo_postal_status, geo_postal_rsn, geo_postal_lantitude, geo_postal_longitude, geo_postal_geo_fen_name, geo_postal_geo_fen_range, geo_postal_range_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_postal_key, s.geo_country_code, s.geo_state_code, s.geo_city_code, s.geo_postal_code, s.geo_postal_ou, s.geo_postal_lineno, s.geo_postal_desc, s.geo_postal_status, s.geo_postal_rsn, s.geo_postal_lantitude, s.geo_postal_longitude, s.geo_postal_geo_fen_name, s.geo_postal_geo_fen_range, s.geo_postal_range_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geopostaldetail s
    LEFT JOIN click.d_geopostaldetail t
    ON t.geo_country_code = s.geo_country_code
    AND t.geo_state_code = s.geo_state_code
    AND t.geo_city_code = s.geo_city_code
    AND t.geo_postal_code = s.geo_postal_code
    AND t.geo_postal_ou = s.geo_postal_ou
    AND t.geo_postal_lineno = s.geo_postal_lineno
    WHERE t.geo_country_code IS NULL;
END;
$$;