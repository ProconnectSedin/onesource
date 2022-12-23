CREATE PROCEDURE click.usp_d_currency()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_currency t
    SET
        curr_key = s.curr_key,
        iso_curr_code = s.iso_curr_code,
        serial_no = s.serial_no,
        ctimestamp = s.ctimestamp,
        num_curr_code = s.num_curr_code,
        curr_symbol = s.curr_symbol,
        curr_desc = s.curr_desc,
        curr_sub_units = s.curr_sub_units,
        curr_sub_unit_desc = s.curr_sub_unit_desc,
        curr_units = s.curr_units,
        currency_status = s.currency_status,
        curr_symbol_flag = s.curr_symbol_flag,
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
    FROM dwh.d_currency s
    WHERE t.iso_curr_code = s.iso_curr_code
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_currency(curr_key, iso_curr_code, serial_no, ctimestamp, num_curr_code, curr_symbol, curr_desc, curr_sub_units, curr_sub_unit_desc, curr_units, currency_status, curr_symbol_flag, effective_from, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.curr_key, s.iso_curr_code, s.serial_no, s.ctimestamp, s.num_curr_code, s.curr_symbol, s.curr_desc, s.curr_sub_units, s.curr_sub_unit_desc, s.curr_units, s.currency_status, s.curr_symbol_flag, s.effective_from, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_currency s
    LEFT JOIN click.d_currency t
    ON t.iso_curr_code = s.iso_curr_code
    AND t.serial_no = s.serial_no
    WHERE t.iso_curr_code IS NULL;
END;
$$;