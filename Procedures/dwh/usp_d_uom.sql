CREATE PROCEDURE dwh.usp_d_uom(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_uom_mas_uommaster;

	UPDATE dwh.D_Uom t
    SET
		mas_uomdesc			= s.mas_uomdesc,
		mas_fractions		= s.mas_fractions,
		mas_status			= s.mas_status,
		mas_reasoncode		= s.mas_reasoncode,
		mas_created_by		= s.mas_created_by,
		mas_created_date	= s.mas_created_date,
		mas_modified_by		= s.mas_modified_by,
		mas_modified_date	= s.mas_modified_date,
		mas_timestamp		= s.mas_timestamp,
		mas_created_langid	= s.mas_created_langid,
		mas_class			= s.mas_class,
		etlactiveind 		= 1,
		etljobname 			= p_etljobname,
		envsourcecd 		= p_envsourcecd ,
		datasourcecd 		= p_datasourcecd ,
		etlupdatedatetime 	= NOW()	
    FROM stg.stg_uom_mas_uommaster s
    WHERE t.mas_ouinstance  	= s.mas_ouinstance
	AND t.mas_uomcode 			= s.mas_uomcode;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_Uom
	(
	mas_ouinstance, 	mas_uomcode, 		mas_uomdesc, 		mas_fractions, 		mas_status, 
	mas_reasoncode,		mas_created_by, 	mas_created_date, 	mas_modified_by, 	mas_modified_date, 	
	mas_timestamp,		mas_created_langid, mas_class,			etlactiveind, 		etljobname, 
	envsourcecd, 		datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
	s.mas_ouinstance, 		s.mas_uomcode, 			s.mas_uomdesc, 		s.mas_fractions, 	s.mas_status, 
	s.mas_reasoncode,		s.mas_created_by, 		s.mas_created_date, s.mas_modified_by, 	s.mas_modified_date,
	s.mas_timestamp,		s.mas_created_langid, 	s.mas_class, 		1, 					p_etljobname, 
	p_envsourcecd,	 		p_datasourcecd, 		NOW()
	FROM stg.stg_uom_mas_uommaster s
    LEFT JOIN dwh.D_Uom t
    ON 	s.mas_ouinstance 		= t.mas_ouinstance
	AND s.mas_uomcode 		= t.mas_uomcode
    WHERE t.mas_ouinstance IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_uom_mas_uommaster

	(
	    mas_ouinstance, mas_uomcode, mas_uomdesc, mas_fractions, mas_status, mas_reasoncode, 
        mas_created_by, mas_created_date, mas_modified_by, mas_modified_date, mas_timestamp, 
        mas_created_langid, mas_class, mas_length, mas_breadth, mas_height, mas_max_weight, 
        mas_tare_weight, mas_dimension_uom, mas_weight_uom, etlcreateddatetime

		
	)
	SELECT 
	    mas_ouinstance, mas_uomcode, mas_uomdesc, mas_fractions, mas_status, mas_reasoncode, 
        mas_created_by, mas_created_date, mas_modified_by, mas_modified_date, mas_timestamp, 
        mas_created_langid, mas_class, mas_length, mas_breadth, mas_height, mas_max_weight, 
        mas_tare_weight, mas_dimension_uom, mas_weight_uom, etlcreateddatetime
	FROM stg.stg_uom_mas_uommaster;
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