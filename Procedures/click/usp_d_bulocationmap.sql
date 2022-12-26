CREATE OR REPLACE PROCEDURE click.usp_d_bulocationmap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bulocationmap t
    SET
        bu_loc_map_key = s.bu_loc_map_key,
        lo_id = s.lo_id,
        bu_id = s.bu_id,
        company_code = s.company_code,
        serial_no = s.serial_no,
        btimestamp = s.btimestamp,
        lo_name = s.lo_name,
        map_status = s.map_status,
        effective_from = s.effective_from,
        map_by = s.map_by,
        map_date = s.map_date,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_bulocationmap s
    WHERE t.lo_id = s.lo_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_bulocationmap(bu_loc_map_key, lo_id, bu_id, company_code, serial_no, btimestamp, lo_name, map_status, effective_from, map_by, map_date, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bu_loc_map_key, s.lo_id, s.bu_id, s.company_code, s.serial_no, s.btimestamp, s.lo_name, s.map_status, s.effective_from, s.map_by, s.map_date, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bulocationmap s
    LEFT JOIN click.d_bulocationmap t
    ON t.lo_id = s.lo_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no
    WHERE t.lo_id IS NULL;
END;
$$;