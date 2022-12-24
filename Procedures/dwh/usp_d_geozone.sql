CREATE OR REPLACE PROCEDURE dwh.usp_d_geozone(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_geo_zone_hdr;

	UPDATE dwh.d_geozone t
    SET 
		geo_zone_desc           = s.wms_geo_zone_desc    ,
		geo_zone_stat           = s.wms_geo_zone_stat    ,
		geo_zone_rsn            = s.wms_geo_zone_rsn    ,
		geo_zone_created_by     = s.wms_geo_zone_created_by    ,
		geo_zone_created_date   = s.wms_geo_zone_created_date    ,
		geo_zone_modified_by    = s.wms_geo_zone_modified_by    ,
		geo_zone_modified_date  = s.wms_geo_zone_modified_date    ,
		geo_zone_timestamp      = s.wms_geo_zone_timestamp    ,
        etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_geo_zone_hdr s
    WHERE t.geo_zone  		= s.wms_geo_zone
	AND t.geo_zone_ou 	    = s.wms_geo_zone_ou;
	
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_geozone
	(
		geo_zone,					geo_zone_ou,				geo_zone_desc,			geo_zone_stat,				geo_zone_rsn,
        geo_zone_created_by,		geo_zone_created_date,		geo_zone_modified_by,	geo_zone_modified_date,		geo_zone_timestamp,
        etlactiveind,               etljobname, 		        envsourcecd, 	        datasourcecd, 			    etlcreatedatetime
	)
	
    SELECT 
		s.wms_geo_zone,					s.wms_geo_zone_ou,				    s.wms_geo_zone_desc,			s.wms_geo_zone_stat,				s.wms_geo_zone_rsn,
        s.wms_geo_zone_created_by,		s.wms_geo_zone_created_date,		s.wms_geo_zone_modified_by,	    s.wms_geo_zone_modified_date,		s.wms_geo_zone_timestamp,
        1,                              p_etljobname,		                p_envsourcecd,		            p_datasourcecd,			            NOW()
	FROM stg.stg_wms_geo_zone_hdr s
    LEFT JOIN dwh.d_geozone t
    ON 	t.geo_zone  		= s.wms_geo_zone
	AND t.geo_zone_ou 	    = s.wms_geo_zone_ou
    WHERE t.geo_zone IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_geo_zone_hdr
	(
        wms_geo_zone, wms_geo_zone_ou, wms_geo_zone_desc, wms_geo_zone_stat, wms_geo_zone_rsn, 
        wms_geo_zone_created_by, wms_geo_zone_created_date, wms_geo_zone_modified_by,
        wms_geo_zone_modified_date, wms_geo_zone_timestamp, wms_geo_zone_userdefined1, 
        wms_geo_zone_userdefined2, wms_geo_zone_userdefined3, etlcreateddatetime

     )
	SELECT 
        wms_geo_zone, wms_geo_zone_ou, wms_geo_zone_desc, wms_geo_zone_stat, wms_geo_zone_rsn, 
        wms_geo_zone_created_by, wms_geo_zone_created_date, wms_geo_zone_modified_by,
        wms_geo_zone_modified_date, wms_geo_zone_timestamp, wms_geo_zone_userdefined1, 
        wms_geo_zone_userdefined2, wms_geo_zone_userdefined3, etlcreateddatetime

	FROM stg.stg_wms_geo_zone_hdr;
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