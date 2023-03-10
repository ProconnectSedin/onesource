CREATE OR REPLACE PROCEDURE dwh.usp_f_goodsempequipmap(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_gr_emp_equip_map_dtl;
	

	UPDATE dwh.f_goodsEmpEquipMap t
    SET 
		gr_loc_key				=	COALESCE(l.loc_key,-1)
		, gr_shift_code			=	s.wms_gr_shift_code
		, gr_emp_code			=	s.wms_gr_emp_code
		, gr_area				=	s.wms_gr_area
		, etlactiveind 			=	1
		, etljobname 			=	p_etljobname
		, envsourcecd 			=	p_envsourcecd
		, datasourcecd 			=	p_datasourcecd
		, etlupdatedatetime 	=	NOW()	
    FROM stg.stg_wms_gr_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location L 		
		ON s.wms_gr_loc_code 	= L.loc_code
		AND s.wms_gr_ou			= L.loc_ou
	WHERE s.wms_gr_loc_code		= t.gr_loc_cod
        AND s.wms_gr_ou			= t.gr_ou
		AND s.wms_gr_lineno		= t.gr_lineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_goodsEmpEquipMap
	(	gr_loc_key,
	gr_loc_cod			,		gr_ou			,		gr_lineno			,
	gr_shift_code		,		gr_emp_code		,		gr_area				,
	etlactiveind		,		etljobname		,		envsourcecd			,
	datasourcecd		,		etlcreatedatetime
	)
	
	SELECT 
		COALESCE(l.loc_key,-1),
	s.wms_gr_loc_code	,		s.wms_gr_ou			,		s.wms_gr_lineno		,
	s.wms_gr_shift_code	,		s.wms_gr_emp_code	,		s.wms_gr_area		,
	1 AS etlactiveind	,		p_etljobname		,		p_envsourcecd		,
	p_datasourcecd		,		NOW()
      
    FROM stg.stg_wms_gr_emp_equip_map_dtl s
	LEFT JOIN dwh.d_location L 		
		ON s.wms_gr_loc_code 	= L.loc_code
		AND s.wms_gr_ou			= L.loc_ou
	LEFT JOIN dwh.f_goodsEmpEquipMap t
		ON s.wms_gr_loc_code	= t.gr_loc_cod
        AND s.wms_gr_ou			= t.gr_ou
		AND s.wms_gr_lineno		= t.gr_lineno
		WHERE t.gr_loc_cod IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_gr_emp_equip_map_dtl
	( 
			wms_gr_loc_code		,	wms_gr_ou		,		wms_gr_lineno		,
			wms_gr_shift_code	,	wms_gr_emp_code	,		wms_gr_area		,
			etlcreateddatetime
	)
	SELECT 
			wms_gr_loc_code		,	wms_gr_ou		,		wms_gr_lineno		,
			wms_gr_shift_code	,	wms_gr_emp_code	,		wms_gr_area		,
			etlcreateddatetime
	FROM	stg.stg_wms_gr_emp_equip_map_dtl;
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