CREATE OR REPLACE PROCEDURE click.usp_d_uomconversion()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_uomconversion t
    SET
        uom_con_key = s.uom_con_key,
        con_ouinstance = s.con_ouinstance,
        con_fromuomcode = s.con_fromuomcode,
        con_touomcode = s.con_touomcode,
        con_confact_ntr = s.con_confact_ntr,
        con_confact_dtr = s.con_confact_dtr,
        con_created_by = s.con_created_by,
        con_created_date = s.con_created_date,
        con_modified_by = s.con_modified_by,
        con_modified_date = s.con_modified_date,
        con_flag = s.con_flag,
        con_convert_type = s.con_convert_type,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_uomconversion s
    WHERE t.con_fromuomcode = s.con_fromuomcode
    AND t.con_touomcode = s.con_touomcode;

    INSERT INTO click.d_uomconversion(uom_con_key, con_ouinstance, con_fromuomcode, con_touomcode, con_confact_ntr, con_confact_dtr, con_created_by, con_created_date, con_modified_by, con_modified_date, con_flag, con_convert_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.uom_con_key, s.con_ouinstance, s.con_fromuomcode, s.con_touomcode, s.con_confact_ntr, s.con_confact_dtr, s.con_created_by, s.con_created_date, s.con_modified_by, s.con_modified_date, s.con_flag, s.con_convert_type, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_uomconversion s
    LEFT JOIN click.d_uomconversion t
    ON t.con_fromuomcode = s.con_fromuomcode
    AND t.con_touomcode = s.con_touomcode
    WHERE t.con_ouinstance IS NULL;
END;
$$;