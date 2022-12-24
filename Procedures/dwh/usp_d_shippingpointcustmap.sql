CREATE OR REPLACE PROCEDURE dwh.usp_d_shippingpointcustmap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_shp_point_cusmap_dtl;

	UPDATE dwh.D_ShippingPointCustMap t
    SET 
		
		shp_pt_cusid 			= wms_shp_pt_cusid,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_shp_point_cusmap_dtl s
    WHERE t.shp_pt_ou		= s.wms_shp_pt_ou
	AND t.shp_pt_id 		= s.wms_shp_pt_id
	AND t.shp_pt_lineno		= s.wms_shp_pt_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_ShippingPointCustMap
	(
	shp_pt_ou,			shp_pt_id,			shp_pt_lineno,		shp_pt_cusid,
	etlactiveind,   	etljobname,	 		envsourcecd, 		datasourcecd, 	etlcreatedatetime
	)
	
    SELECT 
	wms_shp_pt_ou,		wms_shp_pt_id,		wms_shp_pt_lineno,	wms_shp_pt_cusid,	
	1,					p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()

	FROM stg.stg_wms_shp_point_cusmap_dtl s
    LEFT JOIN dwh.D_ShippingPointCustMap t
    ON 	s.wms_shp_pt_ou		 	= t.shp_pt_ou
	AND s.wms_shp_pt_id 		= t.shp_pt_id
	AND s.wms_shp_pt_lineno		= t.shp_pt_lineno
    WHERE t.shp_pt_ou	IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_shp_point_cusmap_dtl
	(
	 wms_shp_pt_ou, 		wms_shp_pt_id, 
	 wms_shp_pt_lineno, 	wms_shp_pt_cusid, 	etlcreateddatetime

	)
	SELECT 
	 wms_shp_pt_ou, 		wms_shp_pt_id, 
	 wms_shp_pt_lineno, 	wms_shp_pt_cusid, 	etlcreateddatetime	
	FROM stg.stg_wms_shp_point_cusmap_dtl;
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