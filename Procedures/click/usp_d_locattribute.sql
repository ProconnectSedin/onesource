CREATE OR REPLACE PROCEDURE click.usp_d_locattribute()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_locattribute t
    SET
        loc_attr_key = s.loc_attr_key,
        loc_attr_loc_code = s.loc_attr_loc_code,
        loc_attr_lineno = s.loc_attr_lineno,
        loc_attr_ou = s.loc_attr_ou,
        loc_attr_typ = s.loc_attr_typ,
        loc_attr_apl = s.loc_attr_apl,
        loc_attr_value = s.loc_attr_value,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_locattribute s
    WHERE t.loc_attr_loc_code = s.loc_attr_loc_code
    AND t.loc_attr_lineno = s.loc_attr_lineno
    AND t.loc_attr_ou = s.loc_attr_ou;

    INSERT INTO click.d_locattribute(loc_attr_key, loc_attr_loc_code, loc_attr_lineno, loc_attr_ou, loc_attr_typ, loc_attr_apl, loc_attr_value, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_attr_key, s.loc_attr_loc_code, s.loc_attr_lineno, s.loc_attr_ou, s.loc_attr_typ, s.loc_attr_apl, s.loc_attr_value, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_locattribute s
    LEFT JOIN click.d_locattribute t
    ON t.loc_attr_loc_code = s.loc_attr_loc_code
    AND t.loc_attr_lineno = s.loc_attr_lineno
    AND t.loc_attr_ou = s.loc_attr_ou
    WHERE t.loc_attr_loc_code IS NULL;
END;
$$;