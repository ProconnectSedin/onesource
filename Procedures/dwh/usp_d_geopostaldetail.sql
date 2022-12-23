CREATE PROCEDURE dwh.usp_d_geopostaldetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_geo_postal_dtl;

	UPDATE dwh.d_geoPostalDetail t
    SET 
			geo_postal_desc				=	s.wms_geo_postal_desc,
			geo_postal_status			=	s.wms_geo_postal_status,
			geo_postal_rsn				=	s.wms_geo_postal_rsn,
			geo_postal_lantitude		=	s.wms_geo_postal_lantitude,
			geo_postal_longitude		=	s.wms_geo_postal_longitude,
			geo_postal_geo_fen_name		=	s.wms_geo_postal_geo_fen_name,
			geo_postal_geo_fen_range	=	s.wms_geo_postal_geo_fen_range,
			geo_postal_range_uom		=	s.wms_geo_postal_range_uom,
			etlactiveind 				=	1,
			etljobname 					=	p_etljobname,
			envsourcecd 				=	p_envsourcecd,
			datasourcecd 				=	p_datasourcecd,
			etlupdatedatetime 			=	NOW()
    FROM    stg.stg_wms_geo_postal_dtl s
    WHERE	t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_state_code			=	s.wms_geo_state_code
	AND     t.geo_city_code				=	s.wms_geo_city_code
	AND     t.geo_postal_code			=	s.wms_geo_postal_code
	AND		t.geo_postal_ou				=	s.wms_geo_postal_ou
	AND     t.geo_postal_lineno			=   s.wms_geo_postal_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geoPostalDetail
	(
		geo_country_code				,geo_state_code					,geo_city_code					,geo_postal_code
		,geo_postal_ou					,geo_postal_lineno				,geo_postal_desc				,geo_postal_status
		,geo_postal_rsn					,geo_postal_lantitude			,geo_postal_longitude			,geo_postal_geo_fen_name
		,geo_postal_geo_fen_range		,geo_postal_range_uom
		,etlactiveind					,etljobname						,envsourcecd					,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_postal_code
		,wms_geo_postal_ou					,wms_geo_postal_lineno					,wms_geo_postal_desc				,wms_geo_postal_status
		,wms_geo_postal_rsn					,wms_geo_postal_lantitude				,wms_geo_postal_longitude			,wms_geo_postal_geo_fen_name
		,wms_geo_postal_geo_fen_range		,wms_geo_postal_range_uom
		,1									,p_etljobname							,p_envsourcecd						,p_datasourcecd			,NOW()
	FROM stg.stg_wms_geo_postal_dtl s
    LEFT JOIN dwh.d_geoPostalDetail t
    ON 		t.geo_country_code			=	s.wms_geo_country_code
	AND		t.geo_state_code			=	s.wms_geo_state_code
	AND     t.geo_city_code				=	s.wms_geo_city_code
	AND     t.geo_postal_code			=	s.wms_geo_postal_code
	AND		t.geo_postal_ou				=	s.wms_geo_postal_ou
	AND     t.geo_postal_lineno			=   s.wms_geo_postal_lineno
    WHERE	t.geo_postal_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_postal_dtl
	(
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_postal_code
		,wms_geo_postal_ou					,wms_geo_postal_lineno					,wms_geo_postal_desc				,wms_geo_postal_status
		,wms_geo_postal_rsn					,wms_geo_postal_lantitude				,wms_geo_postal_longitude			,wms_geo_postal_geo_fen_name
		,wms_geo_postal_geo_fen_range		,wms_geo_postal_range_uom
		,etlcreateddatetime
	)
	SELECT 
		wms_geo_country_code				,wms_geo_state_code						,wms_geo_city_code					,wms_geo_postal_code
		,wms_geo_postal_ou					,wms_geo_postal_lineno					,wms_geo_postal_desc				,wms_geo_postal_status
		,wms_geo_postal_rsn					,wms_geo_postal_lantitude				,wms_geo_postal_longitude			,wms_geo_postal_geo_fen_name
		,wms_geo_postal_geo_fen_range		,wms_geo_postal_range_uom
		,etlcreateddatetime
	FROM stg.stg_wms_geo_postal_dtl;
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