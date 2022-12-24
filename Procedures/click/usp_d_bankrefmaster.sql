CREATE OR REPLACE PROCEDURE click.usp_d_bankrefmaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bankrefmaster t
    SET
        bank_ref_mst_key = s.bank_ref_mst_key,
        bank_ref_no = s.bank_ref_no,
        bank_status = s.bank_status,
        btimestamp = s.btimestamp,
        bank_ptt_flag = s.bank_ptt_flag,
        bank_type = s.bank_type,
        bank_name = s.bank_name,
        address1 = s.address1,
        address2 = s.address2,
        address3 = s.address3,
        city = s.city,
        state = s.state,
        country = s.country,
        clearing_no = s.clearing_no,
        swift_no = s.swift_no,
        zip_code = s.zip_code,
        creation_ou = s.creation_ou,
        modification_ou = s.modification_ou,
        effective_from = s.effective_from,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        createdin = s.createdin,
        ifsccode = s.ifsccode,
        long_description = s.long_description,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_bankrefmaster s
    WHERE t.bank_ref_no = s.bank_ref_no
    AND t.bank_status = s.bank_status;

    INSERT INTO click.d_bankrefmaster(bank_ref_mst_key, bank_ref_no, bank_status, btimestamp, bank_ptt_flag, bank_type, bank_name, address1, address2, address3, city, state, country, clearing_no, swift_no, zip_code, creation_ou, modification_ou, effective_from, createdby, createddate, modifiedby, modifieddate, createdin, ifsccode, long_description, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bank_ref_mst_key, s.bank_ref_no, s.bank_status, s.btimestamp, s.bank_ptt_flag, s.bank_type, s.bank_name, s.address1, s.address2, s.address3, s.city, s.state, s.country, s.clearing_no, s.swift_no, s.zip_code, s.creation_ou, s.modification_ou, s.effective_from, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.createdin, s.ifsccode, s.long_description, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bankrefmaster s
    LEFT JOIN click.d_bankrefmaster t
    ON t.bank_ref_no = s.bank_ref_no
    AND t.bank_status = s.bank_status
    WHERE t.bank_ref_no IS NULL;
END;
$$;