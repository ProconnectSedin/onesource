CREATE PROCEDURE click.usp_d_oumaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_oumaster t
    SET
        ou_key = s.ou_key,
        ou_id = s.ou_id,
        bu_id = s.bu_id,
        company_code = s.company_code,
        address_id = s.address_id,
        serial_no = s.serial_no,
        otimestamp = s.otimestamp,
        default_flag = s.default_flag,
        map_status = s.map_status,
        effective_from = s.effective_from,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_oumaster s
    WHERE t.ou_id = s.ou_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.address_id = s.address_id
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_oumaster(ou_key, ou_id, bu_id, company_code, address_id, serial_no, otimestamp, default_flag, map_status, effective_from, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.ou_key, s.ou_id, s.bu_id, s.company_code, s.address_id, s.serial_no, s.otimestamp, s.default_flag, s.map_status, s.effective_from, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_oumaster s
    LEFT JOIN click.d_oumaster t
    ON t.ou_id = s.ou_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.address_id = s.address_id
    AND t.serial_no = s.serial_no
    WHERE t.ou_id IS NULL;
END;
$$;