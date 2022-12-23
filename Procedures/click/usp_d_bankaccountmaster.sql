CREATE PROCEDURE click.usp_d_bankaccountmaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bankaccountmaster t
    SET
        bank_acc_mst_key = s.bank_acc_mst_key,
        company_code = s.company_code,
        bank_ref_no = s.bank_ref_no,
        bank_acc_no = s.bank_acc_no,
        serial_no = s.serial_no,
        btimestamp = s.btimestamp,
        flag = s.flag,
        currency_code = s.currency_code,
        credit_limit = s.credit_limit,
        draw_limit = s.draw_limit,
        status = s.status,
        effective_from = s.effective_from,
        creation_ou = s.creation_ou,
        createdby = s.createdby,
        createddate = s.createddate,
        acctrf = s.acctrf,
        neft = s.neft,
        rtgs = s.rtgs,
        restpostingaftrrecon = s.restpostingaftrrecon,
        echeq = s.echeq,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_bankaccountmaster s
    WHERE t.company_code = s.company_code
    AND t.bank_ref_no = s.bank_ref_no
    AND t.bank_acc_no = s.bank_acc_no
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_bankaccountmaster(bank_acc_mst_key, company_code, bank_ref_no, bank_acc_no, serial_no, btimestamp, flag, currency_code, credit_limit, draw_limit, status, effective_from, creation_ou, createdby, createddate, acctrf, neft, rtgs, restpostingaftrrecon, echeq, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bank_acc_mst_key, s.company_code, s.bank_ref_no, s.bank_acc_no, s.serial_no, s.btimestamp, s.flag, s.currency_code, s.credit_limit, s.draw_limit, s.status, s.effective_from, s.creation_ou, s.createdby, s.createddate, s.acctrf, s.neft, s.rtgs, s.restpostingaftrrecon, s.echeq, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bankaccountmaster s
    LEFT JOIN click.d_bankaccountmaster t
    ON t.company_code = s.company_code
    AND t.bank_ref_no = s.bank_ref_no
    AND t.bank_acc_no = s.bank_acc_no
    AND t.serial_no = s.serial_no
    WHERE t.company_code IS NULL;
	--and t.bank_acc_mst_key <> -1;
END;
$$;