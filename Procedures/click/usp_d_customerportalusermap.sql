CREATE PROCEDURE click.usp_d_customerportalusermap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerportalusermap t
    SET
        customer_key = s.customer_key,
        customer_id = s.customer_id,
        customer_ou = s.customer_ou,
        customer_lineno = s.customer_lineno,
        customer_user_id = s.customer_user_id,
        customer_role = s.customer_role,
        customer_wms = s.customer_wms,
        customer_tms = s.customer_tms,
        customer_addl_custmap = s.customer_addl_custmap,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerportalusermap s
    WHERE t.customer_id = s.customer_id
    AND t.customer_ou = s.customer_ou
    AND t.customer_lineno = s.customer_lineno;

    INSERT INTO click.d_customerportalusermap(customer_key, customer_id, customer_ou, customer_lineno, customer_user_id, customer_role, customer_wms, customer_tms, customer_addl_custmap, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.customer_key, s.customer_id, s.customer_ou, s.customer_lineno, s.customer_user_id, s.customer_role, s.customer_wms, s.customer_tms, s.customer_addl_custmap, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerportalusermap s
    LEFT JOIN click.d_customerportalusermap t
    ON t.customer_id = s.customer_id
    AND t.customer_ou = s.customer_ou
    AND t.customer_lineno = s.customer_lineno
    WHERE t.customer_id IS NULL;
END;
$$;