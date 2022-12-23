CREATE PROCEDURE click.usp_d_equipmentgroupdtl()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_equipmentgroupdtl t
    SET
        egrp_key = s.egrp_key,
        egrp_ou = s.egrp_ou,
        egrp_id = s.egrp_id,
        egrp_lineno = s.egrp_lineno,
        egrp_eqp_id = s.egrp_eqp_id,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_equipmentgroupdtl s
    WHERE t.egrp_ou = s.egrp_ou
    AND t.egrp_id = s.egrp_id
    AND t.egrp_lineno = s.egrp_lineno;

    INSERT INTO click.d_equipmentgroupdtl(egrp_key, egrp_ou, egrp_id, egrp_lineno, egrp_eqp_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.egrp_key, s.egrp_ou, s.egrp_id, s.egrp_lineno, s.egrp_eqp_id, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_equipmentgroupdtl s
    LEFT JOIN click.d_equipmentgroupdtl t
    ON t.egrp_ou = s.egrp_ou
    AND t.egrp_id = s.egrp_id
    AND t.egrp_lineno = s.egrp_lineno
    WHERE t.egrp_ou IS NULL;
END;
$$;