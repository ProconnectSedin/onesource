CREATE OR REPLACE PROCEDURE click.usp_d_customer()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customer t
    SET
        customer_key = s.customer_key,
        customer_id = s.customer_id,
        customer_ou = s.customer_ou,
        customer_name = s.customer_name,
        customer_status = s.customer_status,
        customer_type = s.customer_type,
        customer_description = s.customer_description,
        customer_credit_term = s.customer_credit_term,
        customer_pay_term = s.customer_pay_term,
        customer_currency = s.customer_currency,
        customer_reason_code = s.customer_reason_code,
        customer_address1 = s.customer_address1,
        customer_address2 = s.customer_address2,
        customer_address3 = s.customer_address3,
        customer_city = s.customer_city,
        customer_state = s.customer_state,
        customer_country = s.customer_country,
        customer_postal_code = s.customer_postal_code,
        customer_timezone = s.customer_timezone,
        customer_contact_person = s.customer_contact_person,
        customer_phone1 = s.customer_phone1,
        customer_phone2 = s.customer_phone2,
        customer_fax = s.customer_fax,
        customer_email = s.customer_email,
        customer_bill_same_as_customer = s.customer_bill_same_as_customer,
        customer_bill_address1 = s.customer_bill_address1,
        customer_bill_address2 = s.customer_bill_address2,
        customer_bill_address3 = s.customer_bill_address3,
        customer_bill_city = s.customer_bill_city,
        customer_bill_state = s.customer_bill_state,
        customer_bill_country = s.customer_bill_country,
        customer_bill_postal_code = s.customer_bill_postal_code,
        customer_bill_contact_person = s.customer_bill_contact_person,
        customer_bill_phone = s.customer_bill_phone,
        customer_bill_fax = s.customer_bill_fax,
        customer_ret_undelivered = s.customer_ret_undelivered,
        customer_ret_same_as_customer = s.customer_ret_same_as_customer,
        customer_ret_address1 = s.customer_ret_address1,
        customer_ret_address2 = s.customer_ret_address2,
        customer_ret_address3 = s.customer_ret_address3,
        customer_ret_city = s.customer_ret_city,
        customer_ret_state = s.customer_ret_state,
        customer_ret_country = s.customer_ret_country,
        customer_ret_postal_code = s.customer_ret_postal_code,
        customer_ret_contact_person = s.customer_ret_contact_person,
        customer_ret_phone1 = s.customer_ret_phone1,
        customer_ret_fax = s.customer_ret_fax,
        customer_timestamp = s.customer_timestamp,
        customer_created_by = s.customer_created_by,
        customer_created_dt = s.customer_created_dt,
        customer_modified_by = s.customer_modified_by,
        customer_modified_dt = s.customer_modified_dt,
        customer_br_valid_prof_id = s.customer_br_valid_prof_id,
        customer_payment_typ = s.customer_payment_typ,
        customer_geo_fence = s.customer_geo_fence,
        customer_bill_geo_fence = s.customer_bill_geo_fence,
        customer_bill_longtitude = s.customer_bill_longtitude,
        customer_bill_latitude = s.customer_bill_latitude,
        customer_bill_zone = s.customer_bill_zone,
        customer_bill_sub_zone = s.customer_bill_sub_zone,
        customer_bill_region = s.customer_bill_region,
        customer_ret_geo_fence = s.customer_ret_geo_fence,
        customer_ret_longtitude = s.customer_ret_longtitude,
        customer_ret_latitude = s.customer_ret_latitude,
        customer_customer_grp = s.customer_customer_grp,
        customer_industry_typ = s.customer_industry_typ,
        allow_rev_protection = s.allow_rev_protection,
        customer_invrep = s.customer_invrep,
        customer_rcti = s.customer_rcti,
        customer_gen_from = s.customer_gen_from,
        customer_bill_hrchy1 = s.customer_bill_hrchy1,
        customer_new_customer = s.customer_new_customer,
        customer_final_bill_stage = s.customer_final_bill_stage,
        customer_allwdb_billto = s.customer_allwdb_billto,
        customer_contact_person2 = s.customer_contact_person2,
        cus_contact_person2_email = s.cus_contact_person2_email,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customer s
    WHERE t.customer_id = s.customer_id
    AND t.customer_ou = s.customer_ou;

    INSERT INTO click.d_customer(customer_key, customer_id, customer_ou, customer_name, customer_status, customer_type, customer_description, customer_credit_term, customer_pay_term, customer_currency, customer_reason_code, customer_address1, customer_address2, customer_address3, customer_city, customer_state, customer_country, customer_postal_code, customer_timezone, customer_contact_person, customer_phone1, customer_phone2, customer_fax, customer_email, customer_bill_same_as_customer, customer_bill_address1, customer_bill_address2, customer_bill_address3, customer_bill_city, customer_bill_state, customer_bill_country, customer_bill_postal_code, customer_bill_contact_person, customer_bill_phone, customer_bill_fax, customer_ret_undelivered, customer_ret_same_as_customer, customer_ret_address1, customer_ret_address2, customer_ret_address3, customer_ret_city, customer_ret_state, customer_ret_country, customer_ret_postal_code, customer_ret_contact_person, customer_ret_phone1, customer_ret_fax, customer_timestamp, customer_created_by, customer_created_dt, customer_modified_by, customer_modified_dt, customer_br_valid_prof_id, customer_payment_typ, customer_geo_fence, customer_bill_geo_fence, customer_bill_longtitude, customer_bill_latitude, customer_bill_zone, customer_bill_sub_zone, customer_bill_region, customer_ret_geo_fence, customer_ret_longtitude, customer_ret_latitude, customer_customer_grp, customer_industry_typ, allow_rev_protection, customer_invrep, customer_rcti, customer_gen_from, customer_bill_hrchy1, customer_new_customer, customer_final_bill_stage, customer_allwdb_billto, customer_contact_person2, cus_contact_person2_email, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.customer_key, s.customer_id, s.customer_ou, s.customer_name, s.customer_status, s.customer_type, s.customer_description, s.customer_credit_term, s.customer_pay_term, s.customer_currency, s.customer_reason_code, s.customer_address1, s.customer_address2, s.customer_address3, s.customer_city, s.customer_state, s.customer_country, s.customer_postal_code, s.customer_timezone, s.customer_contact_person, s.customer_phone1, s.customer_phone2, s.customer_fax, s.customer_email, s.customer_bill_same_as_customer, s.customer_bill_address1, s.customer_bill_address2, s.customer_bill_address3, s.customer_bill_city, s.customer_bill_state, s.customer_bill_country, s.customer_bill_postal_code, s.customer_bill_contact_person, s.customer_bill_phone, s.customer_bill_fax, s.customer_ret_undelivered, s.customer_ret_same_as_customer, s.customer_ret_address1, s.customer_ret_address2, s.customer_ret_address3, s.customer_ret_city, s.customer_ret_state, s.customer_ret_country, s.customer_ret_postal_code, s.customer_ret_contact_person, s.customer_ret_phone1, s.customer_ret_fax, s.customer_timestamp, s.customer_created_by, s.customer_created_dt, s.customer_modified_by, s.customer_modified_dt, s.customer_br_valid_prof_id, s.customer_payment_typ, s.customer_geo_fence, s.customer_bill_geo_fence, s.customer_bill_longtitude, s.customer_bill_latitude, s.customer_bill_zone, s.customer_bill_sub_zone, s.customer_bill_region, s.customer_ret_geo_fence, s.customer_ret_longtitude, s.customer_ret_latitude, s.customer_customer_grp, s.customer_industry_typ, s.allow_rev_protection, s.customer_invrep, s.customer_rcti, s.customer_gen_from, s.customer_bill_hrchy1, s.customer_new_customer, s.customer_final_bill_stage, s.customer_allwdb_billto, s.customer_contact_person2, s.cus_contact_person2_email, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customer s
    LEFT JOIN click.d_customer t
    ON t.customer_id = s.customer_id
    AND t.customer_ou = s.customer_ou
    WHERE t.customer_id IS NULL;
END;
$$;