CREATE PROCEDURE dwh.usp_d_vehiclereginfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_veh_registration_dtl;

	UPDATE dwh.D_VehicleRegInfo t  --Change variables and table name
    SET -- logical column name = s.column name
		veh_address				= s.wms_veh_address,
		veh_title_holder_name	= s.wms_veh_title_holder_name,
		veh_issuing_auth		= s.wms_veh_issuing_auth,
		veh_issuing_location	= s.wms_veh_issuing_location,
		veh_issuing_date		= s.wms_veh_issuing_date,
		veh_exp_date			= s.wms_veh_exp_date,
		veh_remarks				= s.wms_veh_remarks,
		veh_doc_type			= s.wms_veh_doc_type,
		veh_doc_no				= s.wms_veh_doc_no,		
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_veh_registration_dtl s		--staging table name in sheet
    WHERE t.veh_ou	  			= s.wms_veh_ou --unique and primary key
	AND   t.veh_id 				= s.wms_veh_id
	AND   t.veh_line_no			= s.wms_veh_line_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_VehicleRegInfo -- table name
	(-- logical column names except last 5
		veh_ou,							veh_id,						veh_line_no,				veh_address,
		veh_title_holder_name,			veh_issuing_auth,			veh_issuing_location,		veh_issuing_date,
		veh_exp_date,					veh_remarks,veh_doc_type,	veh_doc_no,					etlactiveind,
        etljobname, 					envsourcecd, 				datasourcecd, 				etlcreatedatetime
	)
	
    SELECT  -- normal column name except last 5
		s.wms_veh_ou,					s.wms_veh_id,				s.wms_veh_line_no,			s.wms_veh_address,
		s.wms_veh_title_holder_name,	s.wms_veh_issuing_auth,		s.wms_veh_issuing_location,	s.wms_veh_issuing_date,
		s.wms_veh_exp_date,				s.wms_veh_remarks,			s.wms_veh_doc_type,			s.wms_veh_doc_no,		
		1,		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_wms_veh_registration_dtl s -- staging table name
    LEFT JOIN dwh.D_VehicleRegInfo t -- table name
    ON 	s.wms_veh_ou  			= t.veh_ou -- only unique, no pkeys
	AND s.wms_veh_id 			= t.veh_id
	AND s.wms_veh_line_no		= t.veh_line_no
    WHERE t.veh_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_veh_registration_dtl --  staging table name
	(
	 wms_veh_ou, wms_veh_id, wms_veh_line_no, wms_veh_reg_no, wms_veh_address, wms_veh_title_holder_name,
        wms_veh_issuing_auth, wms_veh_issuing_location, wms_veh_issuing_date, wms_veh_exp_date, wms_veh_remarks, 
        wms_veh_doc_type, wms_veh_doc_no, wms_veh_attachment, wms_veh_attachment_hdn, etlcreateddatetime

	
	)
	SELECT 
		 wms_veh_ou, wms_veh_id, wms_veh_line_no, wms_veh_reg_no, wms_veh_address, wms_veh_title_holder_name,
        wms_veh_issuing_auth, wms_veh_issuing_location, wms_veh_issuing_date, wms_veh_exp_date, wms_veh_remarks, 
        wms_veh_doc_type, wms_veh_doc_no, wms_veh_attachment, wms_veh_attachment_hdn, etlcreateddatetime

	FROM stg.stg_wms_veh_registration_dtl;
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