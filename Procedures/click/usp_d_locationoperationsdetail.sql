CREATE OR REPLACE PROCEDURE click.usp_d_locationoperationsdetail()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_locationoperationsdetail t
    SET
        loc_opr_dtl_key = s.loc_opr_dtl_key,
        loc_opr_loc_code = s.loc_opr_loc_code,
        loc_opr_ou = s.loc_opr_ou,
        loc_opr_shift_code = s.loc_opr_shift_code,
        loc_opr_lineno = s.loc_opr_lineno,
        loc_opr_sun_day = s.loc_opr_sun_day,
        loc_opr_mon_day = s.loc_opr_mon_day,
        loc_opr_tue_day = s.loc_opr_tue_day,
        loc_opr_wed_day = s.loc_opr_wed_day,
        loc_opr_thu_day = s.loc_opr_thu_day,
        loc_opr_fri_day = s.loc_opr_fri_day,
        loc_opr_sat_day = s.loc_opr_sat_day,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_locationoperationsdetail s
    WHERE t.loc_opr_loc_code = s.loc_opr_loc_code
    AND t.loc_opr_ou = s.loc_opr_ou
    AND t.loc_opr_lineno = s.loc_opr_lineno;

    INSERT INTO click.d_locationoperationsdetail(loc_opr_dtl_key, loc_opr_loc_code, loc_opr_ou, loc_opr_shift_code, loc_opr_lineno, loc_opr_sun_day, loc_opr_mon_day, loc_opr_tue_day, loc_opr_wed_day, loc_opr_thu_day, loc_opr_fri_day, loc_opr_sat_day, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.loc_opr_dtl_key, s.loc_opr_loc_code, s.loc_opr_ou, s.loc_opr_shift_code, s.loc_opr_lineno, s.loc_opr_sun_day, s.loc_opr_mon_day, s.loc_opr_tue_day, s.loc_opr_wed_day, s.loc_opr_thu_day, s.loc_opr_fri_day, s.loc_opr_sat_day, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_locationoperationsdetail s
    LEFT JOIN click.d_locationoperationsdetail t
    ON t.loc_opr_loc_code = s.loc_opr_loc_code
    AND t.loc_opr_ou = s.loc_opr_ou
    AND t.loc_opr_lineno = s.loc_opr_lineno
    WHERE t.loc_opr_loc_code IS NULL;
END;
$$;