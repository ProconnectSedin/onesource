CREATE PROCEDURE dwh.usp_d_locattribute(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_loc_attribute_dtl

;

	UPDATE dwh.D_LocAttribute t
    SET 	
		loc_attr_typ			= wms_loc_attr_typ,
		loc_attr_apl			= wms_loc_attr_apl,
		loc_attr_value			= wms_loc_attr_value,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_loc_attribute_dtl s
    WHERE t.loc_attr_loc_code		= s.wms_loc_attr_loc_code
	AND t.loc_attr_lineno 			= s.wms_loc_attr_lineno
	AND t.loc_attr_ou 			 	= s.wms_loc_attr_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_LocAttribute

	(
	loc_attr_loc_code,	loc_attr_lineno,	loc_attr_ou,	loc_attr_typ,	loc_attr_apl,		loc_attr_value,
	etlactiveind,   	etljobname,	 		envsourcecd, 	datasourcecd, 	etlcreatedatetime
	)
	
    SELECT 
	wms_loc_attr_loc_code,	wms_loc_attr_lineno,	wms_loc_attr_ou,	wms_loc_attr_typ,		wms_loc_attr_apl,		wms_loc_attr_value,
	1,						p_etljobname,			p_envsourcecd,		p_datasourcecd,			NOW()

	FROM stg.stg_wms_loc_attribute_dtl s
    LEFT JOIN dwh.D_LocAttribute t
    ON 	s.wms_loc_attr_loc_code 	= t.loc_attr_loc_code
	AND s.wms_loc_attr_lineno 		= t.loc_attr_lineno
	AND s.wms_loc_attr_ou			= t.loc_attr_ou 
    WHERE t.loc_attr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_loc_attribute_dtl
	(
		wms_loc_attr_loc_code, wms_loc_attr_lineno, wms_loc_attr_ou, wms_loc_attr_typ, wms_loc_attr_apl, 
        wms_loc_attr_value, etlcreateddatetime

	)
	SELECT 
		wms_loc_attr_loc_code, wms_loc_attr_lineno, wms_loc_attr_ou, wms_loc_attr_typ, wms_loc_attr_apl, 
        wms_loc_attr_value, etlcreateddate	
	FROM stg.stg_wms_loc_attribute_dtl;
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