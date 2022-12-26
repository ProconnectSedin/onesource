CREATE OR REPLACE PROCEDURE click.usp_d_itemgrouptype()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_itemgrouptype t
    SET
        item_igt_key = s.item_igt_key,
        item_igt_grouptype = s.item_igt_grouptype,
        item_igt_lo = s.item_igt_lo,
        item_igt_category = s.item_igt_category,
        item_igt_grouptypedesc = s.item_igt_grouptypedesc,
        item_igt_usage = s.item_igt_usage,
        item_igt_created_by = s.item_igt_created_by,
        item_igt_created_date = s.item_igt_created_date,
        item_igt_modified_by = s.item_igt_modified_by,
        item_igt_modified_date = s.item_igt_modified_date,
        item_igt_timestamp = s.item_igt_timestamp,
        item_igt_created_langid = s.item_igt_created_langid,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_itemgrouptype s
    WHERE t.item_igt_grouptype = s.item_igt_grouptype
    AND t.item_igt_lo = s.item_igt_lo;

    INSERT INTO click.d_itemgrouptype(item_igt_key, item_igt_grouptype, item_igt_lo, item_igt_category, item_igt_grouptypedesc, item_igt_usage, item_igt_created_by, item_igt_created_date, item_igt_modified_by, item_igt_modified_date, item_igt_timestamp, item_igt_created_langid, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.item_igt_key, s.item_igt_grouptype, s.item_igt_lo, s.item_igt_category, s.item_igt_grouptypedesc, s.item_igt_usage, s.item_igt_created_by, s.item_igt_created_date, s.item_igt_modified_by, s.item_igt_modified_date, s.item_igt_timestamp, s.item_igt_created_langid, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_itemgrouptype s
    LEFT JOIN click.d_itemgrouptype t
    ON t.item_igt_grouptype = s.item_igt_grouptype
    AND t.item_igt_lo = s.item_igt_lo
    WHERE t.item_igt_grouptype IS NULL;
END;
$$;