CREATE OR REPLACE PROCEDURE click.usp_d_geozone()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geozone t
    SET
        geo_zone_key = s.geo_zone_key,
        geo_zone = s.geo_zone,
        geo_zone_ou = s.geo_zone_ou,
        geo_zone_desc = s.geo_zone_desc,
        geo_zone_stat = s.geo_zone_stat,
        geo_zone_rsn = s.geo_zone_rsn,
        geo_zone_created_by = s.geo_zone_created_by,
        geo_zone_created_date = s.geo_zone_created_date,
        geo_zone_modified_by = s.geo_zone_modified_by,
        geo_zone_modified_date = s.geo_zone_modified_date,
        geo_zone_timestamp = s.geo_zone_timestamp,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geozone s
    WHERE t.geo_zone = s.geo_zone
    AND t.geo_zone_ou = s.geo_zone_ou;

    INSERT INTO click.d_geozone(geo_zone_key, geo_zone, geo_zone_ou, geo_zone_desc, geo_zone_stat, geo_zone_rsn, geo_zone_created_by, geo_zone_created_date, geo_zone_modified_by, geo_zone_modified_date, geo_zone_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_zone_key, s.geo_zone, s.geo_zone_ou, s.geo_zone_desc, s.geo_zone_stat, s.geo_zone_rsn, s.geo_zone_created_by, s.geo_zone_created_date, s.geo_zone_modified_by, s.geo_zone_modified_date, s.geo_zone_timestamp, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geozone s
    LEFT JOIN click.d_geozone t
    ON t.geo_zone = s.geo_zone
    AND t.geo_zone_ou = s.geo_zone_ou
    WHERE t.geo_zone IS NULL;
END;
$$;