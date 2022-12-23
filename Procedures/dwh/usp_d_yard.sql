CREATE PROCEDURE dwh.usp_d_yard(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
		ON  d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_yard_hdr;

	UPDATE dwh.d_yard t  --Change variables and table name
    SET 
		yard_desc				= s.wms_yard_desc,
		yard_type				= s.wms_yard_type,
		yard_status				= s.wms_yard_status,
		yard_reason				= s.wms_yard_reason,
		yard_timestamp			= s.wms_yard_timestamp,
		yard_created_by			= s.wms_yard_created_by,
		yard_created_dt			= s.wms_yard_created_dt,
		yard_modified_by		= s.wms_yard_modified_by,
		yard_modified_dt		= s.wms_yard_modified_dt,	
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_yard_hdr s		--staging table name in sheet
    WHERE t.yard_id  			= s.wms_yard_id --unique and primary key
	AND t.yard_loc_code 		= s.wms_yard_loc_code
	AND t.yard_ou 				= s.wms_yard_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_yard -- table name
	(
		yard_id,				yard_loc_code,			yard_ou,				yard_desc,
		yard_type,				yard_status,			yard_reason,			yard_timestamp,
		yard_created_by,		yard_created_dt,		yard_modified_by,		yard_modified_dt,
		etlactiveind,        	etljobname, 			envsourcecd, 			datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
		s.wms_yard_id,			s.wms_yard_loc_code,	s.wms_yard_ou,			s.wms_yard_desc,
		s.wms_yard_type,		s.wms_yard_status,		s.wms_yard_reason,		s.wms_yard_timestamp,
		s.wms_yard_created_by,	s.wms_yard_created_dt,	s.wms_yard_modified_by,	s.wms_yard_modified_dt,
		1,						p_etljobname,			p_envsourcecd,			p_datasourcecd,			NOW()
	FROM stg.stg_wms_yard_hdr s -- staging table name
    LEFT JOIN dwh.d_yard t -- table name
    ON 	s.wms_yard_id  			= t.yard_id -- only unique, no pkeys
	AND s.wms_yard_loc_code		= t.yard_loc_code
	AND s.wms_yard_ou 			= t.yard_ou 
    WHERE t.yard_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_wms_yard_hdr --  staging table name
	(
		wms_yard_id, 			wms_yard_loc_code, 		wms_yard_ou, 			wms_yard_desc, 			wms_yard_type, 
        wms_yard_status, 		wms_yard_reason, 		wms_yard_timestamp, 	wms_yard_created_by, 
        wms_yard_created_dt, 	wms_yard_modified_by, 	wms_yard_modified_dt, 	wms_yard_userdefined1, 
        wms_yard_userdefined2, 	wms_yard_userdefined3, 	etlcreateddatetime
	)
	SELECT 
		wms_yard_id, 			wms_yard_loc_code, 		wms_yard_ou, 			wms_yard_desc, 			wms_yard_type, 
        wms_yard_status, 		wms_yard_reason, 		wms_yard_timestamp, 	wms_yard_created_by, 
        wms_yard_created_dt,	wms_yard_modified_by, 	wms_yard_modified_dt, 	wms_yard_userdefined1, 
        wms_yard_userdefined2, 	wms_yard_userdefined3, 	etlcreateddatetime
	FROM stg.stg_wms_yard_hdr;
	END IF;
	
	EXCEPTION WHEN others THEN       
       
    get stacked diagnostics p_errorid   = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);        
    select 0 into inscnt;
    select 0 into updcnt; 
END;
$$;