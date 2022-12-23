CREATE PROCEDURE click.usp_d_accountadditionalmaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_accountadditionalmaster t
    SET
        acc_mst_key = s.acc_mst_key,
        company_code = s.company_code,
        fb_id = s.fb_id,
        usage_id = s.usage_id,
        effective_from = s.effective_from,
        currency_code = s.currency_code,
        drcr_flag = s.drcr_flag,
        dest_fbid = s.dest_fbid,
        child_company = s.child_company,
        dest_company = s.dest_company,
        sequence_no = s.sequence_no,
        timestamp = s.timestamp,
        account_code = s.account_code,
        effective_to = s.effective_to,
        resou_id = s.resou_id,
        usage_type = s.usage_type,
        ard_type = s.ard_type,
        flag = s.flag,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_accountadditionalmaster s
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.usage_id = s.usage_id
    AND t.effective_from = s.effective_from
    AND t.currency_code = s.currency_code
    AND t.drcr_flag = s.drcr_flag
    AND t.dest_fbid = s.dest_fbid
    AND t.child_company = s.child_company
    AND t.dest_company = s.dest_company
    AND t.sequence_no = s.sequence_no;

    INSERT INTO click.d_accountadditionalmaster(acc_mst_key, company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no, timestamp, account_code, effective_to, resou_id, usage_type, ard_type, flag, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.acc_mst_key, s.company_code, s.fb_id, s.usage_id, s.effective_from, s.currency_code, s.drcr_flag, s.dest_fbid, s.child_company, s.dest_company, s.sequence_no, s.timestamp, s.account_code, s.effective_to, s.resou_id, s.usage_type, s.ard_type, s.flag, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_accountadditionalmaster s
    LEFT JOIN click.d_accountadditionalmaster t
    ON t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.usage_id = s.usage_id
    AND t.effective_from = s.effective_from
    AND t.currency_code = s.currency_code
    AND t.drcr_flag = s.drcr_flag
    AND t.dest_fbid = s.dest_fbid
    AND t.child_company = s.child_company
    AND t.dest_company = s.dest_company
    AND t.sequence_no = s.sequence_no
    WHERE t.company_code IS NULL;
END;
$$;