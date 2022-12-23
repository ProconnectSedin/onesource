CREATE PROCEDURE dwh.usp_d_location(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_loc_location_hdr;

	UPDATE dwh.d_location t
    SET 
         div_key                = COALESCE(fh.div_key,-1)
        ,div_code               = left(s.wms_loc_code,6)
		,loc_desc 				= s.wms_loc_desc
		,loc_status 			= s.wms_loc_status
		,loc_type 				= s.wms_loc_type
		,reason_code 			= s.wms_reason_code
		,finance_book 			= s.wms_finance_book
		,costcenter 			= s.wms_costcenter
		,address1 				= s.wms_address1
		,address2 				= s.wms_address2
		,country 				= s.wms_country
		,state 					= s.wms_state
		,city 					= s.wms_city
		,zip_code 				= s.wms_zip_code
		,contperson 			= s.wms_contperson
		,contact_no 			= s.wms_contact_no
		,time_zone_id 			= s.wms_time_zone_id
		,loc_lat 				= s.wms_loc_lat
		,loc_long 				= s.wms_loc_long
		,ltimestamp 			= s.wms_timestamp
		,created_by 			= s.wms_created_by
		,created_dt 			= s.wms_created_dt
		,modified_by 			= s.wms_modified_by
		,modified_dt 			= s.wms_modified_dt
		,def_plan_mode 			= s.wms_def_plan_mode
		,loc_shp_point 			= s.wms_loc_shp_point
		,loc_cubing 			= s.wms_loc_cubing
		,blanket_count_sa 		= s.wms_blanket_count_sa
		,enable_uid_prof 		= s.wms_enable_uid_prof
		,loc_linked_hub 		= s.wms_loc_linked_hub
		,loc_enable_bin_chkbit 	= s.wms_loc_enable_bin_chkbit
		,etlactiveind 			= 1
		,etljobname 			= p_etljobname
		,envsourcecd 			= p_envsourcecd 
		,datasourcecd 			= p_datasourcecd
		,etlupdatedatetime 		= NOW()
    FROM stg.stg_wms_loc_location_hdr s
    LEFT JOIN dwh.d_division fh 	
        on  fh.div_ou       = s.wms_loc_ou
        and fh.div_code     = left(s.wms_loc_code,6)
    WHERE t.loc_code  			= s.wms_loc_code
	AND t.loc_ou 				= s.wms_loc_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_location
	(
		div_key, div_code,  loc_ou			,loc_code		,loc_desc			,loc_status			,loc_type
		,reason_code	,finance_book	,costcenter			,address1			,address2
		,country		,state			,city				,zip_code			,contperson
		,contact_no		,time_zone_id	,loc_lat			,loc_long			,ltimestamp
		,created_by		,created_dt		,modified_by		,modified_dt		,def_plan_mode
		,loc_shp_point	,loc_cubing		,blanket_count_sa	,enable_uid_prof	,loc_linked_hub		,loc_enable_bin_chkbit
		,etlactiveind	,etljobname		,envsourcecd		,datasourcecd		,etlcreatedatetime
	)
	
    SELECT 
		 COALESCE(fh.div_key,-1),left(s.wms_loc_code,6) ,s.wms_loc_ou			,s.wms_loc_code			,s.wms_loc_desc			,s.wms_loc_status		,s.wms_loc_type
		,s.wms_reason_code		,s.wms_finance_book		,s.wms_costcenter		,s.wms_address1			,s.wms_address2
		,s.wms_country			,s.wms_state			,s.wms_city				,s.wms_zip_code			,s.wms_contperson
		,s.wms_contact_no		,s.wms_time_zone_id		,s.wms_loc_lat			,s.wms_loc_long			,s.wms_timestamp
		,s.wms_created_by		,s.wms_created_dt		,s.wms_modified_by		,s.wms_modified_dt		,s.wms_def_plan_mode
		,s.wms_loc_shp_point	,s.wms_loc_cubing		,s.wms_blanket_count_sa	,s.wms_enable_uid_prof	,s.wms_loc_linked_hub		,s.wms_loc_enable_bin_chkbit
		,1						,p_etljobname			,p_envsourcecd			,p_datasourcecd			,NOW()
	FROM stg.stg_wms_loc_location_hdr s
    LEFT JOIN dwh.d_division fh 	
        on  fh.div_ou       = s.wms_loc_ou
        and fh.div_code     = left(s.wms_loc_code,6)
    LEFT JOIN dwh.d_location t
    ON 	s.wms_loc_code  		= t.loc_code
	AND s.wms_loc_ou 			= t.loc_ou
    WHERE t.loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_loc_location_hdr
	(
		wms_loc_ou, 				wms_loc_code, 				wms_loc_desc, 		wms_loc_status, 		wms_loc_type, 
		wms_reason_code, 			wms_finance_book, 			wms_costcenter, 	wms_account_code, 		wms_address1, 
		wms_address2, 				wms_country, 				wms_state, 			wms_city, 				wms_zip_code, 
		wms_contperson, 			wms_contact_no, 			wms_email, 			wms_fax, 				wms_time_zone_id, 
		wms_loc_lat, 				wms_loc_long, 				wms_user_def1, 		wms_user_def2, 			wms_user_def3, 
		wms_timestamp, 				wms_created_by, 			wms_created_dt, 	wms_modified_by, 		wms_modified_dt, 
		wms_def_plan_mode, 			wms_loc_shp_point, 			wms_loc_warhouse, 	wms_loc_yard, 			wms_loc_veh_id, 
		wms_loc_veh_type, 			wms_loc_auto_cr_tug_trip, 	wms_loc_cubing, 	wms_loc_default_thu_id, wms_blanket_count_sa, 
		wms_enable_uid_prof, 		wms_loc_linked_hub, 		wms_bank_code, 		wms_cash_code, 			wms_loc_default_ethu, 
		wms_loc_enable_bin_chkbit, 	etlcreateddatetime
	)
	SELECT 
		wms_loc_ou, 				wms_loc_code, 				wms_loc_desc, 		wms_loc_status, 		wms_loc_type, 
		wms_reason_code, 			wms_finance_book, 			wms_costcenter, 	wms_account_code, 		wms_address1, 
		wms_address2, 				wms_country, 				wms_state, 			wms_city, 				wms_zip_code, 
		wms_contperson, 			wms_contact_no, 			wms_email, 			wms_fax, 				wms_time_zone_id, 
		wms_loc_lat, 				wms_loc_long, 				wms_user_def1, 		wms_user_def2, 			wms_user_def3, 
		wms_timestamp, 				wms_created_by, 			wms_created_dt, 	wms_modified_by, 		wms_modified_dt, 
		wms_def_plan_mode, 			wms_loc_shp_point, 			wms_loc_warhouse, 	wms_loc_yard, 			wms_loc_veh_id, 
		wms_loc_veh_type, 			wms_loc_auto_cr_tug_trip, 	wms_loc_cubing, 	wms_loc_default_thu_id, wms_blanket_count_sa, 
		wms_enable_uid_prof, 		wms_loc_linked_hub, 		wms_bank_code, 		wms_cash_code, 			wms_loc_default_ethu, 
		wms_loc_enable_bin_chkbit, 	etlcreateddatetime
	FROM stg.stg_wms_loc_location_hdr;
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