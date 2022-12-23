CREATE PROCEDURE click.usp_d_consignor()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_consignor t
    SET
        consignor_key = s.consignor_key,
        consignor_id = s.consignor_id,
        consignor_ou = s.consignor_ou,
        consignor_desc = s.consignor_desc,
        consignor_status = s.consignor_status,
        consignor_currency = s.consignor_currency,
        consignor_address1 = s.consignor_address1,
        consignor_address2 = s.consignor_address2,
        consignor_address3 = s.consignor_address3,
        consignor_city = s.consignor_city,
        consignor_state = s.consignor_state,
        consignor_country = s.consignor_country,
        consignor_postalcode = s.consignor_postalcode,
        consignor_phone1 = s.consignor_phone1,
        consignor_customer_id = s.consignor_customer_id,
        consignor_created_by = s.consignor_created_by,
        consignor_created_date = s.consignor_created_date,
        consignor_modified_by = s.consignor_modified_by,
        consignor_modified_date = s.consignor_modified_date,
        consignor_timestamp = s.consignor_timestamp,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_consignor s
    WHERE t.consignor_id = s.consignor_id
    AND t.consignor_ou = s.consignor_ou;

    INSERT INTO click.d_consignor(consignor_key, consignor_id, consignor_ou, consignor_desc, consignor_status, consignor_currency, consignor_address1, consignor_address2, consignor_address3, consignor_city, consignor_state, consignor_country, consignor_postalcode, consignor_phone1, consignor_customer_id, consignor_created_by, consignor_created_date, consignor_modified_by, consignor_modified_date, consignor_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.consignor_key, s.consignor_id, s.consignor_ou, s.consignor_desc, s.consignor_status, s.consignor_currency, s.consignor_address1, s.consignor_address2, s.consignor_address3, s.consignor_city, s.consignor_state, s.consignor_country, s.consignor_postalcode, s.consignor_phone1, s.consignor_customer_id, s.consignor_created_by, s.consignor_created_date, s.consignor_modified_by, s.consignor_modified_date, s.consignor_timestamp, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_consignor s
    LEFT JOIN click.d_consignor t
    ON t.consignor_id = s.consignor_id
    AND t.consignor_ou = s.consignor_ou
    WHERE t.consignor_id IS NULL;
END;
$$;