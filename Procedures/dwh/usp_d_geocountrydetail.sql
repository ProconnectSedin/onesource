CREATE OR REPLACE PROCEDURE dwh.usp_d_geocountrydetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_geo_country_dtl;

	UPDATE dwh.d_geoCountryDetail t
    SET 
			geo_country_desc			=	s.wms_geo_country_desc,
			geo_country_timezn			=	s.wms_geo_country_timezn,
			geo_country_status			=	s.wms_geo_country_status,
			etlactiveind 				=	1,
			etljobname 					=	p_etljobname,
			envsourcecd 				=	p_envsourcecd,
			datasourcecd 				=	p_datasourcecd,
			etlupdatedatetime 			=	NOW()
    FROM    stg.stg_wms_geo_country_dtl s
    WHERE	t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_country_ou			=	s.wms_geo_country_ou
	AND     t.geo_country_lineno		=	s.wms_geo_country_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geoCountryDetail
	(
		geo_country_code				,geo_country_ou					,geo_country_lineno				,geo_country_desc
		,geo_country_timezn				,geo_country_status
		,etlactiveind					,etljobname						,envsourcecd					,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		wms_geo_country_code				,wms_geo_country_ou						,wms_geo_country_lineno				,wms_geo_country_desc
		,wms_geo_country_timezn				,wms_geo_country_status
		,1									,p_etljobname							,p_envsourcecd						,p_datasourcecd			,NOW()
	FROM stg.stg_wms_geo_country_dtl s
    LEFT JOIN dwh.d_geoCountryDetail t
    ON 		t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_country_ou			=	s.wms_geo_country_ou
	AND     t.geo_country_lineno		=	s.wms_geo_country_lineno
    WHERE	t.geo_country_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_country_dtl
	(
  
		wms_geo_country_code				,wms_geo_country_ou						,wms_geo_country_lineno				,wms_geo_country_desc
		,wms_geo_country_timezn				,wms_geo_country_status					,wms_geo_country_rsn				,wms_geo_currency
		,etlcreateddatetime
	)
	SELECT 
		wms_geo_country_code				,wms_geo_country_ou						,wms_geo_country_lineno				,wms_geo_country_desc
		,wms_geo_country_timezn				,wms_geo_country_status					,wms_geo_country_rsn				,wms_geo_currency
		,etlcreateddatetime
	FROM stg.stg_wms_geo_country_dtl;
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