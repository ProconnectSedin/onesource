CREATE OR REPLACE PROCEDURE click.usp_d_wmsgeozonedetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_wmsgeozonedetail t
    SET
        geo_zone_key = s.geo_zone_key,
        geo_zone = s.geo_zone,
        geo_zone_ou = s.geo_zone_ou,
        geo_zone_lineno = s.geo_zone_lineno,
        geo_zone_type = s.geo_zone_type,
        geo_zone_type_code = s.geo_zone_type_code,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_wmsgeozonedetail s
    WHERE t.geo_zone = s.geo_zone
    AND t.geo_zone_ou = s.geo_zone_ou
    AND t.geo_zone_lineno = s.geo_zone_lineno
    AND t.geo_zone_type_code = s.geo_zone_type_code;

    INSERT INTO click.d_wmsgeozonedetail(geo_zone_key, geo_zone, geo_zone_ou, geo_zone_lineno, geo_zone_type, geo_zone_type_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_zone_key, s.geo_zone, s.geo_zone_ou, s.geo_zone_lineno, s.geo_zone_type, s.geo_zone_type_code, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_wmsgeozonedetail s
    LEFT JOIN click.d_wmsgeozonedetail t
    ON t.geo_zone = s.geo_zone
    AND t.geo_zone_ou = s.geo_zone_ou
    AND t.geo_zone_lineno = s.geo_zone_lineno
    AND t.geo_zone_type_code = s.geo_zone_type_code
    WHERE t.geo_zone IS NULL;
END;
$$;