CREATE OR REPLACE PROCEDURE click.usp_d_vendor()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_vendor t
    SET
        vendor_key = s.vendor_key,
        vendor_id = s.vendor_id,
        vendor_ou = s.vendor_ou,
        vendor_status = s.vendor_status,
        vendor_name = s.vendor_name,
        vendor_payterm = s.vendor_payterm,
        vendor_reason_code = s.vendor_reason_code,
        vendor_classifcation = s.vendor_classifcation,
        vendor_currency = s.vendor_currency,
        vendor_for_self = s.vendor_for_self,
        vendor_created_by = s.vendor_created_by,
        vendor_created_date = s.vendor_created_date,
        vendor_modified_by = s.vendor_modified_by,
        vendor_modified_date = s.vendor_modified_date,
        vendor_timestamp = s.vendor_timestamp,
        vendor_address1 = s.vendor_address1,
        vendor_address2 = s.vendor_address2,
        vendor_address3 = s.vendor_address3,
        vendor_city = s.vendor_city,
        vendor_state = s.vendor_state,
        vendor_country = s.vendor_country,
        vendor_phone1 = s.vendor_phone1,
        vendor_phone2 = s.vendor_phone2,
        vendor_email = s.vendor_email,
        vendor_fax = s.vendor_fax,
        vendor_url = s.vendor_url,
        vendor_subzone = s.vendor_subzone,
        vendor_timezone = s.vendor_timezone,
        vendor_zone = s.vendor_zone,
        vendor_region = s.vendor_region,
        vendor_postal_code = s.vendor_postal_code,
        vendor_agnt_reg = s.vendor_agnt_reg,
        vendor_agnt_cha = s.vendor_agnt_cha,
        vendor_carrier_road = s.vendor_carrier_road,
        vendor_carrier_rail = s.vendor_carrier_rail,
        vendor_carrier_air = s.vendor_carrier_air,
        vendor_carrier_sea = s.vendor_carrier_sea,
        vendor_sub_cntrct_veh = s.vendor_sub_cntrct_veh,
        vendor_sub_cntrct_emp = s.vendor_sub_cntrct_emp,
        vendor_lat = s.vendor_lat,
        vendor_long = s.vendor_long,
        vendor_reg = s.vendor_reg,
        vendor_dept = s.vendor_dept,
        vendor_ln_business = s.vendor_ln_business,
        vendor_rcti = s.vendor_rcti,
        vendor_gen_from = s.vendor_gen_from,
        vendor_group = s.vendor_group,
        vendor_std_contract = s.vendor_std_contract,
        vendor_final_bill_stage = s.vendor_final_bill_stage,
        vendor_allwdb_billto = s.vendor_allwdb_billto,
        vendor_insrnc_prvdr = s.vendor_insrnc_prvdr,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_vendor s
    WHERE t.vendor_id = s.vendor_id
    AND t.vendor_ou = s.vendor_ou;

    INSERT INTO click.d_vendor(vendor_key, vendor_id, vendor_ou, vendor_status, vendor_name, vendor_payterm, vendor_reason_code, vendor_classifcation, vendor_currency, vendor_for_self, vendor_created_by, vendor_created_date, vendor_modified_by, vendor_modified_date, vendor_timestamp, vendor_address1, vendor_address2, vendor_address3, vendor_city, vendor_state, vendor_country, vendor_phone1, vendor_phone2, vendor_email, vendor_fax, vendor_url, vendor_subzone, vendor_timezone, vendor_zone, vendor_region, vendor_postal_code, vendor_agnt_reg, vendor_agnt_cha, vendor_carrier_road, vendor_carrier_rail, vendor_carrier_air, vendor_carrier_sea, vendor_sub_cntrct_veh, vendor_sub_cntrct_emp, vendor_lat, vendor_long, vendor_reg, vendor_dept, vendor_ln_business, vendor_rcti, vendor_gen_from, vendor_group, vendor_std_contract, vendor_final_bill_stage, vendor_allwdb_billto, vendor_insrnc_prvdr, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.vendor_key, s.vendor_id, s.vendor_ou, s.vendor_status, s.vendor_name, s.vendor_payterm, s.vendor_reason_code, s.vendor_classifcation, s.vendor_currency, s.vendor_for_self, s.vendor_created_by, s.vendor_created_date, s.vendor_modified_by, s.vendor_modified_date, s.vendor_timestamp, s.vendor_address1, s.vendor_address2, s.vendor_address3, s.vendor_city, s.vendor_state, s.vendor_country, s.vendor_phone1, s.vendor_phone2, s.vendor_email, s.vendor_fax, s.vendor_url, s.vendor_subzone, s.vendor_timezone, s.vendor_zone, s.vendor_region, s.vendor_postal_code, s.vendor_agnt_reg, s.vendor_agnt_cha, s.vendor_carrier_road, s.vendor_carrier_rail, s.vendor_carrier_air, s.vendor_carrier_sea, s.vendor_sub_cntrct_veh, s.vendor_sub_cntrct_emp, s.vendor_lat, s.vendor_long, s.vendor_reg, s.vendor_dept, s.vendor_ln_business, s.vendor_rcti, s.vendor_gen_from, s.vendor_group, s.vendor_std_contract, s.vendor_final_bill_stage, s.vendor_allwdb_billto, s.vendor_insrnc_prvdr, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_vendor s
    LEFT JOIN click.d_vendor t
    ON t.vendor_id = s.vendor_id
    AND t.vendor_ou = s.vendor_ou
    WHERE t.vendor_id IS NULL;
END;
$$;