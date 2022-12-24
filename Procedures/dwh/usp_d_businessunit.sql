CREATE OR REPLACE PROCEDURE dwh.usp_d_businessunit(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_emod_bu_mst;

	UPDATE dwh.d_businessunit t
    SET 
		btimestamp		    = s.btimestamp   ,
		bu_name				= s.bu_name     ,
		status				= s.status      ,
		address_id			= s.address_id  ,
		effective_from		= s.effective_from,
		createdby			= s.createdby   ,
        etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_emod_bu_mst s
    WHERE t.company_code  		= s.company_code
	AND t.bu_id 			= s.bu_id
    AND t.serial_no 			= s.serial_no;
   
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_businessunit
	(
		company_code,			bu_id,			serial_no,			btimestamp,			bu_name,
        status,					address_id,		effective_from,		createdby,
        etlactiveind,           etljobname,     envsourcecd, 	    datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
        s.company_code,			    s.bu_id,			s.serial_no,			s.btimestamp,			s.bu_name,
		s.status,					s.address_id,		s.effective_from,		s.createdby,
        1,                          p_etljobname,		p_envsourcecd,	        p_datasourcecd,			NOW()
	FROM stg.stg_emod_bu_mst s
    LEFT JOIN dwh.d_businessunit t
    ON 	t.company_code  		= s.company_code
	AND t.bu_id 			= s.bu_id
    AND t.serial_no 			= s.serial_no
    WHERE t.company_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_emod_bu_mst
	(
	    company_code, bu_id, serial_no, btimestamp, bu_name, 
        status, address_id, effective_from, effective_to, createdby,
        createddate, modifiedby, modifieddate,etlcreateddatetime
	)
	SELECT 
		company_code, bu_id, serial_no, btimestamp, bu_name, 
        status, address_id, effective_from, effective_to, createdby,
        createddate, modifiedby, modifieddate, etlcreateddatetime
	FROM stg.stg_emod_bu_mst;
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