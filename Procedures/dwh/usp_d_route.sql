CREATE OR REPLACE PROCEDURE dwh.usp_d_route(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_route_hdr;

	UPDATE dwh.D_Route t
    SET 
		rou_description 		= s.wms_rou_description,
		rou_status 				= s.wms_rou_status,
		rou_rsn_code 			= s.wms_rou_rsn_code,
		rou_trans_mode 			= s.wms_rou_trans_mode,
		rou_serv_type 			= s.wms_rou_serv_type,
		rou_sub_serv_type 		= s.wms_rou_sub_serv_type,
		rou_valid_frm 			= s.wms_rou_valid_frm,
		rou_valid_to 			= s.wms_rou_valid_to,
		rou_created_by 			= s.wms_rou_created_by,
		rou_created_date 		= s.wms_rou_created_date,
		rou_modified_by 		= s.wms_rou_modified_by,
		rou_modified_date 		= s.wms_rou_modified_date,
		rou_timestamp 			= s.wms_rou_timestamp,
		rou_route_type 			= s.wms_rou_route_type,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()		
    FROM stg.stg_wms_route_hdr s
    WHERE t.rou_route_id  		= s.wms_rou_route_id
	AND t.rou_ou 				= s.wms_rou_ou;
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_Route
	(
		rou_route_id, rou_ou, rou_description, rou_status, rou_rsn_code, 
		rou_trans_mode, rou_serv_type, rou_sub_serv_type, rou_valid_frm, 
		rou_valid_to, rou_created_by, rou_created_date, rou_modified_by, 
		rou_modified_date, rou_timestamp, rou_route_type, etlactiveind,
		etljobname, envsourcecd, datasourcecd, etlcreatedatetime
	)
	
    SELECT 
		s.wms_rou_route_id,		 s.wms_rou_ou,				s.wms_rou_description,		s.wms_rou_status, 
		s.wms_rou_rsn_code,		 s.wms_rou_trans_mode,		s.wms_rou_serv_type,		s.wms_rou_sub_serv_type, 
		s.wms_rou_valid_frm,     s.wms_rou_valid_to,		s.wms_rou_created_by,		s.wms_rou_created_date, 
		s.wms_rou_modified_by,   s.wms_rou_modified_date,	s.wms_rou_timestamp,		s.wms_rou_route_type,
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()

	FROM stg.stg_wms_route_hdr s
    LEFT JOIN dwh.D_Route t
    ON 	s.wms_rou_route_id  		= t.rou_route_id
	AND s.wms_rou_ou 				= t.rou_ou 
    WHERE t.rou_route_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_route_hdr
	(
		wms_rou_route_id, wms_rou_ou, wms_rou_description, wms_rou_status, 
		wms_rou_rsn_code, wms_rou_trans_mode, wms_rou_serv_type, wms_rou_sub_serv_type, 
		wms_rou_valid_frm, wms_rou_valid_to, wms_rou_created_by, wms_rou_created_date, 
		wms_rou_modified_by, wms_rou_modified_date, wms_rou_timestamp, 
		wms_rou_userdefined1, wms_rou_userdefined2, wms_rou_userdefined3, 
		wms_rou_route_type, etlcreateddatetime		
	)
	SELECT 
		wms_rou_route_id, wms_rou_ou, wms_rou_description, wms_rou_status, 
		wms_rou_rsn_code, wms_rou_trans_mode, wms_rou_serv_type, wms_rou_sub_serv_type, 
		wms_rou_valid_frm, wms_rou_valid_to, wms_rou_created_by, wms_rou_created_date, 
		wms_rou_modified_by, wms_rou_modified_date, wms_rou_timestamp, 
		wms_rou_userdefined1, wms_rou_userdefined2, wms_rou_userdefined3, 
		wms_rou_route_type, etlcreateddatetime	
	FROM stg.stg_wms_route_hdr;
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