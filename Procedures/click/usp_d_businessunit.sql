CREATE PROCEDURE click.usp_d_businessunit()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_businessunit t
    SET
        bu_key = s.bu_key,
        company_code = s.company_code,
        bu_id = s.bu_id,
        serial_no = s.serial_no,
        btimestamp = s.btimestamp,
        bu_name = s.bu_name,
        status = s.status,
        address_id = s.address_id,
        effective_from = s.effective_from,
        createdby = s.createdby,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_businessunit s
    WHERE t.company_code = s.company_code
    AND t.bu_id = s.bu_id
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_businessunit(bu_key, company_code, bu_id, serial_no, btimestamp, bu_name, status, address_id, effective_from, createdby, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bu_key, s.company_code, s.bu_id, s.serial_no, s.btimestamp, s.bu_name, s.status, s.address_id, s.effective_from, s.createdby, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_businessunit s
    LEFT JOIN click.d_businessunit t
    ON t.company_code = s.company_code
    AND t.bu_id = s.bu_id
    AND t.serial_no = s.serial_no
    WHERE t.company_code IS NULL;
END;
$$;