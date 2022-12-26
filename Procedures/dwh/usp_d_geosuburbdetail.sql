CREATE OR REPLACE PROCEDURE dwh.usp_d_geosuburbdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_geo_suburb_dtl;
	
	
	UPDATE dwh.d_geoSuburbDetail t
    SET	
			geo_suburb_desc			=	s.wms_geo_suburb_desc,
			geo_suburb_status		=	s.wms_geo_suburb_status,
			geo_suburb_rsn			=	s.wms_geo_suburb_rsn,
			etlactiveind			=	1,
			envsourcecd				=	p_envsourcecd ,
			datasourcecd			=	p_datasourcecd ,
			etlupdatedatetime		=	NOW()
	FROM	stg.stg_wms_geo_suburb_dtl s
	WHERE	t.geo_country_code		=	s.wms_geo_country_code
	AND		t.geo_state_code		=	s.wms_geo_state_code
	AND		t.geo_city_code			=	s.wms_geo_city_code
	AND		t.geo_postal_code		=	s.wms_geo_postal_code
	AND		t.geo_suburb_code		=	s.wms_geo_suburb_code
	AND		t.geo_suburb_lineno		=	s.wms_geo_suburb_lineno;
	 
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geoSuburbDetail
	(
		geo_country_code	,		geo_state_code			,		geo_city_code		,		geo_postal_code		,
		geo_suburb_code		,		geo_suburb_ou			,		geo_suburb_lineno	,		geo_suburb_desc		,
		geo_suburb_status	,		geo_suburb_rsn			,
		etlactiveind		,		etljobname				,		envsourcecd			,		datasourcecd		,
		etlcreatedatetime	,		etlupdatedatetime
	)	
	
    SELECT 
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_city_code	,		wms_geo_postal_code	,
		wms_geo_suburb_code		,	wms_geo_suburb_ou		,		wms_geo_suburb_lineno,		wms_geo_suburb_desc	,
		wms_geo_suburb_status	,	wms_geo_suburb_rsn		,
			1					,	p_etljobname			, 			p_envsourcecd	,		p_datasourcecd		, 		
		etlcreateddatetime		,	now()
	FROM stg.stg_wms_geo_suburb_dtl s
    LEFT JOIN dwh.d_geoSuburbDetail t
    ON 		t.geo_state_code		=	s.wms_geo_state_code
	AND		t.geo_country_code		=	s.wms_geo_country_code
	AND		t.geo_city_code			=	s.wms_geo_city_code
	AND		t.geo_postal_code		=	s.wms_geo_postal_code
	AND		t.geo_suburb_code		=	s.wms_geo_suburb_code
	AND		t.geo_suburb_lineno		=	s.wms_geo_suburb_lineno
    WHERE	t.geo_country_code IS NULL;

    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_suburb_dtl
	(
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_city_code	,		wms_geo_postal_code	,
		wms_geo_suburb_code		,	wms_geo_suburb_ou		,		wms_geo_suburb_lineno,		wms_geo_suburb_desc	,
		wms_geo_suburb_status	,	wms_geo_suburb_rsn		,		etlcreateddatetime
	)

	SELECT 
		wms_geo_country_code	,	wms_geo_state_code		,		wms_geo_city_code	,		wms_geo_postal_code	,
		wms_geo_suburb_code		,	wms_geo_suburb_ou		,		wms_geo_suburb_lineno,		wms_geo_suburb_desc	,
		wms_geo_suburb_status	,	wms_geo_suburb_rsn		,		etlcreateddatetime
	FROM stg.stg_wms_geo_suburb_dtl;
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