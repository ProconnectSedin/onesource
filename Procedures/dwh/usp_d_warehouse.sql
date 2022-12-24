CREATE OR REPLACE PROCEDURE dwh.usp_d_warehouse(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_sa_wm_warehouse_master;

	UPDATE dwh.d_warehouse t
    SET 
		wh_desc					= s.wm_wh_desc,
		wh_status				= s.wm_wh_status,
		wh_desc_shdw			= s.wm_wh_desc_shdw,
		wh_storage_type			= s.wm_wh_storage_type,
		nettable				= s.wm_nettable,
		finance_book			= s.wm_finance_book,
		allocation_method		= s.wm_allocation_method,
		site_code				= s.wm_site_code,
		address1				= s.wm_address1,
		capital_warehouse		= s.wm_capital_warehouse,
		address2				= s.wm_address2,
		city					= s.wm_city,
		all_trans_allowed		= s.wm_all_trans_allowed,
		state					= s.wm_state,
		all_itemtypes_allowed	= s.wm_all_itemtypes_allowed,
		zip_code				= s.wm_zip_code,
		all_stk_status_allowed	= s.wm_all_stk_status_allowed,
		country					= s.wm_country,
		created_by				= s.wm_created_by,
		created_dt				= s.wm_created_dt,
		modified_by				= s.wm_modified_by,
		modified_dt				= s.wm_modified_dt,
		timestamp_value			= s.wm_timestamp_value,
		tran_type				= s.wm_tran_type,
		bonded_yn				= s.wm_bonded_yn,
		Location_code			= s.Location_code,
		Location_desc			= s.Location_desc,
		address3				= s.wm_address3,

		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_sa_wm_warehouse_master s
    WHERE t.wh_code 			= s.wm_wh_code
	AND t.wh_ou 			= s.wm_wh_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_warehouse
	(
		wh_code,			wh_ou,			wh_desc,				wh_status,
		wh_desc_shdw,		wh_storage_type,nettable,				finance_book,
		allocation_method,	site_code,		address1,				capital_warehouse,
		address2,			city,			all_trans_allowed,		state,
		all_itemtypes_allowed,zip_code,		all_stk_status_allowed,	country,	
		created_by,			created_dt,		modified_by,			modified_dt,
		timestamp_value,	tran_type,bonded_yn,Location_code,		Location_desc,
		address3,			etlactiveind,
        etljobname, 		envsourcecd, 	datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
		s.wm_wh_code,		s.wm_wh_ou,			s.wm_wh_desc,			s.wm_wh_status,
		s.wm_wh_desc_shdw,	s.wm_wh_storage_type,s.wm_nettable,			s.wm_finance_book,
		s.wm_allocation_method,s.wm_site_code,	s.wm_address1,			s.wm_capital_warehouse,
		s.wm_address2,		s.wm_city,			s.wm_all_trans_allowed, s.wm_state,
		s.wm_all_itemtypes_allowed,s.wm_zip_code,s.wm_all_stk_status_allowed,s.wm_country,
		s.wm_created_by,	s.wm_created_dt,	s.wm_modified_by,		s.wm_modified_dt,
		s.wm_timestamp_value,s.wm_tran_type,	s.wm_bonded_yn,			s.Location_code,
		s.Location_desc,	s.wm_address3,
		1,
		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_sa_wm_warehouse_master s
    LEFT JOIN dwh.d_warehouse t
    ON 	s.wm_wh_code  		= t.wh_code
	AND s.wm_wh_ou 			= t.wh_ou 
    WHERE t.wh_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_sa_wm_warehouse_master
	(
		 wm_wh_code, wm_wh_ou, wm_wh_desc, wm_wh_status, wm_wh_desc_shdw, wm_wh_storage_type, 
        wm_reason_code, wm_supervisor, wm_nettable, wm_finance_book, wm_allocation_method, wm_site_code, 
        wm_address1, wm_capital_warehouse, wm_address2, wm_city, wm_all_trans_allowed, wm_state,
        wm_all_itemtypes_allowed, wm_zip_code, wm_all_stk_status_allowed, wm_country, wm_created_by, 
        wm_created_dt, wm_modified_by, wm_modified_dt, wm_timestamp_value, wm_tran_type, wm_length, 
        wm_breadth, wm_height, wm_dimen_uom, wm_volume, wm_volume_uom, wm_area, wm_area_uom, wm_capacity,
        wm_capacity_uom, wm_last_gen_zone, wm_last_gen_row, wm_last_gen_rack, wm_last_gen_level, 
        wm_last_gen_bin, wm_bonded_yn, wm_customer_code, wm_structure, wm_valid_from, wm_valid_to, 
        wm_gcp, wm_latitude, wm_longitude, location_code, location_desc, wm_address3, etlcreateddatetime

	)
	SELECT 
		wm_wh_code, wm_wh_ou, wm_wh_desc, wm_wh_status, wm_wh_desc_shdw, wm_wh_storage_type, 
        wm_reason_code, wm_supervisor, wm_nettable, wm_finance_book, wm_allocation_method, wm_site_code, 
        wm_address1, wm_capital_warehouse, wm_address2, wm_city, wm_all_trans_allowed, wm_state,
        wm_all_itemtypes_allowed, wm_zip_code, wm_all_stk_status_allowed, wm_country, wm_created_by, 
        wm_created_dt, wm_modified_by, wm_modified_dt, wm_timestamp_value, wm_tran_type, wm_length, 
        wm_breadth, wm_height, wm_dimen_uom, wm_volume, wm_volume_uom, wm_area, wm_area_uom, wm_capacity,
        wm_capacity_uom, wm_last_gen_zone, wm_last_gen_row, wm_last_gen_rack, wm_last_gen_level, 
        wm_last_gen_bin, wm_bonded_yn, wm_customer_code, wm_structure, wm_valid_from, wm_valid_to, 
        wm_gcp, wm_latitude, wm_longitude, location_code, location_desc, wm_address3, etlcreateddatetime
	FROM stg.stg_sa_wm_warehouse_master;
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