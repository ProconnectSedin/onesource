CREATE OR REPLACE PROCEDURE click.usp_d_exchangerate()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_exchangerate t
    SET
        d_exchangerate_key = s.d_exchangerate_key,
        ou_id = s.ou_id,
        exchrate_type = s.exchrate_type,
        from_currency = s.from_currency,
        to_currency = s.to_currency,
        inverse_typeno = s.inverse_typeno,
        start_date = s.start_date,
        timestamp = s.timestamp,
        end_date = s.end_date,
        exchange_rate = s.exchange_rate,
        tolerance_flag = s.tolerance_flag,
        tolerance_limit = s.tolerance_limit,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_exchangerate s
    WHERE t.ou_id = s.ou_id
    AND t.exchrate_type = s.exchrate_type
    AND t.from_currency = s.from_currency
    AND t.to_currency = s.to_currency
    AND t.inverse_typeno = s.inverse_typeno
    AND t.start_date = s.start_date;

    INSERT INTO click.d_exchangerate(d_exchangerate_key, ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date, timestamp, end_date, exchange_rate, tolerance_flag, tolerance_limit, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_exchangerate_key, s.ou_id, s.exchrate_type, s.from_currency, s.to_currency, s.inverse_typeno, s.start_date, s.timestamp, s.end_date, s.exchange_rate, s.tolerance_flag, s.tolerance_limit, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_exchangerate s
    LEFT JOIN click.d_exchangerate t
    ON t.ou_id = s.ou_id
    AND t.exchrate_type = s.exchrate_type
    AND t.from_currency = s.from_currency
    AND t.to_currency = s.to_currency
    AND t.inverse_typeno = s.inverse_typeno
    AND t.start_date = s.start_date
    WHERE t.ou_id IS NULL;
END;
$$;