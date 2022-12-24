CREATE OR REPLACE PROCEDURE click.usp_d_tmsparameter()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_tmsparameter t
    SET
        tms_key = s.tms_key,
        tms_componentname = s.tms_componentname,
        tms_paramcategory = s.tms_paramcategory,
        tms_paramtype = s.tms_paramtype,
        tms_paramcode = s.tms_paramcode,
        tms_paramdesc = s.tms_paramdesc,
        tms_langid = s.tms_langid,
        tms_optionvalue = s.tms_optionvalue,
        tms_sequenceno = s.tms_sequenceno,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_tmsparameter s
    WHERE t.tms_componentname = s.tms_componentname
    AND t.tms_paramcategory = s.tms_paramcategory
    AND t.tms_paramtype = s.tms_paramtype
    AND t.tms_paramcode = s.tms_paramcode
    AND t.tms_paramdesc = s.tms_paramdesc
    AND t.tms_langid = s.tms_langid;

    INSERT INTO click.d_tmsparameter(tms_key, tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid, tms_optionvalue, tms_sequenceno, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tms_key, s.tms_componentname, s.tms_paramcategory, s.tms_paramtype, s.tms_paramcode, s.tms_paramdesc, s.tms_langid, s.tms_optionvalue, s.tms_sequenceno, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_tmsparameter s
    LEFT JOIN click.d_tmsparameter t
    ON t.tms_componentname = s.tms_componentname
    AND t.tms_paramcategory = s.tms_paramcategory
    AND t.tms_paramtype = s.tms_paramtype
    AND t.tms_paramcode = s.tms_paramcode
    AND t.tms_paramdesc = s.tms_paramdesc
    AND t.tms_langid = s.tms_langid
    WHERE t.tms_componentname IS NULL;
END;
$$;