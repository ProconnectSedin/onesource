CREATE OR REPLACE PROCEDURE click.usp_d_address()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_address t
    SET
        address_key = s.address_key,
        address_id = s.address_id,
        atimestamp = s.atimestamp,
        address1 = s.address1,
        address2 = s.address2,
        address3 = s.address3,
        address_desc = s.address_desc,
        city = s.city,
        state = s.state,
        country = s.country,
        phone_no = s.phone_no,
        url = s.url,
        zip_code = s.zip_code,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        state_code = s.state_code,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_address s
    WHERE t.address_id = s.address_id;

    INSERT INTO click.d_address(address_key, address_id, atimestamp, address1, address2, address3, address_desc, city, state, country, phone_no, url, zip_code, createdby, createddate, modifiedby, modifieddate, state_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.address_key, s.address_id, s.atimestamp, s.address1, s.address2, s.address3, s.address_desc, s.city, s.state, s.country, s.phone_no, s.url, s.zip_code, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.state_code, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_address s
    LEFT JOIN click.d_address t
    ON t.address_id = s.address_id
    WHERE t.address_id IS NULL;
END;
$$;