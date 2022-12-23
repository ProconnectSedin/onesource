CREATE PROCEDURE click.usp_d_shippingpointcustmap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_shippingpointcustmap t
    SET
        shp_pt_cus_key = s.shp_pt_cus_key,
        shp_pt_ou = s.shp_pt_ou,
        shp_pt_id = s.shp_pt_id,
        shp_pt_lineno = s.shp_pt_lineno,
        shp_pt_cusid = s.shp_pt_cusid,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_shippingpointcustmap s
    WHERE t.shp_pt_ou = s.shp_pt_ou
    AND t.shp_pt_id = s.shp_pt_id
    AND t.shp_pt_lineno = s.shp_pt_lineno;

    INSERT INTO click.d_shippingpointcustmap(shp_pt_cus_key, shp_pt_ou, shp_pt_id, shp_pt_lineno, shp_pt_cusid, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.shp_pt_cus_key, s.shp_pt_ou, s.shp_pt_id, s.shp_pt_lineno, s.shp_pt_cusid, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_shippingpointcustmap s
    LEFT JOIN click.d_shippingpointcustmap t
    ON t.shp_pt_ou = s.shp_pt_ou
    AND t.shp_pt_id = s.shp_pt_id
    AND t.shp_pt_lineno = s.shp_pt_lineno
    WHERE t.shp_pt_ou IS NULL;
END;
$$;