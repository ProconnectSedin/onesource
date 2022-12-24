CREATE OR REPLACE PROCEDURE dwh.usp_d_equipmentgroup(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_eqp_grp_hdr;

	UPDATE dwh.d_equipmentgroup t
    SET 
		 egrp_desc 				= s.wms_egrp_desc
		,egrp_status 			= s.wms_egrp_status
		,egrp_created_by 		= s.wms_egrp_created_by
		,egrp_created_date 		= s.wms_egrp_created_date
		,egrp_modified_by 		= s.wms_egrp_modified_by
		,egrp_modified_date 	= s.wms_egrp_modified_date
		,egrp_timestamp 		= s.wms_egrp_timestamp
		,etlactiveind 			= 1
		,etljobname 			= p_etljobname
		,envsourcecd 			= p_envsourcecd 
		,datasourcecd 			= p_datasourcecd
		,etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_eqp_grp_hdr s
    WHERE t.egrp_id  			= s.wms_egrp_id
	AND t.egrp_ou 				= s.wms_egrp_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_equipmentgroup
	(
		 egrp_ou			,egrp_id,egrp_desc	,egrp_status		,egrp_created_by		,egrp_created_date	
		,egrp_modified_by	,egrp_modified_date	,egrp_timestamp
		,etlactiveind		,etljobname			,envsourcecd		,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		 s.wms_egrp_ou				,s.wms_egrp_id,egrp_desc	,s.wms_egrp_status		,s.wms_egrp_created_by		,s.wms_egrp_created_date	
		,s.wms_egrp_modified_by		,s.wms_egrp_modified_date	,s.wms_egrp_timestamp
		,1							,p_etljobname				,p_envsourcecd			,p_datasourcecd				,NOW()
	FROM stg.stg_wms_eqp_grp_hdr s
    LEFT JOIN dwh.d_equipmentgroup t
    ON 	s.wms_egrp_id  		= t.egrp_id
	AND s.wms_egrp_ou 		= t.egrp_ou
    WHERE t.egrp_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_eqp_grp_hdr
	(
		wms_egrp_ou, wms_egrp_id, 	wms_egrp_desc, 			wms_egrp_status, 		wms_egrp_reason_code,	wms_egrp_created_by,
		wms_egrp_created_date, 		wms_egrp_modified_by, 	wms_egrp_modified_date, wms_egrp_timestamp, 	wms_egrp_userdefined1,
		wms_egrp_userdefined2, 		wms_egrp_userdefined3, 	etlcreateddatetime
	)
	SELECT 
		wms_egrp_ou, wms_egrp_id, 	wms_egrp_desc, 			wms_egrp_status, 		wms_egrp_reason_code,	wms_egrp_created_by,
		wms_egrp_created_date, 		wms_egrp_modified_by, 	wms_egrp_modified_date, wms_egrp_timestamp, 	wms_egrp_userdefined1,
		wms_egrp_userdefined2, 		wms_egrp_userdefined3, 	etlcreateddatetime
	FROM stg.stg_wms_eqp_grp_hdr;
	
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