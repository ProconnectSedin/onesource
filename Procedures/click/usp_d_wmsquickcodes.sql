CREATE PROCEDURE click.usp_d_wmsquickcodes()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_wmsquickcodes t
    SET
        code_key = s.code_key,
        code_ou = s.code_ou,
        code_type = s.code_type,
        code = s.code,
        code_desc = s.code_desc,
        code_default = s.code_default,
        seq_no = s.seq_no,
        status = s.status,
        category = s.category,
        user_flag = s.user_flag,
        code_timestamp = s.code_timestamp,
        langid = s.langid,
        created_date = s.created_date,
        created_by = s.created_by,
        modified_date = s.modified_date,
        modified_by = s.modified_by,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_wmsquickcodes s
    WHERE t.code_ou = s.code_ou
    AND t.code_type = s.code_type
    AND t.code = s.code;

    INSERT INTO click.d_wmsquickcodes(code_key, code_ou, code_type, code, code_desc, code_default, seq_no, status, category, user_flag, code_timestamp, langid, created_date, created_by, modified_date, modified_by, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.code_key, s.code_ou, s.code_type, s.code, s.code_desc, s.code_default, s.seq_no, s.status, s.category, s.user_flag, s.code_timestamp, s.langid, s.created_date, s.created_by, s.modified_date, s.modified_by, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_wmsquickcodes s
    LEFT JOIN click.d_wmsquickcodes t
    ON t.code_ou = s.code_ou
    AND t.code_type = s.code_type
    AND t.code = s.code
    WHERE t.code_ou IS NULL;
END;
$$;