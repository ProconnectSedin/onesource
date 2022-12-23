CREATE PROCEDURE click.usp_d_customerouinfo()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerouinfo t
    SET
        cou_key = s.cou_key,
        cou_lo = s.cou_lo,
        cou_bu = s.cou_bu,
        cou_ou = s.cou_ou,
        cou_cust_code = s.cou_cust_code,
        cou_dflt_billto_id = s.cou_dflt_billto_id,
        cou_dflt_shipto_id = s.cou_dflt_shipto_id,
        cou_order_from_id = s.cou_order_from_id,
        cou_dflt_billto_cust = s.cou_dflt_billto_cust,
        cou_dflt_shipto_cust = s.cou_dflt_shipto_cust,
        cou_dflt_pricelist = s.cou_dflt_pricelist,
        cou_dflt_ship_pt = s.cou_dflt_ship_pt,
        cou_language = s.cou_language,
        cou_transport_mode = s.cou_transport_mode,
        cou_sales_chnl = s.cou_sales_chnl,
        cou_order_type = s.cou_order_type,
        cou_process_actn = s.cou_process_actn,
        cou_partshp_flag = s.cou_partshp_flag,
        cou_freight_term = s.cou_freight_term,
        cou_prfrd_carrier = s.cou_prfrd_carrier,
        cou_secstk_flag = s.cou_secstk_flag,
        cou_cons_sales = s.cou_cons_sales,
        cou_cons_bill = s.cou_cons_bill,
        cou_trnshp_flag = s.cou_trnshp_flag,
        cou_inv_appl_flag = s.cou_inv_appl_flag,
        cou_auto_invauth_flag = s.cou_auto_invauth_flag,
        cou_frtbillable_flag = s.cou_frtbillable_flag,
        cou_no_of_invcopies = s.cou_no_of_invcopies,
        cou_elgble_for_rebate = s.cou_elgble_for_rebate,
        cou_reason_code = s.cou_reason_code,
        cou_cr_status = s.cou_cr_status,
        cou_status = s.cou_status,
        cou_prev_status = s.cou_prev_status,
        cou_created_by = s.cou_created_by,
        cou_created_date = s.cou_created_date,
        cou_modified_by = s.cou_modified_by,
        cou_modified_date = s.cou_modified_date,
        cou_timestamp_value = s.cou_timestamp_value,
        cou_company_code = s.cou_company_code,
        cou_cust_priority = s.cou_cust_priority,
        cou_sales_person = s.cou_sales_person,
        cou_cust_frequency = s.cou_cust_frequency,
        cou_wf_status = s.cou_wf_status,
        cou_revision_no = s.cou_revision_no,
        cou_trade_type = s.cou_trade_type,
        cou_frt_appl = s.cou_frt_appl,
        cou_cust_category = s.cou_cust_category,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerouinfo s
    WHERE t.cou_lo = s.cou_lo
    AND t.cou_bu = s.cou_bu
    AND t.cou_ou = s.cou_ou
    AND t.cou_cust_code = s.cou_cust_code;

    INSERT INTO click.d_customerouinfo(cou_key, cou_lo, cou_bu, cou_ou, cou_cust_code, cou_dflt_billto_id, cou_dflt_shipto_id, cou_order_from_id, cou_dflt_billto_cust, cou_dflt_shipto_cust, cou_dflt_pricelist, cou_dflt_ship_pt, cou_language, cou_transport_mode, cou_sales_chnl, cou_order_type, cou_process_actn, cou_partshp_flag, cou_freight_term, cou_prfrd_carrier, cou_secstk_flag, cou_cons_sales, cou_cons_bill, cou_trnshp_flag, cou_inv_appl_flag, cou_auto_invauth_flag, cou_frtbillable_flag, cou_no_of_invcopies, cou_elgble_for_rebate, cou_reason_code, cou_cr_status, cou_status, cou_prev_status, cou_created_by, cou_created_date, cou_modified_by, cou_modified_date, cou_timestamp_value, cou_company_code, cou_cust_priority, cou_sales_person, cou_cust_frequency, cou_wf_status, cou_revision_no, cou_trade_type, cou_frt_appl, cou_cust_category, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.cou_key, s.cou_lo, s.cou_bu, s.cou_ou, s.cou_cust_code, s.cou_dflt_billto_id, s.cou_dflt_shipto_id, s.cou_order_from_id, s.cou_dflt_billto_cust, s.cou_dflt_shipto_cust, s.cou_dflt_pricelist, s.cou_dflt_ship_pt, s.cou_language, s.cou_transport_mode, s.cou_sales_chnl, s.cou_order_type, s.cou_process_actn, s.cou_partshp_flag, s.cou_freight_term, s.cou_prfrd_carrier, s.cou_secstk_flag, s.cou_cons_sales, s.cou_cons_bill, s.cou_trnshp_flag, s.cou_inv_appl_flag, s.cou_auto_invauth_flag, s.cou_frtbillable_flag, s.cou_no_of_invcopies, s.cou_elgble_for_rebate, s.cou_reason_code, s.cou_cr_status, s.cou_status, s.cou_prev_status, s.cou_created_by, s.cou_created_date, s.cou_modified_by, s.cou_modified_date, s.cou_timestamp_value, s.cou_company_code, s.cou_cust_priority, s.cou_sales_person, s.cou_cust_frequency, s.cou_wf_status, s.cou_revision_no, s.cou_trade_type, s.cou_frt_appl, s.cou_cust_category, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerouinfo s
    LEFT JOIN click.d_customerouinfo t
    ON t.cou_lo = s.cou_lo
    AND t.cou_bu = s.cou_bu
    AND t.cou_ou = s.cou_ou
    AND t.cou_cust_code = s.cou_cust_code
    WHERE t.cou_lo IS NULL;
END;
$$;