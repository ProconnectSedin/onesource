CREATE OR REPLACE PROCEDURE click.usp_d_customerlocation()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerlocation t
    SET
        loc_cust_key = s.loc_cust_key,
        loc_ou = s.loc_ou,
        loc_code = s.loc_code,
        loc_lineno = s.loc_lineno,
        loc_cust_code = s.loc_cust_code,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerlocation s
    WHERE t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_lineno = s.loc_lineno;

    INSERT INTO click.d_customerlocation(loc_cust_key, loc_ou, loc_code, loc_lineno, loc_cust_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_cust_key, s.loc_ou, s.loc_code, s.loc_lineno, s.loc_cust_code, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerlocation s
    LEFT JOIN click.d_customerlocation t
    ON t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_lineno = s.loc_lineno
    WHERE t.loc_ou IS NULL;
END;
$$;