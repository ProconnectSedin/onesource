CREATE OR REPLACE PROCEDURE click.usp_d_oubumap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_oubumap t
    SET
        d_oubumap_key = s.d_oubumap_key,
        ou_id = s.ou_id,
        bu_id = s.bu_id,
        company_code = s.company_code,
        serial_no = s.serial_no,
        timestamp = s.timestamp,
        map_status = s.map_status,
        effective_from = s.effective_from,
        map_by = s.map_by,
        map_date = s.map_date,
        createdby = s.createdby,
        createddate = s.createddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_oubumap s
    WHERE t.ou_id = s.ou_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_oubumap(d_oubumap_key, ou_id, bu_id, company_code, serial_no, timestamp, map_status, effective_from, map_by, map_date, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_oubumap_key, s.ou_id, s.bu_id, s.company_code, s.serial_no, s.timestamp, s.map_status, s.effective_from, s.map_by, s.map_date, s.createdby, s.createddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_oubumap s
    LEFT JOIN click.d_oubumap t
    ON t.ou_id = s.ou_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no
    WHERE t.ou_id IS NULL;
END;
$$;