CREATE OR REPLACE PROCEDURE click.usp_d_opscomponentlookup()
    LANGUAGE plpgsql
    AS $$

BEGIN
    

    INSERT INTO click.d_opscomponentlookup(comp_lkp_key, componentname, paramcategory, paramtype, paramcode, optionvalue, sequenceno, paramdesc, paramdesc_shd, langid, cml_len, cml_translate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.comp_lkp_key, s.componentname, s.paramcategory, s.paramtype, s.paramcode, s.optionvalue, s.sequenceno, s.paramdesc, s.paramdesc_shd, s.langid, s.cml_len, s.cml_translate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_opscomponentlookup s
    LEFT JOIN click.d_opscomponentlookup t
    ON 	COALESCE(s.componentname,'NULL') 	    = COALESCE(t.componentname,'NULL')
	AND COALESCE(s.paramcategory,'NULL')  		= COALESCE(t.paramcategory,'NULL')
	AND COALESCE(s.paramtype,'NULL')  			= COALESCE(t.paramtype,'NULL')
	AND COALESCE(s.paramcode,'NULL') 			= COALESCE(t.paramcode ,'NULL')
    AND COALESCE(s.optionvalue,'NULL') 			= COALESCE(t.optionvalue,'NULL')
    AND COALESCE(s.sequenceno,0) 			    = COALESCE(t.sequenceno,0)
    AND COALESCE(s.paramdesc,'NULL') 			= COALESCE(t.paramdesc,'NULL')
    AND COALESCE(s.paramdesc_shd,'NULL')  		= COALESCE(t.paramdesc_shd,'NULL')
    AND COALESCE(s.langid,0) 			        = COALESCE(t.langid,0)
    AND COALESCE(s.cml_len,0)  			        = COALESCE(t.cml_len,0)
    AND COALESCE(s.cml_translate,'NULL') 		= COALESCE(t.cml_translate,'NULL')
    WHERE t.componentname IS NULL;
END;
$$;