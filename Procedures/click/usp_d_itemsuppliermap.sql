CREATE OR REPLACE PROCEDURE click.usp_d_itemsuppliermap()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_itemsuppliermap t
    SET
        itm_supp_key = s.itm_supp_key,
        itm_ou = s.itm_ou,
        itm_code = s.itm_code,
        itm_lineno = s.itm_lineno,
        itm_supp_code = s.itm_supp_code,
        item_source = s.item_source,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_itemsuppliermap s
    WHERE t.itm_ou = s.itm_ou
    AND t.itm_code = s.itm_code
    AND t.itm_lineno = s.itm_lineno;

    INSERT INTO click.d_itemsuppliermap(itm_supp_key, itm_ou, itm_code, itm_lineno, itm_supp_code, item_source, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.itm_supp_key, s.itm_ou, s.itm_code, s.itm_lineno, s.itm_supp_code, s.item_source, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_itemsuppliermap s
    LEFT JOIN click.d_itemsuppliermap t
    ON t.itm_ou = s.itm_ou
    AND t.itm_code = s.itm_code
    AND t.itm_lineno = s.itm_lineno
    WHERE t.itm_ou IS NULL;
END;
$$;