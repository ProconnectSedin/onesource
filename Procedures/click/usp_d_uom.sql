CREATE OR REPLACE PROCEDURE click.usp_d_uom()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_uom t
    SET
        uom_key = s.uom_key,
        mas_ouinstance = s.mas_ouinstance,
        mas_uomcode = s.mas_uomcode,
        mas_uomdesc = s.mas_uomdesc,
        mas_fractions = s.mas_fractions,
        mas_status = s.mas_status,
        mas_reasoncode = s.mas_reasoncode,
        mas_created_by = s.mas_created_by,
        mas_created_date = s.mas_created_date,
        mas_modified_by = s.mas_modified_by,
        mas_modified_date = s.mas_modified_date,
        mas_timestamp = s.mas_timestamp,
        mas_created_langid = s.mas_created_langid,
        mas_class = s.mas_class,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_uom s
    WHERE t.mas_ouinstance = s.mas_ouinstance
    AND t.mas_uomcode = s.mas_uomcode;

    INSERT INTO click.d_uom(uom_key, mas_ouinstance, mas_uomcode, mas_uomdesc, mas_fractions, mas_status, mas_reasoncode, mas_created_by, mas_created_date, mas_modified_by, mas_modified_date, mas_timestamp, mas_created_langid, mas_class, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.uom_key, s.mas_ouinstance, s.mas_uomcode, s.mas_uomdesc, s.mas_fractions, s.mas_status, s.mas_reasoncode, s.mas_created_by, s.mas_created_date, s.mas_modified_by, s.mas_modified_date, s.mas_timestamp, s.mas_created_langid, s.mas_class, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_uom s
    LEFT JOIN click.d_uom t
    ON t.mas_ouinstance = s.mas_ouinstance
    AND t.mas_uomcode = s.mas_uomcode
    WHERE t.mas_ouinstance IS NULL;
END;
$$;