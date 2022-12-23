CREATE PROCEDURE dwh.usp_f_dispatchheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_dispatch_hdr;

    UPDATE dwh.F_DispatchHeader t
    SET
		dispatch_hdr_loc_key			= COALESCE(l.loc_key,-1),
		dispatch_hdr_veh_key			= COALESCE(v.veh_key,-1),	
        dispatch_ld_sheet_date 			= s.wms_dispatch_ld_sheet_date,
        dispatch_ld_sheet_status 		= s.wms_dispatch_ld_sheet_status,
        dispatch_staging_id 			= s.wms_dispatch_staging_id,
        dispatch_lsp 					= s.wms_dispatch_lsp,
        dispatch_source_stage 			= s.wms_dispatch_source_stage,
        dispatch_source_docno 			= s.wms_dispatch_source_docno,
        dispatch_created_by 			= s.wms_dispatch_created_by,
        dispatch_created_date 			= s.wms_dispatch_created_date,
        dispatch_modified_by 			= s.wms_dispatch_modified_by,
        dispatch_modified_date 			= s.wms_dispatch_modified_date,
        dispatch_timestamp 				= s.wms_dispatch_timestamp,
        dispatch_booking_req_no 		= s.wms_dispatch_booking_req_no,
        pack_disp_urgent 				= s.wms_pack_disp_urgent,
        dispatch_doc_code 				= s.wms_dispatch_doc_code,
        dispatch_vehicle_code 			= s.wms_dispatch_vehicle_code,
        dispatch_reason_code 			= s.wms_dispatch_reason_code,
        etlactiveind 					= 1,
        etljobname 						= p_etljobname,
        envsourcecd 					= p_envsourcecd ,
        datasourcecd 					= p_datasourcecd ,
        etlupdatedatetime 				= NOW()    
    FROM stg.stg_wms_dispatch_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_dispatch_loc_code 		= l.loc_code
		AND s.wms_dispatch_ld_sheet_ou 		= l.loc_ou
	LEFT JOIN dwh.d_vehicle v
		ON  s.wms_dispatch_vehicle_code 	= v.veh_id
		AND s.wms_dispatch_ld_sheet_ou 		= v.veh_ou
	WHERE   t.dispatch_loc_code 			= s.wms_dispatch_loc_code
		AND t.dispatch_ld_sheet_no 			= s.wms_dispatch_ld_sheet_no
		AND t.dispatch_ld_sheet_ou 			= s.wms_dispatch_ld_sheet_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchHeader 
    (
        dispatch_hdr_loc_key			, dispatch_hdr_veh_key			, dispatch_loc_code					, dispatch_ld_sheet_no, 
		dispatch_ld_sheet_ou			, dispatch_ld_sheet_date		, dispatch_ld_sheet_status			, dispatch_staging_id, 
		dispatch_lsp					, dispatch_source_stage			, dispatch_source_docno				, dispatch_created_by, 
		dispatch_created_date			, dispatch_modified_by			, dispatch_modified_date			, dispatch_timestamp, 
		dispatch_booking_req_no			, pack_disp_urgent				, dispatch_doc_code					, dispatch_vehicle_code, 
		dispatch_reason_code			, etlactiveind					, etljobname						, envsourcecd, 
		datasourcecd					, etlcreatedatetime	
    )	
		
    SELECT	
		COALESCE(l.loc_key,-1)			, COALESCE(v.veh_key,-1)		, s.wms_dispatch_loc_code			, s.wms_dispatch_ld_sheet_no, 
		s.wms_dispatch_ld_sheet_ou		, s.wms_dispatch_ld_sheet_date	, s.wms_dispatch_ld_sheet_status	, s.wms_dispatch_staging_id, 
		s.wms_dispatch_lsp				, s.wms_dispatch_source_stage	, s.wms_dispatch_source_docno		, s.wms_dispatch_created_by, 
		s.wms_dispatch_created_date		, s.wms_dispatch_modified_by	, s.wms_dispatch_modified_date		, s.wms_dispatch_timestamp, 
		s.wms_dispatch_booking_req_no	, s.wms_pack_disp_urgent		, s.wms_dispatch_doc_code			, s.wms_dispatch_vehicle_code, 
		s.wms_dispatch_reason_code		, 1								, p_etljobname						, p_envsourcecd, 
		p_datasourcecd					, NOW()
    FROM stg.stg_wms_dispatch_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_dispatch_loc_code 		= l.loc_code
		AND s.wms_dispatch_ld_sheet_ou 		= l.loc_ou
	LEFT JOIN dwh.d_vehicle v
		ON  s.wms_dispatch_vehicle_code 	= v.veh_id
		AND s.wms_dispatch_ld_sheet_ou 		= v.veh_ou	
    LEFT JOIN dwh.F_DispatchHeader t
		ON  s.wms_dispatch_loc_code 		= t.dispatch_loc_code
		AND s.wms_dispatch_ld_sheet_no 		= t.dispatch_ld_sheet_no
		AND s.wms_dispatch_ld_sheet_ou 		= t.dispatch_ld_sheet_ou
    WHERE t.dispatch_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_dispatch_hdr
    (   
        wms_dispatch_loc_code			, wms_dispatch_ld_sheet_no		, wms_dispatch_ld_sheet_ou	, wms_dispatch_ld_sheet_date, 
		wms_dispatch_ld_sheet_status	, wms_dispatch_staging_id		, wms_dispatch_lsp			, wms_dispatch_source_stage, 
		wms_dispatch_source_docno		, wms_dispatch_created_by		, wms_dispatch_created_date	, wms_dispatch_modified_by, 
		wms_dispatch_modified_date		, wms_dispatch_timestamp		, wms_dispatch_userdefined1	, wms_dispatch_userdefined2, 
		wms_dispatch_userdefined3		, wms_dispatch_booking_req_no	, wms_pack_disp_urgent		, wms_dispatch_doc_code, 
		wms_dispatch_vehicle_code		, wms_dispatch_reason_code		,etlcreateddatetime
    )
    SELECT 
        wms_dispatch_loc_code			, wms_dispatch_ld_sheet_no		, wms_dispatch_ld_sheet_ou	, wms_dispatch_ld_sheet_date, 
		wms_dispatch_ld_sheet_status	, wms_dispatch_staging_id		, wms_dispatch_lsp			, wms_dispatch_source_stage, 
		wms_dispatch_source_docno		, wms_dispatch_created_by		, wms_dispatch_created_date	, wms_dispatch_modified_by, 
		wms_dispatch_modified_date		, wms_dispatch_timestamp		, wms_dispatch_userdefined1	, wms_dispatch_userdefined2, 
		wms_dispatch_userdefined3		, wms_dispatch_booking_req_no	, wms_pack_disp_urgent		, wms_dispatch_doc_code, 
		wms_dispatch_vehicle_code		, wms_dispatch_reason_code		,etlcreateddatetime    
	FROM stg.stg_wms_dispatch_hdr;    
    END IF;

    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
        
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$$;