CREATE PROCEDURE click.usp_d_bankcashaccountmaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bankcashaccountmaster t
    SET
        d_bank_mst_key = s.d_bank_mst_key,
        company_code = s.company_code,
        fb_id = s.fb_id,
        bank_ptt_code = s.bank_ptt_code,
        effective_from = s.effective_from,
        sequence_no = s.sequence_no,
        timestamp = s.timestamp,
        bankptt_account = s.bankptt_account,
        bankcharge_account = s.bankcharge_account,
        effective_to = s.effective_to,
        resou_id = s.resou_id,
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
    FROM dwh.d_bankcashaccountmaster s
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.bank_ptt_code = s.bank_ptt_code
    AND t.effective_from = s.effective_from
    AND t.sequence_no = s.sequence_no;

    INSERT INTO click.d_bankcashaccountmaster(d_bank_mst_key, company_code, fb_id, bank_ptt_code, effective_from, sequence_no, timestamp, bankptt_account, bankcharge_account, effective_to, resou_id, flag, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_bank_mst_key, s.company_code, s.fb_id, s.bank_ptt_code, s.effective_from, s.sequence_no, s.timestamp, s.bankptt_account, s.bankcharge_account, s.effective_to, s.resou_id, s.flag, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bankcashaccountmaster s
    LEFT JOIN click.d_bankcashaccountmaster t
    ON t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.bank_ptt_code = s.bank_ptt_code
    AND t.effective_from = s.effective_from
    AND t.sequence_no = s.sequence_no
    WHERE t.company_code IS NULL;
END;
$$;