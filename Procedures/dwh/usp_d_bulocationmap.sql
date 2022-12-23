CREATE PROCEDURE dwh.usp_d_bulocationmap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_emod_lo_bu_map;

	UPDATE dwh.d_bulocationmap t
    SET 
		btimestamp			= s.btimestamp     ,
		lo_name				= s.lo_name       ,
		map_status			= s.map_status    ,
		effective_from		= s.effective_from,
		map_by				= s.map_by        ,
		map_date			= s.map_date      ,
		createdby			= s.createdby     ,
		createddate			= s.createddate   ,
		modifiedby			= s.modifiedby    ,
		modifieddate		= s.modifieddate  ,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_emod_lo_bu_map s
    WHERE t.lo_id  		= s.lo_id
	AND t.bu_id 			= s.bu_id
    AND t.company_code 			= s.company_code
    AND t.serial_no 			= s.serial_no;
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_bulocationmap
	(
		lo_id,			bu_id,			company_code,			serial_no,			btimestamp,
		lo_name,		map_status,		effective_from,			map_by,				map_date,
		createdby,		createddate,	modifiedby,				modifieddate,
        etlactiveind,   etljobname,     envsourcecd, 	        datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
        s.lo_id,			s.bu_id,			s.company_code,			    s.serial_no,			s.btimestamp,
		s.lo_name,		    s.map_status,		s.effective_from,			s.map_by,				s.map_date,
		s.createdby,		s.createddate,	    s.modifiedby,				s.modifieddate,
        1,                  p_etljobname,		p_envsourcecd,	            p_datasourcecd,			NOW()
	FROM stg.stg_emod_lo_bu_map s
    LEFT JOIN dwh.d_bulocationmap t
    ON 	t.lo_id  		= s.lo_id
	AND t.bu_id 			= s.bu_id
    AND t.company_code 			= s.company_code
    AND t.serial_no 			= s.serial_no 
    WHERE t.lo_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
 
	
	INSERT INTO raw.raw_emod_lo_bu_map
	(
	    lo_id, bu_id, company_code, serial_no, btimestamp, 
        lo_name, map_status, effective_from, effective_to, map_by,
        map_date, unmap_by, unmap_date, createdby, createddate, 
        modifiedby, modifieddate,etlcreateddatetime
	)
	SELECT 
		lo_id, bu_id, company_code, serial_no, btimestamp, 
        lo_name, map_status, effective_from, effective_to, map_by,
        map_date, unmap_by, unmap_date, createdby, createddate, 
        modifiedby, modifieddate,etlcreateddatetime
	FROM stg.stg_emod_lo_bu_map;
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