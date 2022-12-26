CREATE OR REPLACE PROCEDURE click.usp_d_shippingpoint()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_shippingpoint t
    SET
        shp_pt_key = s.shp_pt_key,
        shp_pt_ou = s.shp_pt_ou,
        shp_pt_id = s.shp_pt_id,
        shp_pt_desc = s.shp_pt_desc,
        shp_pt_status = s.shp_pt_status,
        shp_pt_rsn_code = s.shp_pt_rsn_code,
        shp_pt_address1 = s.shp_pt_address1,
        shp_pt_address2 = s.shp_pt_address2,
        shp_pt_zipcode = s.shp_pt_zipcode,
        shp_pt_city = s.shp_pt_city,
        shp_pt_state = s.shp_pt_state,
        shp_pt_country = s.shp_pt_country,
        shp_pt_email = s.shp_pt_email,
        shp_pt_timestamp = s.shp_pt_timestamp,
        shp_pt_created_by = s.shp_pt_created_by,
        shp_pt_created_date = s.shp_pt_created_date,
        shp_pt_modified_by = s.shp_pt_modified_by,
        shp_pt_modified_date = s.shp_pt_modified_date,
        shp_pt_address3 = s.shp_pt_address3,
        shp_pt_contact_person = s.shp_pt_contact_person,
        shp_pt_fax = s.shp_pt_fax,
        shp_pt_latitude = s.shp_pt_latitude,
        shp_pt_longitude = s.shp_pt_longitude,
        shp_pt_phone1 = s.shp_pt_phone1,
        shp_pt_phone2 = s.shp_pt_phone2,
        shp_pt_region = s.shp_pt_region,
        shp_pt_zone = s.shp_pt_zone,
        shp_pt_sub_zone = s.shp_pt_sub_zone,
        shp_pt_time_zone = s.shp_pt_time_zone,
        shp_pt_url = s.shp_pt_url,
        shp_pt_suburb_code = s.shp_pt_suburb_code,
        shp_pt_time_slot = s.shp_pt_time_slot,
        shp_pt_time_slot_uom = s.shp_pt_time_slot_uom,
        shp_pt_wh = s.shp_pt_wh,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_shippingpoint s
    WHERE t.shp_pt_ou = s.shp_pt_ou
    AND t.shp_pt_id = s.shp_pt_id;

    INSERT INTO click.d_shippingpoint(shp_pt_key, shp_pt_ou, shp_pt_id, shp_pt_desc, shp_pt_status, shp_pt_rsn_code, shp_pt_address1, shp_pt_address2, shp_pt_zipcode, shp_pt_city, shp_pt_state, shp_pt_country, shp_pt_email, shp_pt_timestamp, shp_pt_created_by, shp_pt_created_date, shp_pt_modified_by, shp_pt_modified_date, shp_pt_address3, shp_pt_contact_person, shp_pt_fax, shp_pt_latitude, shp_pt_longitude, shp_pt_phone1, shp_pt_phone2, shp_pt_region, shp_pt_zone, shp_pt_sub_zone, shp_pt_time_zone, shp_pt_url, shp_pt_suburb_code, shp_pt_time_slot, shp_pt_time_slot_uom, shp_pt_wh, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.shp_pt_key, s.shp_pt_ou, s.shp_pt_id, s.shp_pt_desc, s.shp_pt_status, s.shp_pt_rsn_code, s.shp_pt_address1, s.shp_pt_address2, s.shp_pt_zipcode, s.shp_pt_city, s.shp_pt_state, s.shp_pt_country, s.shp_pt_email, s.shp_pt_timestamp, s.shp_pt_created_by, s.shp_pt_created_date, s.shp_pt_modified_by, s.shp_pt_modified_date, s.shp_pt_address3, s.shp_pt_contact_person, s.shp_pt_fax, s.shp_pt_latitude, s.shp_pt_longitude, s.shp_pt_phone1, s.shp_pt_phone2, s.shp_pt_region, s.shp_pt_zone, s.shp_pt_sub_zone, s.shp_pt_time_zone, s.shp_pt_url, s.shp_pt_suburb_code, s.shp_pt_time_slot, s.shp_pt_time_slot_uom, s.shp_pt_wh, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_shippingpoint s
    LEFT JOIN click.d_shippingpoint t
    ON t.shp_pt_ou = s.shp_pt_ou
    AND t.shp_pt_id = s.shp_pt_id
    WHERE t.shp_pt_ou IS NULL;
END;
$$;