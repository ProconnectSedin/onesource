CREATE OR REPLACE PROCEDURE click.usp_d_customerattributes()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_customerattributes t
    SET
        wms_cust_attr_key = s.wms_cust_attr_key,
        wms_cust_attr_cust_code = s.wms_cust_attr_cust_code,
        wms_cust_attr_lineno = s.wms_cust_attr_lineno,
        wms_cust_attr_ou = s.wms_cust_attr_ou,
        wms_cust_attr_typ = s.wms_cust_attr_typ,
        wms_cust_attr_apl = s.wms_cust_attr_apl,
        wms_cust_attr_value = s.wms_cust_attr_value,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_customerattributes s
    WHERE t.wms_cust_attr_cust_code = s.wms_cust_attr_cust_code
    AND t.wms_cust_attr_lineno = s.wms_cust_attr_lineno
    AND t.wms_cust_attr_ou = s.wms_cust_attr_ou;

    INSERT INTO click.d_customerattributes(wms_cust_attr_key, wms_cust_attr_cust_code, wms_cust_attr_lineno, wms_cust_attr_ou, wms_cust_attr_typ, wms_cust_attr_apl, wms_cust_attr_value, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.wms_cust_attr_key, s.wms_cust_attr_cust_code, s.wms_cust_attr_lineno, s.wms_cust_attr_ou, s.wms_cust_attr_typ, s.wms_cust_attr_apl, s.wms_cust_attr_value, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_customerattributes s
    LEFT JOIN click.d_customerattributes t
    ON t.wms_cust_attr_cust_code = s.wms_cust_attr_cust_code
    AND t.wms_cust_attr_lineno = s.wms_cust_attr_lineno
    AND t.wms_cust_attr_ou = s.wms_cust_attr_ou
    WHERE t.wms_cust_attr_cust_code IS NULL;
END;
$$;