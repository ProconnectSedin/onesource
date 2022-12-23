CREATE PROCEDURE click.usp_d_warehouse()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_warehouse t
    SET
        wh_key = s.wh_key,
        wh_code = s.wh_code,
        wh_ou = s.wh_ou,
        wh_desc = s.wh_desc,
        wh_status = s.wh_status,
        wh_desc_shdw = s.wh_desc_shdw,
        wh_storage_type = s.wh_storage_type,
        nettable = s.nettable,
        finance_book = s.finance_book,
        allocation_method = s.allocation_method,
        site_code = s.site_code,
        address1 = s.address1,
        capital_warehouse = s.capital_warehouse,
        address2 = s.address2,
        city = s.city,
        all_trans_allowed = s.all_trans_allowed,
        state = s.state,
        all_itemtypes_allowed = s.all_itemtypes_allowed,
        zip_code = s.zip_code,
        all_stk_status_allowed = s.all_stk_status_allowed,
        country = s.country,
        created_by = s.created_by,
        created_dt = s.created_dt,
        modified_by = s.modified_by,
        modified_dt = s.modified_dt,
        timestamp_value = s.timestamp_value,
        tran_type = s.tran_type,
        bonded_yn = s.bonded_yn,
        location_code = s.location_code,
        location_desc = s.location_desc,
        address3 = s.address3,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_warehouse s
    WHERE t.wh_code = s.wh_code
    AND t.wh_ou = s.wh_ou;

    INSERT INTO click.d_warehouse(wh_key, wh_code, wh_ou, wh_desc, wh_status, wh_desc_shdw, wh_storage_type, nettable, finance_book, allocation_method, site_code, address1, capital_warehouse, address2, city, all_trans_allowed, state, all_itemtypes_allowed, zip_code, all_stk_status_allowed, country, created_by, created_dt, modified_by, modified_dt, timestamp_value, tran_type, bonded_yn, location_code, location_desc, address3, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.wh_key, s.wh_code, s.wh_ou, s.wh_desc, s.wh_status, s.wh_desc_shdw, s.wh_storage_type, s.nettable, s.finance_book, s.allocation_method, s.site_code, s.address1, s.capital_warehouse, s.address2, s.city, s.all_trans_allowed, s.state, s.all_itemtypes_allowed, s.zip_code, s.all_stk_status_allowed, s.country, s.created_by, s.created_dt, s.modified_by, s.modified_dt, s.timestamp_value, s.tran_type, s.bonded_yn, s.location_code, s.location_desc, s.address3, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_warehouse s
    LEFT JOIN click.d_warehouse t
    ON t.wh_code = s.wh_code
    AND t.wh_ou = s.wh_ou
    WHERE t.wh_code IS NULL;
END;
$$;