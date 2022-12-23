CREATE PROCEDURE click.usp_d_locationshiftdetails()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_locationshiftdetails t
    SET
        loc_shft_dtl_key = s.loc_shft_dtl_key,
        loc_ou = s.loc_ou,
        loc_code = s.loc_code,
        loc_shft_lineno = s.loc_shft_lineno,
        loc_shft_shift = s.loc_shft_shift,
        loc_shft_fr_time = s.loc_shft_fr_time,
        loc_shft_to_time = s.loc_shft_to_time,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_locationshiftdetails s
    WHERE t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_shft_lineno = s.loc_shft_lineno;

    INSERT INTO click.d_locationshiftdetails(loc_shft_dtl_key, loc_ou, loc_code, loc_shft_lineno, loc_shft_shift, loc_shft_fr_time, loc_shft_to_time, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_shft_dtl_key, s.loc_ou, s.loc_code, s.loc_shft_lineno, s.loc_shft_shift, s.loc_shft_fr_time, s.loc_shft_to_time, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_locationshiftdetails s
    LEFT JOIN click.d_locationshiftdetails t
    ON t.loc_ou = s.loc_ou
    AND t.loc_code = s.loc_code
    AND t.loc_shft_lineno = s.loc_shft_lineno
    WHERE t.loc_ou IS NULL;
END;
$$;