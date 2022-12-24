CREATE OR REPLACE PROCEDURE click.usp_d_financebook()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_financebook t
    SET
        fb_key = s.fb_key,
        fb_id = s.fb_id,
        company_code = s.company_code,
        serial_no = s.serial_no,
        fb_type = s.fb_type,
        ftimestamp = s.ftimestamp,
        fb_desc = s.fb_desc,
        effective_from = s.effective_from,
        status = s.status,
        resou_id = s.resou_id,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_financebook s
    WHERE t.fb_id = s.fb_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no
    AND t.fb_type = s.fb_type;

    INSERT INTO click.d_financebook(fb_key, fb_id, company_code, serial_no, fb_type, ftimestamp, fb_desc, effective_from, status, resou_id, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.fb_key, s.fb_id, s.company_code, s.serial_no, s.fb_type, s.ftimestamp, s.fb_desc, s.effective_from, s.status, s.resou_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_financebook s
    LEFT JOIN click.d_financebook t
    ON t.fb_id = s.fb_id
    AND t.company_code = s.company_code
    AND t.serial_no = s.serial_no
    AND t.fb_type = s.fb_type
    WHERE t.fb_id IS NULL;
END;
$$;