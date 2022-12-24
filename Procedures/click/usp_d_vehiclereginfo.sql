CREATE OR REPLACE PROCEDURE click.usp_d_vehiclereginfo()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_vehiclereginfo t
    SET
        veh_rifo_key = s.veh_rifo_key,
        veh_ou = s.veh_ou,
        veh_id = s.veh_id,
        veh_line_no = s.veh_line_no,
        veh_address = s.veh_address,
        veh_title_holder_name = s.veh_title_holder_name,
        veh_issuing_auth = s.veh_issuing_auth,
        veh_issuing_location = s.veh_issuing_location,
        veh_issuing_date = s.veh_issuing_date,
        veh_exp_date = s.veh_exp_date,
        veh_remarks = s.veh_remarks,
        veh_doc_type = s.veh_doc_type,
        veh_doc_no = s.veh_doc_no,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_vehiclereginfo s
    WHERE t.veh_ou = s.veh_ou
    AND t.veh_id = s.veh_id
    AND t.veh_line_no = s.veh_line_no;

    INSERT INTO click.d_vehiclereginfo(veh_rifo_key, veh_ou, veh_id, veh_line_no, veh_address, veh_title_holder_name, veh_issuing_auth, veh_issuing_location, veh_issuing_date, veh_exp_date, veh_remarks, veh_doc_type, veh_doc_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.veh_rifo_key, s.veh_ou, s.veh_id, s.veh_line_no, s.veh_address, s.veh_title_holder_name, s.veh_issuing_auth, s.veh_issuing_location, s.veh_issuing_date, s.veh_exp_date, s.veh_remarks, s.veh_doc_type, s.veh_doc_no, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_vehiclereginfo s
    LEFT JOIN click.d_vehiclereginfo t
    ON t.veh_ou = s.veh_ou
    AND t.veh_id = s.veh_id
    AND t.veh_line_no = s.veh_line_no
    WHERE t.veh_ou IS NULL;
END;
$$;