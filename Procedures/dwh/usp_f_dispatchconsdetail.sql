CREATE PROCEDURE dwh.usp_f_dispatchconsdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid 		= h.sourceid
    WHERE d.sourceid 		= p_sourceId
        AND d.dataflowflag 	= p_dataflowflag
        AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_disp_cons_dtl;

    UPDATE dwh.f_dispatchconsdetail t
    SET
        disp_con_loc_key 			= COALESCE(l.loc_key,-1),
        disp_con_customer_key 		= COALESCE(c.customer_key,-1),
        disp_profile_code 			= s.wms_disp_profile_code,
        disp_customer 				= s.wms_disp_customer,
        disp_lsp 					= s.wms_disp_lsp,
        disp_ship_mode 				= s.wms_disp_ship_mode,
        disp_route 					= s.wms_disp_route,
        disp_ship_point 			= s.wms_disp_ship_point,
        disp_thuid 					= s.wms_disp_thuid,
        disp_delivery_date 			= s.wms_disp_delivery_date,
        etlactiveind 				= 1,
        etljobname 					= p_etljobname,
        envsourcecd 				= p_envsourcecd ,
        datasourcecd 				= p_datasourcecd ,
        etlupdatedatetime 			= NOW()    
    FROM stg.stg_wms_disp_cons_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_disp_location 	= l.loc_code
		AND s.wms_disp_ou			= l.loc_ou
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_disp_customer 	= c.customer_id
		AND s.wms_disp_ou			= c.customer_ou	
    WHERE   t.disp_location 		= s.wms_disp_location
		AND t.disp_ou 				= s.wms_disp_ou
		AND t.disp_lineno 			= s.wms_disp_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_dispatchconsdetail
    (
        disp_con_loc_key			, disp_con_customer_key			, disp_location			, disp_ou, 
		disp_lineno					, disp_profile_code				, disp_customer			, disp_lsp, 
		disp_ship_mode				, disp_route					, disp_ship_point		, disp_thuid, 
		disp_delivery_date			, etlactiveind					, etljobname			, envsourcecd, 
		datasourcecd				, etlcreatedatetime
    )	
		
    SELECT	
        COALESCE(l.loc_key,-1)		, COALESCE(c.customer_key,-1)	, s.wms_disp_location	, s.wms_disp_ou, 
		s.wms_disp_lineno			, s.wms_disp_profile_code		, s.wms_disp_customer	, s.wms_disp_lsp, 
		s.wms_disp_ship_mode		, s.wms_disp_route				, s.wms_disp_ship_point	, s.wms_disp_thuid, 
		s.wms_disp_delivery_date	, 1								, p_etljobname			, p_envsourcecd, 
		p_datasourcecd				, NOW()
    FROM stg.stg_wms_disp_cons_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_disp_location 	= l.loc_code
		AND s.wms_disp_ou			= l.loc_ou
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_disp_customer 	= c.customer_id
		AND s.wms_disp_ou			= c.customer_ou
	LEFT JOIN dwh.f_dispatchconsdetail t
		ON  s.wms_disp_location 	= t.disp_location
		AND s.wms_disp_ou 			= t.disp_ou
		AND s.wms_disp_lineno 		= t.disp_lineno
    WHERE t.disp_location IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_disp_cons_dtl
    (
        wms_disp_location	, wms_disp_ou		, wms_disp_lineno			, wms_disp_profile_code, 
		wms_disp_customer	, wms_disp_lsp		, wms_disp_ship_mode		, wms_disp_route, 
		wms_disp_ship_point	, wms_disp_thuid	, wms_disp_delivery_date	, etlcreateddatetime
    )		
    SELECT		
        wms_disp_location	, wms_disp_ou		, wms_disp_lineno			, wms_disp_profile_code, 
		wms_disp_customer	, wms_disp_lsp		, wms_disp_ship_mode		, wms_disp_route, 
		wms_disp_ship_point	, wms_disp_thuid	, wms_disp_delivery_date	, etlcreateddatetime
    FROM stg.stg_wms_disp_cons_dtl;
    END IF;

    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$$;