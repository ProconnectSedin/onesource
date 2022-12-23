CREATE PROCEDURE click.usp_d_georegion()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_georegion t
    SET
        geo_reg_key = s.geo_reg_key,
        geo_reg = s.geo_reg,
        geo_reg_ou = s.geo_reg_ou,
        geo_reg_desc = s.geo_reg_desc,
        geo_reg_stat = s.geo_reg_stat,
        geo_reg_rsn = s.geo_reg_rsn,
        geo_reg_created_by = s.geo_reg_created_by,
        geo_reg_created_date = s.geo_reg_created_date,
        geo_reg_modified_by = s.geo_reg_modified_by,
        geo_reg_modified_date = s.geo_reg_modified_date,
        geo_reg_timestamp = s.geo_reg_timestamp,
        geo_reg_userdefined1 = s.geo_reg_userdefined1,
        geo_reg_userdefined2 = s.geo_reg_userdefined2,
        geo_reg_userdefined3 = s.geo_reg_userdefined3,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_georegion s
    WHERE t.geo_reg = s.geo_reg
    AND t.geo_reg_ou = s.geo_reg_ou;

    INSERT INTO click.d_georegion(geo_reg_key, geo_reg, geo_reg_ou, geo_reg_desc, geo_reg_stat, geo_reg_rsn, geo_reg_created_by, geo_reg_created_date, geo_reg_modified_by, geo_reg_modified_date, geo_reg_timestamp, geo_reg_userdefined1, geo_reg_userdefined2, geo_reg_userdefined3, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.geo_reg_key, s.geo_reg, s.geo_reg_ou, s.geo_reg_desc, s.geo_reg_stat, s.geo_reg_rsn, s.geo_reg_created_by, s.geo_reg_created_date, s.geo_reg_modified_by, s.geo_reg_modified_date, s.geo_reg_timestamp, s.geo_reg_userdefined1, s.geo_reg_userdefined2, s.geo_reg_userdefined3, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_georegion s
    LEFT JOIN click.d_georegion t
    ON t.geo_reg = s.geo_reg
    AND t.geo_reg_ou = s.geo_reg_ou
    WHERE t.geo_reg IS NULL;
END;
$$;