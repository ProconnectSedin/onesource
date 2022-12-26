CREATE OR REPLACE PROCEDURE click.usp_d_locationgeomap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_locationgeomap t
    SET
        loc_geo_key = s.loc_geo_key,
        loc_ou = s.loc_ou,
        loc_code = s.loc_code,
        loc_geo_lineno = s.loc_geo_lineno,
        loc_geography = s.loc_geography,
        loc_geo_type = s.loc_geo_type,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_locationgeomap s
    WHERE t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_geo_lineno = s.loc_geo_lineno;

    INSERT INTO click.d_locationgeomap(loc_geo_key, loc_ou, loc_code, loc_geo_lineno, loc_geography, loc_geo_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_geo_key, s.loc_ou, s.loc_code, s.loc_geo_lineno, s.loc_geography, s.loc_geo_type, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_locationgeomap s
    LEFT JOIN click.d_locationgeomap t
    ON t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_geo_lineno = s.loc_geo_lineno
    WHERE t.loc_ou IS NULL;
END;
$$;