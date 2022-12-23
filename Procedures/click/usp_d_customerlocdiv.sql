CREATE PROCEDURE click.usp_d_customerlocdiv()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerlocdiv t
    SET
        wms_customer_key = s.wms_customer_key,
        wms_customer_id = s.wms_customer_id,
        wms_customer_ou = s.wms_customer_ou,
        wms_customer_lineno = s.wms_customer_lineno,
        wms_customer_type = s.wms_customer_type,
        wms_customer_code = s.wms_customer_code,
        wms_customer_itm_val_contract = s.wms_customer_itm_val_contract,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerlocdiv s
    WHERE t.wms_customer_id = s.wms_customer_id
    AND t.wms_customer_ou = s.wms_customer_ou
    AND t.wms_customer_lineno = s.wms_customer_lineno;

    INSERT INTO click.d_customerlocdiv(wms_customer_key, wms_customer_id, wms_customer_ou, wms_customer_lineno, wms_customer_type, wms_customer_code, wms_customer_itm_val_contract, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.wms_customer_key, s.wms_customer_id, s.wms_customer_ou, s.wms_customer_lineno, s.wms_customer_type, s.wms_customer_code, s.wms_customer_itm_val_contract, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerlocdiv s
    LEFT JOIN click.d_customerlocdiv t
    ON t.wms_customer_id = s.wms_customer_id
    AND t.wms_customer_ou = s.wms_customer_ou
    AND t.wms_customer_lineno = s.wms_customer_lineno
    WHERE t.wms_customer_id IS NULL;
END;
$$;