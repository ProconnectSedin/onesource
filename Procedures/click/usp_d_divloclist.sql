CREATE PROCEDURE click.usp_d_divloclist()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_divloclist t
    SET
        div_loc_key = s.div_loc_key,
        div_ou = s.div_ou,
        div_code = s.div_code,
        div_lineno = s.div_lineno,
        div_loc_code = s.div_loc_code,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_divloclist s
    WHERE t.div_ou = s.div_ou
    AND t.div_code = s.div_code
    AND t.div_lineno = s.div_lineno;

    INSERT INTO click.d_divloclist(div_loc_key, div_ou, div_code, div_lineno, div_loc_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.div_loc_key, s.div_ou, s.div_code, s.div_lineno, s.div_loc_code, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_divloclist s
    LEFT JOIN click.d_divloclist t
    ON t.div_ou = s.div_ou
    AND t.div_code = s.div_code
    AND t.div_lineno = s.div_lineno
    WHERE t.div_ou IS NULL;
END;
$$;