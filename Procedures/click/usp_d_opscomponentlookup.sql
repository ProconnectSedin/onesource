-- PROCEDURE: click.usp_d_opscomponentlookup()

-- DROP PROCEDURE IF EXISTS click.usp_d_opscomponentlookup();

CREATE OR REPLACE PROCEDURE click.usp_d_opscomponentlookup(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

	TRUNCATE TABLE click.d_opscomponentlookup
	RESTART IDENTITY;

    INSERT INTO click.d_opscomponentlookup(comp_lkp_key, componentname, paramcategory, paramtype, paramcode, optionvalue, sequenceno, paramdesc, paramdesc_shd, langid, cml_len, cml_translate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.comp_lkp_key, s.componentname, s.paramcategory, s.paramtype, s.paramcode, s.optionvalue, s.sequenceno, s.paramdesc, s.paramdesc_shd, s.langid, s.cml_len, s.cml_translate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_opscomponentlookup s;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_opscomponentlookup()
    OWNER TO proconnect;