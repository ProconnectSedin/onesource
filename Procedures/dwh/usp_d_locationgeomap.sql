CREATE PROCEDURE dwh.usp_d_locationgeomap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_loc_location_geo_dtl
;

	UPDATE dwh.D_LocationGeoMap t
    SET 
		loc_geography 			= s.wms_loc_geography,
		loc_geo_type 			= s.wms_loc_geo_type,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_loc_location_geo_dtl s
    WHERE t.loc_ou 			= s.wms_loc_ou
	AND t.loc_code 			= s.wms_loc_code
	AND t.loc_geo_lineno 	= s.wms_loc_geo_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_LocationGeoMap

	(
		loc_ou,				loc_code,			loc_geo_lineno,			loc_geography,
		loc_geo_type,		etlactiveind,   	etljobname,	 			envsourcecd, 	
		datasourcecd, 		etlcreatedatetime
	)
	
    SELECT 
		s.wms_loc_ou,		s.wms_loc_code,		s.wms_loc_geo_lineno,	s.wms_loc_geography,	
		s.wms_loc_geo_type,	1					,p_etljobname,			p_envsourcecd,		
		p_datasourcecd,		NOW()
	FROM stg.stg_wms_loc_location_geo_dtl s
    LEFT JOIN dwh.D_LocationGeoMap t
    ON 	s.wms_loc_ou 			= t.loc_ou
	AND s.wms_loc_code 			= t.loc_code
	AND s.wms_loc_geo_lineno	= t.loc_geo_lineno 
    WHERE t.loc_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_loc_location_geo_dtl
	(		
			wms_loc_ou,	 		wms_loc_code, 		wms_loc_geo_lineno,
		 	wms_loc_geography, 	wms_loc_geo_type, 	etlcreateddatetime	
	)
	SELECT 
			wms_loc_ou,	 		wms_loc_code, 		wms_loc_geo_lineno,
		 	wms_loc_geography, 	wms_loc_geo_type, 	etlcreateddatetime	
	FROM stg.stg_wms_loc_location_geo_dtl;	
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