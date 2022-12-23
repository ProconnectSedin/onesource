CREATE PROCEDURE click.usp_d_tarifftypegroup()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_tarifftypegroup t
    SET
        tf_key = s.tf_key,
        tf_grp_code = s.tf_grp_code,
        tf_type_code = s.tf_type_code,
        tf_type_desc = s.tf_type_desc,
        tf_formula = s.tf_formula,
        tf_created_by = s.tf_created_by,
        tf_created_date = s.tf_created_date,
        tf_langid = s.tf_langid,
        tf_acc_flag = s.tf_acc_flag,
        tariff_code = s.tariff_code,
        description = s.description,
        formula = s.formula,
        tf_tariff_code_version = s.tf_tariff_code_version,
        tf_br_remit_flag = s.tf_br_remit_flag,
        tf_revenue_split = s.tf_revenue_split,
        tf_basicsforop = s.tf_basicsforop,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_tarifftypegroup s
    WHERE t.tf_grp_code = s.tf_grp_code
    AND t.tf_type_code = s.tf_type_code;

    INSERT INTO click.d_tarifftypegroup(tf_key, tf_grp_code, tf_type_code, tf_type_desc, tf_formula, tf_created_by, tf_created_date, tf_langid, tf_acc_flag, tariff_code, description, formula, tf_tariff_code_version, tf_br_remit_flag, tf_revenue_split, tf_basicsforop, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tf_key, s.tf_grp_code, s.tf_type_code, s.tf_type_desc, s.tf_formula, s.tf_created_by, s.tf_created_date, s.tf_langid, s.tf_acc_flag, s.tariff_code, s.description, s.formula, s.tf_tariff_code_version, s.tf_br_remit_flag, s.tf_revenue_split, s.tf_basicsforop, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_tarifftypegroup s
    LEFT JOIN click.d_tarifftypegroup t
    ON t.tf_grp_code = s.tf_grp_code
    AND t.tf_type_code = s.tf_type_code
    WHERE t.tf_grp_code IS NULL;
END;
$$;