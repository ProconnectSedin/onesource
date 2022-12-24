CREATE OR REPLACE PROCEDURE click.usp_d_bintypelocation()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_bintypelocation t
    SET
        bin_typ_key = s.bin_typ_key,
        bin_typ_ou = s.bin_typ_ou,
        bin_typ_code = s.bin_typ_code,
        bin_typ_loc_code = s.bin_typ_loc_code,
        bin_typ_lineno = s.bin_typ_lineno,
        bin_typ_storage_unit = s.bin_typ_storage_unit,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_bintypelocation s
    WHERE t.bin_typ_key = s.bin_typ_key;

    INSERT INTO click.d_bintypelocation(bin_typ_key, bin_typ_ou, bin_typ_code, bin_typ_loc_code, bin_typ_lineno, bin_typ_storage_unit, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.bin_typ_key, s.bin_typ_ou, s.bin_typ_code, s.bin_typ_loc_code, s.bin_typ_lineno, s.bin_typ_storage_unit, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_bintypelocation s
    LEFT JOIN click.d_bintypelocation t
    ON t.bin_typ_key = s.bin_typ_key
    WHERE t.bin_typ_ou IS NULL;
END;
$$;