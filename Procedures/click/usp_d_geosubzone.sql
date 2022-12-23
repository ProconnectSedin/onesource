CREATE PROCEDURE click.usp_d_geosubzone()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_geosubzone t
    SET
        geo_sub_zone_key = s.geo_sub_zone_key,
        geo_sub_zone = s.geo_sub_zone,
        geo_sub_zone_ou = s.geo_sub_zone_ou,
        geo_sub_zone_desc = s.geo_sub_zone_desc,
        geo_sub_zone_stat = s.geo_sub_zone_stat,
        geo_sub_zone_created_by = s.geo_sub_zone_created_by,
        geo_sub_zone_created_date = s.geo_sub_zone_created_date,
        geo_sub_zone_modified_by = s.geo_sub_zone_modified_by,
        geo_sub_zone_modified_date = s.geo_sub_zone_modified_date,
        geo_sub_zone_timestamp = s.geo_sub_zone_timestamp,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_geosubzone s
    WHERE t.geo_sub_zone = s.geo_sub_zone
    AND t.geo_sub_zone_ou = s.geo_sub_zone_ou;

    INSERT INTO click.d_geosubzone(geo_sub_zone_key, geo_sub_zone, geo_sub_zone_ou, geo_sub_zone_desc, geo_sub_zone_stat, geo_sub_zone_created_by, geo_sub_zone_created_date, geo_sub_zone_modified_by, geo_sub_zone_modified_date, geo_sub_zone_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_sub_zone_key, s.geo_sub_zone, s.geo_sub_zone_ou, s.geo_sub_zone_desc, s.geo_sub_zone_stat, s.geo_sub_zone_created_by, s.geo_sub_zone_created_date, s.geo_sub_zone_modified_by, s.geo_sub_zone_modified_date, s.geo_sub_zone_timestamp, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_geosubzone s
    LEFT JOIN click.d_geosubzone t
    ON t.geo_sub_zone = s.geo_sub_zone
    AND t.geo_sub_zone_ou = s.geo_sub_zone_ou
    WHERE t.geo_sub_zone IS NULL;
END;
$$;