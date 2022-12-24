CREATE OR REPLACE PROCEDURE dwh.usp_d_consignor(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_consignor_hdr;

	UPDATE dwh.d_consignor t
    SET 
		 consignor_desc 			= s.wms_consignor_desc
		,consignor_status 			= s.wms_consignor_status
		,consignor_currency 		= s.wms_consignor_currency
		,consignor_address1 		= s.wms_consignor_address1
		,consignor_address2 		= s.wms_consignor_address2
		,consignor_address3 		= s.wms_consignor_address3
		,consignor_city 			= s.wms_consignor_city
		,consignor_state 			= s.wms_consignor_state
		,consignor_country 			= s.wms_consignor_country
		,consignor_postalcode 		= s.wms_consignor_postalcode
		,consignor_phone1 			= s.wms_consignor_phone1
		,consignor_customer_id 		= s.wms_consignor_customer_id
		,consignor_created_by 		= s.wms_consignor_created_by
		,consignor_created_date 	= s.wms_consignor_created_date
		,consignor_modified_by 		= s.wms_consignor_modified_by
		,consignor_modified_date	= s.wms_consignor_modified_date
		,consignor_timestamp 		= s.wms_consignor_timestamp
		,etlactiveind 				= 1
		,etljobname 				= p_etljobname
		,envsourcecd 				= p_envsourcecd 
		,datasourcecd 				= p_datasourcecd
		,etlupdatedatetime 			= NOW()
    FROM stg.stg_wms_consignor_hdr s
    WHERE t.consignor_id  			= s.wms_consignor_id
	AND t.consignor_ou 				= s.wms_consignor_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_consignor
	(
		 consignor_id			,consignor_ou			,consignor_desc			,consignor_status		,consignor_currency
		,consignor_address1		,consignor_address2		,consignor_address3		,consignor_city			,consignor_state
		,consignor_country		,consignor_postalcode	,consignor_phone1		,consignor_customer_id	,consignor_created_by
		,consignor_created_date	,consignor_modified_by	,consignor_modified_date,consignor_timestamp
		,etlactiveind			,etljobname				,envsourcecd			,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		 s.wms_consignor_id				,s.wms_consignor_ou				,s.wms_consignor_desc			,s.wms_consignor_status			,s.wms_consignor_currency
		,s.wms_consignor_address1		,s.wms_consignor_address2		,s.wms_consignor_address3		,s.wms_consignor_city			,s.wms_consignor_state
		,s.wms_consignor_country		,s.wms_consignor_postalcode		,s.wms_consignor_phone1			,s.wms_consignor_customer_id	,s.wms_consignor_created_by
		,s.wms_consignor_created_date	,s.wms_consignor_modified_by	,s.wms_consignor_modified_date	,s.wms_consignor_timestamp	
		,1								,p_etljobname					,p_envsourcecd					,p_datasourcecd					,NOW()
	FROM stg.stg_wms_consignor_hdr s
    LEFT JOIN dwh.d_consignor t
    ON 	s.wms_consignor_id  		= t.consignor_id
	AND s.wms_consignor_ou 			= t.consignor_ou
    WHERE t.consignor_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_consignor_hdr
	(
		wms_consignor_id, 				wms_consignor_ou, 			wms_consignor_desc, 		wms_consignor_status, 		wms_consignor_currency, 
		wms_consignor_payterm, 			wms_consignor_reasoncode, 	wms_consignor_address1, 	wms_consignor_address2, 	wms_consignor_address3, 
		wms_consignor_uniqueaddressid, 	wms_consignor_city, 		wms_consignor_state, 		wms_consignor_country, 		wms_consignor_postalcode, 
		wms_consignor_phone1, 			wms_consignor_fax, 			wms_consignor_contactperson,wms_consignor_customer_id, 	wms_consignor_created_by, 
		wms_consignor_created_date,	 	wms_consignor_modified_by, 	wms_consignor_modified_date,wms_consignor_timestamp, 	wms_consignor_userdefined1, 
		wms_consignor_userdefined2, 	wms_consignor_userdefined3, wms_consignor_zone, 		wms_consignor_subzone, 		wms_consignor_region, 
		wms_consignor_timezone, 		wms_consignor_latitude, 	wms_consignor_longitude, 	wms_consignor_geofencerange,wms_consignor_geofencename, 
		wms_consignor_phone2, 			wms_consignor_url, 			wms_consignor_email, 		wms_consignor_uom,			etlcreateddatetime
	)
	SELECT 
		wms_consignor_id, 				wms_consignor_ou, 			wms_consignor_desc, 		wms_consignor_status, 		wms_consignor_currency, 
		wms_consignor_payterm, 			wms_consignor_reasoncode, 	wms_consignor_address1, 	wms_consignor_address2, 	wms_consignor_address3, 
		wms_consignor_uniqueaddressid, 	wms_consignor_city, 		wms_consignor_state, 		wms_consignor_country, 		wms_consignor_postalcode, 
		wms_consignor_phone1, 			wms_consignor_fax, 			wms_consignor_contactperson,wms_consignor_customer_id, 	wms_consignor_created_by, 
		wms_consignor_created_date,	 	wms_consignor_modified_by, 	wms_consignor_modified_date,wms_consignor_timestamp, 	wms_consignor_userdefined1, 
		wms_consignor_userdefined2, 	wms_consignor_userdefined3, wms_consignor_zone, 		wms_consignor_subzone, 		wms_consignor_region, 
		wms_consignor_timezone, 		wms_consignor_latitude, 	wms_consignor_longitude, 	wms_consignor_geofencerange,wms_consignor_geofencename, 
		wms_consignor_phone2, 			wms_consignor_url, 			wms_consignor_email, 		wms_consignor_uom,			etlcreateddatetime
	FROM stg.stg_wms_consignor_hdr;
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