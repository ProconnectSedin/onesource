CREATE PROCEDURE dwh.usp_d_geocitydetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_geo_city_dtl;

	UPDATE dwh.d_geoCityDetail t
    SET 
			geo_city_desc				=	s.wms_geo_city_desc,
			geo_city_timezn				=	s.wms_geo_city_timezn,
			geo_city_status				=	s.wms_geo_city_status,
			geo_city_rsn				=	s.wms_geo_city_rsn,
			etlactiveind 				=	1,
			etljobname 					=	p_etljobname,
			envsourcecd 				=	p_envsourcecd,
			datasourcecd 				=	p_datasourcecd,
			etlupdatedatetime 			=	NOW()
    FROM    stg.stg_wms_geo_city_dtl s
    WHERE	t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_state_code			=	s.wms_geo_state_code
	AND     t.geo_city_code				=	s.wms_geo_city_code
	AND		t.geo_city_ou				=	s.wms_geo_city_ou
	AND     t.geo_city_lineno			=   s.wms_geo_city_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geoCityDetail
	(
		geo_country_code				,geo_state_code					,geo_city_code					,geo_city_ou      
		,geo_city_lineno				,geo_city_desc					,geo_city_timezn				,geo_city_status		,geo_city_rsn 
		,etlactiveind					,etljobname						,envsourcecd					,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_city_ou
		,wms_geo_city_lineno				,wms_geo_city_desc						,wms_geo_city_timezn				,wms_geo_city_status	,wms_geo_city_rsn
		,1									,p_etljobname							,p_envsourcecd						,p_datasourcecd			,NOW()
	FROM stg.stg_wms_geo_city_dtl s
    LEFT JOIN dwh.d_geoCityDetail t
    ON 		t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_state_code			=	s.wms_geo_state_code
	AND     t.geo_city_code				=	s.wms_geo_city_code
	AND		t.geo_city_ou				=	s.wms_geo_city_ou
	AND     t.geo_city_lineno			=   s.wms_geo_city_lineno
    WHERE	t.geo_city_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_city_dtl
	(
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_city_ou
		,wms_geo_city_lineno				,wms_geo_city_desc						,wms_geo_city_timezn				,wms_geo_city_status	,wms_geo_city_rsn
		,etlcreateddatetime
	)
	SELECT 
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_city_ou
		,wms_geo_city_lineno				,wms_geo_city_desc						,wms_geo_city_timezn				,wms_geo_city_status	,wms_geo_city_rsn
		,etlcreateddatetime
	FROM stg.stg_wms_geo_city_dtl;
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