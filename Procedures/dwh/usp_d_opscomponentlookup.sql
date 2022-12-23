CREATE PROCEDURE dwh.usp_d_opscomponentlookup(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	p_etljobname VARCHAR(100);
	p_envsourcecd VARCHAR(50);
	p_datasourcecd VARCHAR(50);
	p_batchid integer;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid integer;
	p_errordesc character varying;
	p_errorline integer;
	p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_component_metadata_table;
    

	
    INSERT INTO dwh.d_opscomponentlookup
	(
		componentname,      paramcategory,      paramtype,          paramcode,      optionvalue,
        sequenceno,         paramdesc,          paramdesc_shd,      langid,         cml_len,
        cml_translate,      etlactiveind,       etljobname, 		envsourcecd, 	datasourcecd, 	
        etlcreatedatetime
	)
	
    SELECT 
		s.componentname,     s.paramcategory,      s.paramtype,          s.paramcode,      s.optionvalue,
        s.sequenceno,        s.paramdesc,          s.paramdesc_shd,		 s.langid,         s.cml_len,
        s.cml_translate,	 1,                    p_etljobname,		 p_envsourcecd,	   p_datasourcecd,			
        NOW()
	FROM stg.stg_component_metadata_table s
    LEFT JOIN dwh.d_opscomponentlookup t
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
   
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	select 0 into updcnt; 
	
	IF p_rawstorageflag = 1
	THEN

    
    INSERT INTO raw.raw_component_metadata_table
	(
		 componentname, paramcategory, paramtype, paramcode, optionvalue, sequenceno, paramdesc, 
        paramdesc_shd, langid, cml_len, cml_translate, etlcreateddatetime
	)
	SELECT 
		componentname, paramcategory, paramtype, paramcode, optionvalue, sequenceno, paramdesc, 
        paramdesc_shd, langid, cml_len, cml_translate, etlcreateddatetime

	FROM stg.stg_component_metadata_table;
	END IF;

	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);

       select 0 into inscnt;
       select 0 into updcnt;  
END;
$$;