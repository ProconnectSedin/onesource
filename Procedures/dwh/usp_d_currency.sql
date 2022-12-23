CREATE PROCEDURE dwh.usp_d_currency(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_emod_currency_mst;

	UPDATE dwh.d_currency t
    SET 
         ctimestamp              =s.ctimestamp,
         num_curr_code           =s.num_curr_code,
         curr_symbol             =s.curr_symbol,
         curr_desc               =s.curr_desc,
         curr_sub_units          =s.curr_sub_units,
         curr_sub_unit_desc      =s.curr_sub_unit_desc,
         curr_units              =s.curr_units,
         currency_status         =s.currency_status,
         curr_symbol_flag        =s.curr_symbol_flag,
         effective_from          =s.effective_from,
         createdby               =s.createdby,
         createddate             =s.createddate,
         modifiedby              =s.modifiedby,
         modifieddate            =s.modifieddate,
		 etlactiveind 			= 1,
		 envsourcecd 			= p_envsourcecd ,
		 datasourcecd 			= p_datasourcecd ,
		 etlupdatedatetime 		= NOW()	
    FROM stg.stg_emod_currency_mst s
    WHERE t.iso_curr_code  		= s.iso_curr_code
	AND t.serial_no 			= s.serial_no;
	 
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_currency
	(
		iso_curr_code,		serial_no,			ctimestamp, 		num_curr_code,		
		curr_symbol, 		curr_desc, 			curr_sub_units,	    curr_sub_unit_desc, 
		curr_units, 		currency_status, 	curr_symbol_flag, 	effective_from, 	
		createdby, 			createddate, 		modifiedby, 		modifieddate, 		
		etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 		
		etlcreatedatetime
	)
	
    SELECT 
		s.iso_curr_code,		s.serial_no,			s.ctimestamp, 			s.num_curr_code,		
		s.curr_symbol, 			s.curr_desc, 			s.curr_sub_units,	    s.curr_sub_unit_desc, 
		s.curr_units, 			s.currency_status, 		s.curr_symbol_flag, 	s.effective_from, 	
		s.createdby, 			s.createddate, 			s.modifiedby, 			s.modifieddate, 		
		1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 		
		now()
	FROM stg.stg_emod_currency_mst s
    LEFT JOIN dwh.d_currency t
    ON 	s.iso_curr_code  		= t.iso_curr_code
	AND s.serial_no 			= t.serial_no
    WHERE t.iso_curr_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_emod_currency_mst
	(
		iso_curr_code, 			serial_no, 			ctimestamp, 			num_curr_code, 
		curr_symbol, 			curr_desc, 			curr_sub_units, 		curr_sub_unit_desc, 
		curr_units, 			currency_status, 	curr_symbol_flag, 		effective_from, 
		effective_to, 			createdby, 			createddate, 			modifiedby, 
		modifieddate, 			etlcreateddatetime		
	)
	SELECT 
		iso_curr_code, 			serial_no, 			ctimestamp, 			num_curr_code, 
		curr_symbol, 			curr_desc, 			curr_sub_units, 		curr_sub_unit_desc, 
		curr_units, 			currency_status, 	curr_symbol_flag, 		effective_from, 
		effective_to, 			createdby, 			createddate, 			modifiedby, 
		modifieddate, 			etlcreateddatetime
	FROM stg.stg_emod_currency_mst;
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