CREATE PROCEDURE dwh.usp_d_geostatedetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_geo_state_dtl;
	
	UPDATE dwh.d_geoStateDetail t
    SET		
			geo_state_desc			=	s.wms_geo_state_desc,
			geo_state_timezn		=	s.wms_geo_state_timezn,
			geo_state_status		=	s.wms_geo_state_status,
			geo_state_rsn			=	s.wms_geo_state_rsn,
			ge_holidays				=	s.wms_ge_holidays,
			etlactiveind			=	1,
			envsourcecd				=	p_envsourcecd ,
			datasourcecd			=	p_datasourcecd ,
			etlupdatedatetime		=	NOW()	
	FROM	stg.stg_wms_geo_state_dtl s
	WHERE	t.geo_state_code			=	s.wms_geo_state_code
	AND		t.geo_state_ou				=	s.wms_geo_state_ou
	AND		t.geo_state_lineno			=	s.wms_geo_state_lineno
	AND		t.geo_country_code			=	s.wms_geo_country_code;
	 
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geoStateDetail
	(
		geo_country_code		,		geo_state_code		,		geo_state_ou		,		geo_state_lineno	,
		geo_state_desc			,		geo_state_timezn	,		geo_state_status	,		geo_state_rsn		,
		ge_holidays				,
		etlactiveind			,		etljobname			,		envsourcecd			,	datasourcecd			,
		etlcreatedatetime
	)	
	
    SELECT 
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_state_ou		,	wms_geo_state_lineno	,
		wms_geo_state_desc		,	wms_geo_state_timezn	,		wms_geo_state_status	,	wms_geo_state_rsn		,
		s.ge_holidays				,
			1					,		p_etljobname		, 			p_envsourcecd		,		p_datasourcecd		, 		
		now()
	FROM stg.stg_wms_geo_state_dtl s
    LEFT JOIN dwh.d_geoStateDetail t
    ON 	s.wms_geo_state_code	=	t.geo_state_code
	AND s.wms_geo_country_code	=	t.geo_country_code
	AND	s.wms_geo_state_ou		=	t.geo_state_ou
    WHERE t.geo_country_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_state_dtl
	(
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_state_ou		,	wms_geo_state_lineno	,
		wms_geo_state_desc		,	wms_geo_state_timezn	,		wms_geo_state_status	,	wms_geo_state_rsn		,
		ge_holidays				,	etlcreateddatetime		
	)

	SELECT 
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_state_ou		,	wms_geo_state_lineno	,
		wms_geo_state_desc		,	wms_geo_state_timezn	,		wms_geo_state_status	,	wms_geo_state_rsn		,
		ge_holidays				,	etlcreateddatetime
	FROM stg.stg_wms_geo_state_dtl;
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