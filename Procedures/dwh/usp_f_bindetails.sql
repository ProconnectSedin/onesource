CREATE OR REPLACE PROCEDURE dwh.usp_f_bindetails(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	p_etljobname VARCHAR(100);
	p_envsourcecd VARCHAR(50);
	p_datasourcecd VARCHAR(50);
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;	
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_bin_dtl;

	UPDATE dwh.f_bindetails t
    SET 
		bin_typ_key						= COALESCE(bt.bin_typ_key,-1)
		, bin_loc_key				    = COALESCE(l.loc_key,-1)
		, bin_zone_key					= COALESCE(z.zone_key,-1)
		, bin_desc                      = s.wms_bin_desc
		, bin_cap_indicator             = s.wms_bin_cap_indicator
		, bin_aisle                     = s.wms_bin_aisle
		, bin_level                     = s.wms_bin_level
		, bin_seq_no                    = s.wms_bin_seq_no
		, bin_blocked                   = s.wms_bin_blocked
		, bin_reason_code               = s.wms_bin_reason_code
		, bin_timestamp                 = s.wms_bin_timestamp
		, bin_created_by                = s.wms_bin_created_by
		, bin_created_dt                = s.wms_bin_created_dt
		, bin_modified_by               = s.wms_bin_modified_by
		, bin_modified_dt               = s.wms_bin_modified_dt
		, bin_status                    = s.wms_bin_status
		, bin_stock_exist               = s.wms_bin_stock_exist
		, bin_one_bin_one_pal           = s.wms_bin_one_bin_one_pal
		, bin_permitted_uids            = s.wms_bin_permitted_uids
		, bin_blocking_reason_ml        = s.wms_bin_blocking_reason_ml
		, bin_blocked_pick_ml           = s.wms_bin_blocked_pick_ml
		, bin_blocked_pawy_ml           = s.wms_bin_blocked_pawy_ml
		, bin_blocked_sa_ml             = s.wms_bin_blocked_sa_ml
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_bin_dtl s
	LEFT JOIN dwh.d_bintypes bt
		ON	bt.bin_typ_code 		= s.wms_bin_type
		AND	bt.bin_typ_ou	 		= s.wms_bin_ou
		AND	bt.bin_typ_loc_code 	= s.wms_bin_loc_code
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_bin_zone 			= z.zone_code
		AND s.wms_bin_ou			= z.zone_ou
	    AND s.wms_bin_loc_code		= z.zone_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_bin_loc_code		= l.loc_code 
		AND s.wms_bin_ou			= l.loc_ou	 	
    WHERE   t.bin_ou 				= s.wms_bin_ou
		AND	t.bin_code 				= s.wms_bin_code
		AND	t.bin_loc_code 			= s.wms_bin_loc_code
		AND	t.bin_zone		        = s.wms_bin_zone
        AND	t.bin_type		        = s.wms_bin_type;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_bindetails
	(
		 bin_typ_key
		, bin_loc_key			  , bin_zone_key			
        , bin_code				  , bin_desc				, bin_loc_code				, bin_zone				, bin_type
		, bin_cap_indicator		  , bin_aisle				, bin_level					, bin_seq_no			, bin_blocked
		, bin_reason_code		  , bin_timestamp			, bin_created_by			, bin_created_dt		, bin_modified_by
		, bin_modified_dt		  , bin_status			    , bin_stock_exist			, bin_one_bin_one_pal	, bin_permitted_uids
		, bin_blocking_reason_ml  , bin_blocked_pick_ml	    , bin_blocked_pawy_ml		, bin_blocked_sa_ml		, bin_ou
        , etlactiveind			  , etljobname              , envsourcecd				, datasourcecd			, etlcreatedatetime
	)
	
	SELECT DISTINCT
		COALESCE(bt.bin_typ_key,-1)
		, COALESCE(l.loc_key,-1)          , COALESCE(z.zone_key,-1)
        , s.wms_bin_code				  , s.wms_bin_desc				    , s.wms_bin_loc_code				, s.wms_bin_zone				, s.wms_bin_type
		, s.wms_bin_cap_indicator		  , s.wms_bin_aisle				    , s.wms_bin_level					, s.wms_bin_seq_no				, s.wms_bin_blocked
		, s.wms_bin_reason_code		  	  , s.wms_bin_timestamp			    , s.wms_bin_created_by				, s.wms_bin_created_dt			, s.wms_bin_modified_by
		, s.wms_bin_modified_dt		      , s.wms_bin_status			    , s.wms_bin_stock_exist				, s.wms_bin_one_bin_one_pal		, s.wms_bin_permitted_uids
		, s.wms_bin_blocking_reason_ml    , s.wms_bin_blocked_pick_ml	    , s.wms_bin_blocked_pawy_ml			, s.wms_bin_blocked_sa_ml		, s.wms_bin_ou
		, 1 AS etlactiveind				  , p_etljobname                    , p_envsourcecd					    , p_datasourcecd				, NOW()
	FROM stg.stg_wms_bin_dtl s
	LEFT JOIN dwh.d_bintypes bt
		ON	bt.bin_typ_code 		= s.wms_bin_type
		AND	bt.bin_typ_ou	 		= s.wms_bin_ou
		AND	bt.bin_typ_loc_code 	= s.wms_bin_loc_code
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_bin_zone 			= z.zone_code
		AND s.wms_bin_ou			= z.zone_ou
	    AND s.wms_bin_loc_code		= z.zone_loc_code
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_bin_loc_code		= l.loc_code 
		AND s.wms_bin_ou			= l.loc_ou
	LEFT JOIN dwh.f_bindetails t  	
		ON  t.bin_ou 				= s.wms_bin_ou
		AND	t.bin_code 				= s.wms_bin_code
		AND	t.bin_loc_code 			= s.wms_bin_loc_code
		AND	t.bin_zone		        = s.wms_bin_zone
        AND	t.bin_type		        = s.wms_bin_type
    WHERE t.bin_ou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_bin_dtl
	(
		wms_bin_ou, 				wms_bin_code, 				wms_bin_desc, 				wms_bin_loc_code, 				wms_bin_zone, 
		wms_bin_type, 				wms_bin_cap_indicator, 		wms_bin_aisle, 				wms_bin_stack, 					wms_bin_level, 
		wms_bin_section, 			wms_bin_seq_no, 			wms_bin_blocked, 			wms_bin_reason_code, 			wms_bin_user_def1, 
		wms_bin_user_def2, 			wms_bin_user_def3, 			wms_bin_timestamp, 			wms_bin_created_by, 			wms_bin_created_dt, 
		wms_bin_modified_by, 		wms_bin_modified_dt, 		wms_bin_status, 			wms_bin_stock_exist, 			wms_bin_one_bin_one_pal, 
		wms_bin_permitted_uids, 	wms_bin_curr_plnno, 		wms_bin_curr_created_date, 	wms_bin_curr_created_time, 		wms_bin_last_plnno, 
		wms_bin_last_created_date,  wms_bin_last_created_time, 	wms_bin_anti_cap_ethu, 		wms_bin_anti_cap_ci, 			wms_bin_anti_cap_wgt, 
		wms_bin_anti_cap_qty, 		wms_bin_anti_cap_vol, 		wms_bin_rem_cap_qty, 		wms_bin_rem_cap_ci, 			wms_bin_rem_cap_ethu, 
		wms_bin_rem_cap_vol, 		wms_bin_rem_cap_wgt, 		wms_bin_blocking_reason_ml, wms_bin_blocked_pick_ml, 		wms_bin_blocked_pawy_ml, 
		wms_bin_bin_checkbit_ml, 	wms_bin_bin_full_ml, 		wms_bin_blocked_sa_ml, 		wms_error_code, 				etlcreateddatetime
	)
	SELECT 
		wms_bin_ou, 				wms_bin_code, 				wms_bin_desc, 				wms_bin_loc_code, 				wms_bin_zone, 
		wms_bin_type, 				wms_bin_cap_indicator, 		wms_bin_aisle, 				wms_bin_stack, 					wms_bin_level, 
		wms_bin_section, 			wms_bin_seq_no, 			wms_bin_blocked, 			wms_bin_reason_code, 			wms_bin_user_def1, 
		wms_bin_user_def2, 			wms_bin_user_def3, 			wms_bin_timestamp, 			wms_bin_created_by, 			wms_bin_created_dt, 
		wms_bin_modified_by, 		wms_bin_modified_dt, 		wms_bin_status, 			wms_bin_stock_exist, 			wms_bin_one_bin_one_pal, 
		wms_bin_permitted_uids, 	wms_bin_curr_plnno, 		wms_bin_curr_created_date, 	wms_bin_curr_created_time, 		wms_bin_last_plnno, 
		wms_bin_last_created_date,  wms_bin_last_created_time, 	wms_bin_anti_cap_ethu, 		wms_bin_anti_cap_ci, 			wms_bin_anti_cap_wgt, 
		wms_bin_anti_cap_qty, 		wms_bin_anti_cap_vol, 		wms_bin_rem_cap_qty, 		wms_bin_rem_cap_ci, 			wms_bin_rem_cap_ethu, 
		wms_bin_rem_cap_vol, 		wms_bin_rem_cap_wgt, 		wms_bin_blocking_reason_ml, wms_bin_blocked_pick_ml, 		wms_bin_blocked_pawy_ml, 
		wms_bin_bin_checkbit_ml, 	wms_bin_bin_full_ml, 		wms_bin_blocked_sa_ml, 		wms_error_code, 				etlcreateddatetime
	FROM stg.stg_wms_bin_dtl;
    END IF;	
	
    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
        
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt; 	
END;
$$;