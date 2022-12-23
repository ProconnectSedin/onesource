CREATE PROCEDURE dwh.usp_d_shippingpoint(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_shp_point_hdr;

	UPDATE dwh.D_ShippingPoint t
    SET 
		shp_pt_desc				= s.wms_shp_pt_desc,
		shp_pt_status			= s.wms_shp_pt_status,
		shp_pt_rsn_code			= s.wms_shp_pt_rsn_code,
		shp_pt_address1			= s.wms_shp_pt_address1,
		shp_pt_address2			= s.wms_shp_pt_address2,
		shp_pt_zipcode			= s.wms_shp_pt_zipcode,
		shp_pt_city				= s.wms_shp_pt_city,
		shp_pt_state			= s.wms_shp_pt_state,
		shp_pt_country			= s.wms_shp_pt_country,
		shp_pt_email			= s.wms_shp_pt_email,
		shp_pt_timestamp		= s.wms_shp_pt_timestamp,
		shp_pt_created_by		= s.wms_shp_pt_created_by,
		shp_pt_created_date		= s.wms_shp_pt_created_date,
		shp_pt_modified_by		= s.wms_shp_pt_modified_by,
		shp_pt_modified_date	= s.wms_shp_pt_modified_date,
		shp_pt_address3			= s.wms_shp_pt_address3,
		shp_pt_contact_person	= s.wms_shp_pt_contact_person,
		shp_pt_fax				= s.wms_shp_pt_fax,
		shp_pt_latitude			= s.wms_shp_pt_latitude,
		shp_pt_longitude		= s.wms_shp_pt_longitude,
		shp_pt_phone1			= s.wms_shp_pt_phone1,
		shp_pt_phone2			= s.wms_shp_pt_phone2,
		shp_pt_region			= s.wms_shp_pt_region,
		shp_pt_zone				= s.wms_shp_pt_zone,
		shp_pt_sub_zone			= s.wms_shp_pt_sub_zone,
		shp_pt_time_zone		= s.wms_shp_pt_time_zone,
		shp_pt_url				= s.wms_shp_pt_url,
		shp_pt_suburb_code		= s.wms_shp_pt_suburb_code,
		shp_pt_time_slot		= s.wms_shp_pt_time_slot,
		shp_pt_time_slot_uom	= s.wms_shp_pt_time_slot_uom,
		shp_pt_wh				= s.wms_shp_pt_wh,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_shp_point_hdr s
    WHERE t.shp_pt_ou = s.wms_shp_pt_ou 
		and t.shp_pt_id = s.wms_shp_pt_id;

	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_ShippingPoint

	(
		shp_pt_ou,				shp_pt_id,				shp_pt_desc,		shp_pt_status,			shp_pt_rsn_code,		
		shp_pt_address1,		shp_pt_address2,		shp_pt_zipcode,		shp_pt_city,			shp_pt_state,
		shp_pt_country,			shp_pt_email,			shp_pt_timestamp,	shp_pt_created_by,		shp_pt_created_date,
		shp_pt_modified_by,		shp_pt_modified_date,	shp_pt_address3,	shp_pt_contact_person,	shp_pt_fax,			
		shp_pt_latitude,		shp_pt_longitude,		shp_pt_phone1,		shp_pt_phone2,			shp_pt_region,			
		shp_pt_zone,			shp_pt_sub_zone,		shp_pt_time_zone,	shp_pt_url,				shp_pt_suburb_code,
		shp_pt_time_slot,		shp_pt_time_slot_uom,	shp_pt_wh, 			etlactiveind,      		etljobname, 			
		envsourcecd,			datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
	s.wms_shp_pt_ou,			s.wms_shp_pt_id, 			s.wms_shp_pt_desc, 			s.wms_shp_pt_status, 	
	s.wms_shp_pt_rsn_code,		s.wms_shp_pt_address1, 		s.wms_shp_pt_address2,		s.wms_shp_pt_zipcode, 		
	s.wms_shp_pt_city, 			s.wms_shp_pt_state,			s.wms_shp_pt_country, 		s.wms_shp_pt_email, 	
	s.wms_shp_pt_timestamp,		s.wms_shp_pt_created_by,	s.wms_shp_pt_created_date, 	s.wms_shp_pt_modified_by, 
	s.wms_shp_pt_modified_date, s.wms_shp_pt_address3,		s.wms_shp_pt_contact_person,s.wms_shp_pt_fax,
	s.wms_shp_pt_latitude,		s.wms_shp_pt_longitude,		s.wms_shp_pt_phone1,		s.wms_shp_pt_phone2,
	s.wms_shp_pt_region,	 	s.wms_shp_pt_zone, 			s.wms_shp_pt_sub_zone, 		s.wms_shp_pt_time_zone, 
	s.wms_shp_pt_url,			s.wms_shp_pt_suburb_code,	s.wms_shp_pt_time_slot, 	s.wms_shp_pt_time_slot_uom, 
	s.wms_shp_pt_wh,			1,							p_etljobname,				p_envsourcecd,		
	p_datasourcecd,				NOW()
	FROM stg.stg_wms_shp_point_hdr s
    LEFT JOIN dwh.D_ShippingPoint t
    ON 	 s.wms_shp_pt_ou = t.shp_pt_ou
		and s.wms_shp_pt_id  = t.shp_pt_id 
    WHERE t.shp_pt_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_shp_point_hdr
	(
	 wms_shp_pt_ou, wms_shp_pt_id, wms_shp_pt_desc, wms_shp_pt_status, wms_shp_pt_rsn_code, wms_shp_pt_address1, 
        wms_shp_pt_address2, wms_shp_pt_zipcode, wms_shp_pt_city, wms_shp_pt_state, wms_shp_pt_country, 
        wms_shp_pt_email, wms_shp_pt_timestamp, wms_shp_pt_created_by, wms_shp_pt_created_date, 
        wms_shp_pt_modified_by, wms_shp_pt_modified_date, wms_shp_pt_userdefined1, wms_shp_pt_userdefined2, 
        wms_shp_pt_userdefined3, wms_shp_pt_address3, wms_shp_pt_contact_person, wms_shp_pt_fax, 
        wms_shp_pt_geo_fence_name, wms_shp_pt_geo_fence_range, wms_shp_pt_geo_fence_type, wms_shp_pt_latitude, 
        wms_shp_pt_longitude, wms_shp_pt_phone1, wms_shp_pt_phone2, wms_shp_pt_region, wms_shp_pt_zone, 
        wms_shp_pt_sub_zone, wms_shp_pt_time_zone, wms_shp_pt_url, wms_shp_pt_suburb_code, wms_shp_pt_time_slot, 
        wms_shp_pt_time_slot_uom, wms_shp_pt_congid, wms_shp_pt_wh, wms_shp_pt_type, etlcreateddatetime

	)
	SELECT 
	wms_shp_pt_ou, wms_shp_pt_id, wms_shp_pt_desc, wms_shp_pt_status, wms_shp_pt_rsn_code, wms_shp_pt_address1, 
        wms_shp_pt_address2, wms_shp_pt_zipcode, wms_shp_pt_city, wms_shp_pt_state, wms_shp_pt_country, 
        wms_shp_pt_email, wms_shp_pt_timestamp, wms_shp_pt_created_by, wms_shp_pt_created_date, 
        wms_shp_pt_modified_by, wms_shp_pt_modified_date, wms_shp_pt_userdefined1, wms_shp_pt_userdefined2, 
        wms_shp_pt_userdefined3, wms_shp_pt_address3, wms_shp_pt_contact_person, wms_shp_pt_fax, 
        wms_shp_pt_geo_fence_name, wms_shp_pt_geo_fence_range, wms_shp_pt_geo_fence_type, wms_shp_pt_latitude, 
        wms_shp_pt_longitude, wms_shp_pt_phone1, wms_shp_pt_phone2, wms_shp_pt_region, wms_shp_pt_zone, 
        wms_shp_pt_sub_zone, wms_shp_pt_time_zone, wms_shp_pt_url, wms_shp_pt_suburb_code, wms_shp_pt_time_slot, 
        wms_shp_pt_time_slot_uom, wms_shp_pt_congid, wms_shp_pt_wh, wms_shp_pt_type, etlcreateddatetime

	FROM stg.stg_wms_shp_point_hdr;
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