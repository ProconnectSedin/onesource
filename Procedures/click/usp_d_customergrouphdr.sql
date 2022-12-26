CREATE OR REPLACE PROCEDURE click.usp_d_customergrouphdr()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customergrouphdr t
    SET
        cgh_key = s.cgh_key,
        cgh_lo = s.cgh_lo,
        cgh_bu = s.cgh_bu,
        cgh_cust_group_code = s.cgh_cust_group_code,
        cgh_control_group_flag = s.cgh_control_group_flag,
        cgh_group_type_code = s.cgh_group_type_code,
        cgh_created_at = s.cgh_created_at,
        cgh_cust_group_desc = s.cgh_cust_group_desc,
        cgh_cust_group_desc_shd = s.cgh_cust_group_desc_shd,
        cgh_reason_code = s.cgh_reason_code,
        cgh_status = s.cgh_status,
        cgh_prev_status = s.cgh_prev_status,
        cgh_created_by = s.cgh_created_by,
        cgh_created_date = s.cgh_created_date,
        cgh_modified_by = s.cgh_modified_by,
        cgh_modified_date = s.cgh_modified_date,
        cgh_timestamp_value = s.cgh_timestamp_value,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customergrouphdr s
    WHERE t.cgh_lo = s.cgh_lo
    AND t.cgh_cust_group_code = s.cgh_cust_group_code
    AND t.cgh_control_group_flag = s.cgh_control_group_flag
    AND t.cgh_group_type_code = s.cgh_group_type_code;

    INSERT INTO click.d_customergrouphdr(cgh_key, cgh_lo, cgh_bu, cgh_cust_group_code, cgh_control_group_flag, cgh_group_type_code, cgh_created_at, cgh_cust_group_desc, cgh_cust_group_desc_shd, cgh_reason_code, cgh_status, cgh_prev_status, cgh_created_by, cgh_created_date, cgh_modified_by, cgh_modified_date, cgh_timestamp_value, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.cgh_key, s.cgh_lo, s.cgh_bu, s.cgh_cust_group_code, s.cgh_control_group_flag, s.cgh_group_type_code, s.cgh_created_at, s.cgh_cust_group_desc, s.cgh_cust_group_desc_shd, s.cgh_reason_code, s.cgh_status, s.cgh_prev_status, s.cgh_created_by, s.cgh_created_date, s.cgh_modified_by, s.cgh_modified_date, s.cgh_timestamp_value, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customergrouphdr s
    LEFT JOIN click.d_customergrouphdr t
    ON t.cgh_lo = s.cgh_lo
    AND t.cgh_cust_group_code = s.cgh_cust_group_code
    AND t.cgh_control_group_flag = s.cgh_control_group_flag
    AND t.cgh_group_type_code = s.cgh_group_type_code
    WHERE t.cgh_lo IS NULL;
END;
$$;