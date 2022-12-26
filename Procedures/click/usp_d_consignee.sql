CREATE OR REPLACE PROCEDURE click.usp_d_consignee()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_consignee t
    SET
        consignee_hdr_key = s.consignee_hdr_key,
        consignee_id = s.consignee_id,
        consignee_ou = s.consignee_ou,
        consignee_desc = s.consignee_desc,
        consignee_status = s.consignee_status,
        consignee_currency = s.consignee_currency,
        consignee_address1 = s.consignee_address1,
        consignee_address2 = s.consignee_address2,
        consignee_city = s.consignee_city,
        consignee_state = s.consignee_state,
        consignee_country = s.consignee_country,
        consignee_postalcode = s.consignee_postalcode,
        consignee_phone1 = s.consignee_phone1,
        consignee_customer_id = s.consignee_customer_id,
        consignee_created_by = s.consignee_created_by,
        consignee_created_date = s.consignee_created_date,
        consignee_modified_by = s.consignee_modified_by,
        consignee_modified_date = s.consignee_modified_date,
        consignee_timestamp = s.consignee_timestamp,
        consignee_zone = s.consignee_zone,
        consignee_timezone = s.consignee_timezone,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_consignee s
    WHERE t.consignee_id = s.consignee_id
    AND t.consignee_ou = s.consignee_ou;

    INSERT INTO click.d_consignee(consignee_hdr_key, consignee_id, consignee_ou, consignee_desc, consignee_status, consignee_currency, consignee_address1, consignee_address2, consignee_city, consignee_state, consignee_country, consignee_postalcode, consignee_phone1, consignee_customer_id, consignee_created_by, consignee_created_date, consignee_modified_by, consignee_modified_date, consignee_timestamp, consignee_zone, consignee_timezone, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.consignee_hdr_key, s.consignee_id, s.consignee_ou, s.consignee_desc, s.consignee_status, s.consignee_currency, s.consignee_address1, s.consignee_address2, s.consignee_city, s.consignee_state, s.consignee_country, s.consignee_postalcode, s.consignee_phone1, s.consignee_customer_id, s.consignee_created_by, s.consignee_created_date, s.consignee_modified_by, s.consignee_modified_date, s.consignee_timestamp, s.consignee_zone, s.consignee_timezone, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_consignee s
    LEFT JOIN click.d_consignee t
    ON t.consignee_id = s.consignee_id
    AND t.consignee_ou = s.consignee_ou
    WHERE t.consignee_id IS NULL;
END;
$$;