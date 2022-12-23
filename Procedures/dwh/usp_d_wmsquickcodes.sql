CREATE PROCEDURE dwh.usp_d_wmsquickcodes(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_quick_code_master;  -- change staging table

	UPDATE dwh.D_WMSQuickCodes t  --Change variables and table name
    SET -- logical column name = s.column name
		code_desc				= s.wms_code_desc,
		code_default			= s.wms_default,
		seq_no					= s.wms_seq_no,
		status					= s.wms_status,
		category				= s.wms_category,
		user_flag				= s.wms_user_flag,
		code_timestamp			= s.wms_timestamp,
		langid					= s.wms_langid,
		created_date			= s.wms_created_date,
		created_by				= s.wms_created_by,
		modified_date			= s.wms_modified_date,
		modified_by				= s.wms_modified_by,			
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_quick_code_master s		--staging table name in sheet
    WHERE t.code_ou				= s.wms_code_ou --unique and primary key
	AND   t.code_type			= s.wms_code_type
	AND   t.code				= s.wms_code;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_WMSQuickCodes -- table name
	(-- logical column names except last 5
		code_ou,			code_type,			code, 				code_desc, 			code_default,
		seq_no, 			status,				category, 			user_flag, 			code_timestamp,
		langid, 			created_date, 		created_by, 		modified_date,		modified_by, 	
		etlactiveind,   	etljobname, 		envsourcecd,		datasourcecd, 		etlcreatedatetime
	)
	
    SELECT  -- normal column name except last 5
		s.wms_code_ou, 		s.wms_code_type, 		s.wms_code, 		s.wms_code_desc, 		s.wms_default,
		s.wms_seq_no, 		s.wms_status, 			s.wms_category, 	s.wms_user_flag, 		s.wms_timestamp,
		s.wms_langid, 		s.wms_created_date, 	s.wms_created_by, 	s.wms_modified_date, 	s.wms_modified_by, 			
		1,					p_etljobname,		p_envsourcecd,		p_datasourcecd,		NOW()
	FROM stg.stg_wms_quick_code_master s -- staging table name
    LEFT JOIN dwh.D_WMSQuickCodes t -- table name
    ON 	s.wms_code_ou  			= t.code_ou -- only unique, no pkeys
	AND s.wms_code_type 		= t.code_type
	AND s.wms_code				= t.code
    WHERE t.code_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_quick_code_master --  staging table name
	(
	 wms_code_ou, wms_code_type, wms_code, wms_code_desc, wms_default, wms_seq_no, 
        wms_status, wms_category, wms_user_flag, wms_timestamp, wms_langid, 
        wms_created_date, wms_created_by, wms_modified_date, wms_modified_by, etlcreateddatetime

	
	)
	SELECT 
		 wms_code_ou, wms_code_type, wms_code, wms_code_desc, wms_default, wms_seq_no, 
        wms_status, wms_category, wms_user_flag, wms_timestamp, wms_langid, 
        wms_created_date, wms_created_by, wms_modified_date, wms_modified_by, etlcreateddatetime

	FROM stg.stg_wms_quick_code_master;	
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