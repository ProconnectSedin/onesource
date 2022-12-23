CREATE PROCEDURE click.usp_d_route()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_route t
    SET
        rou_key = s.rou_key,
        rou_route_id = s.rou_route_id,
        rou_ou = s.rou_ou,
        rou_description = s.rou_description,
        rou_status = s.rou_status,
        rou_rsn_code = s.rou_rsn_code,
        rou_trans_mode = s.rou_trans_mode,
        rou_serv_type = s.rou_serv_type,
        rou_sub_serv_type = s.rou_sub_serv_type,
        rou_valid_frm = s.rou_valid_frm,
        rou_valid_to = s.rou_valid_to,
        rou_created_by = s.rou_created_by,
        rou_created_date = s.rou_created_date,
        rou_modified_by = s.rou_modified_by,
        rou_modified_date = s.rou_modified_date,
        rou_timestamp = s.rou_timestamp,
        rou_route_type = s.rou_route_type,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_route s
    WHERE t.rou_route_id = s.rou_route_id
    AND t.rou_ou = s.rou_ou;

    INSERT INTO click.d_route(rou_key, rou_route_id, rou_ou, rou_description, rou_status, rou_rsn_code, rou_trans_mode, rou_serv_type, rou_sub_serv_type, rou_valid_frm, rou_valid_to, rou_created_by, rou_created_date, rou_modified_by, rou_modified_date, rou_timestamp, rou_route_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.rou_key, s.rou_route_id, s.rou_ou, s.rou_description, s.rou_status, s.rou_rsn_code, s.rou_trans_mode, s.rou_serv_type, s.rou_sub_serv_type, s.rou_valid_frm, s.rou_valid_to, s.rou_created_by, s.rou_created_date, s.rou_modified_by, s.rou_modified_date, s.rou_timestamp, s.rou_route_type, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_route s
    LEFT JOIN click.d_route t
    ON t.rou_route_id = s.rou_route_id
    AND t.rou_ou = s.rou_ou
    WHERE t.rou_route_id IS NULL;
END;
$$;