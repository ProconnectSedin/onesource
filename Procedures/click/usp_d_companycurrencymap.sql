CREATE OR REPLACE PROCEDURE click.usp_d_companycurrencymap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_companycurrencymap t
    SET
        d_companycurrencymap_key = s.d_companycurrencymap_key,
        serial_no = s.serial_no,
        company_code = s.company_code,
        currency_code = s.currency_code,
        timestamp = s.timestamp,
        map_status = s.map_status,
        effective_from = s.effective_from,
        map_by = s.map_by,
        map_date = s.map_date,
        currency_flag = s.currency_flag,
        createdby = s.createdby,
        createddate = s.createddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_companycurrencymap s
    WHERE t.serial_no = s.serial_no
    AND t.company_code = s.company_code
    AND t.currency_code = s.currency_code;

    INSERT INTO click.d_companycurrencymap(d_companycurrencymap_key, serial_no, company_code, currency_code, timestamp, map_status, effective_from, map_by, map_date, currency_flag, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_companycurrencymap_key, s.serial_no, s.company_code, s.currency_code, s.timestamp, s.map_status, s.effective_from, s.map_by, s.map_date, s.currency_flag, s.createdby, s.createddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_companycurrencymap s
    LEFT JOIN click.d_companycurrencymap t
    ON t.serial_no = s.serial_no
    AND t.company_code = s.company_code
    AND t.currency_code = s.currency_code
    WHERE t.serial_no IS NULL;
END;
$$;