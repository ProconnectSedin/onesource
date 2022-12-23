CREATE PROCEDURE dwh.usp_d_custprospectinfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_cust_prospect_info;

	UPDATE dwh.D_CustProspectInfo t
    SET 
	cpr_prosp_cust_name 		=           s.cpr_prosp_cust_name,
	cpr_prosp_custname_shd 		= 			s.cpr_prosp_custname_shd,
	cpr_registration_dt 		=			s.cpr_registration_dt,
	cpr_created_at 				=			s.cpr_created_at,
	cpr_number_type 			=			s.cpr_number_type,
	cpr_created_transaction 	=			s.cpr_created_transaction,
	cpr_addrline1 				= 			s.cpr_addrline1,
	cpr_addrline2 				=			s.cpr_addrline2,
	cpr_addrline3 				=			s.cpr_addrline3,
	cpr_city 					=			s.cpr_city,
	cpr_state 					=			s.cpr_state,
	cpr_country 				= 			s.cpr_country,
	cpr_zip 					=		 	s.cpr_zip,
	cpr_phone1 					=			s.cpr_phone1, 
	cpr_mobile 					= 			s.cpr_mobile,
	cpr_fax 					=			s.cpr_fax,
	cpr_email 					=			s.cpr_email,
	cpr_status 					= 			s.cpr_status,
	cpr_created_by 				=			s.cpr_created_by, 
	cpr_created_date 			=			s.cpr_created_date,
	cpr_modified_by 			=			s.cpr_modified_by,
	cpr_modified_date 			=			s.cpr_modified_date,
	cpr_timestamp_value 		=			s.cpr_timestamp_value,
	cpr_cont_person 			=			s.cpr_cont_person,
	cpr_prosp_long_desc 		=			s.cpr_prosp_long_desc,
	cpr_industry 				=			s.cpr_industry,
	cpr_priority 				=			s.cpr_priority,
	cpr_region 					=			s.cpr_region,
	cpr_prosp_contact_name 		=			s.cpr_prosp_contact_name,
	cpr_registration_no 		=			s.cpr_registration_no,
	cpr_registration_type 		=			s.cpr_registration_type,
	cpr_address_id 				=			s.cpr_address_id,
	cpr_crm_flag 				=			s.cpr_crm_flag,
	cpr_segment 				=			s.cpr_segment,
	cpr_sp_code 				=			s.cpr_sp_code,
	cpr_cust_loyalty 			=			s.cpr_cust_loyalty,
	cpr_pannumber 				=			s.cpr_pannumber,
	cpr_job_title 				=			s.cpr_job_title,
	etlactiveind 				= 			1,
	etljobname 					= 			p_etljobname,
	envsourcecd 				= 			p_envsourcecd ,
	datasourcecd 				= 			p_datasourcecd ,
	etlupdatedatetime 			= 			NOW()	
    FROM stg.stg_cust_prospect_info s
    WHERE t.cpr_lo  			= s.cpr_lo
	AND t.cpr_prosp_cust_code 	= s.cpr_prosp_cust_code;

    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_CustProspectInfo
	(
		cpr_lo, 				cpr_prosp_cust_code, 		cpr_prosp_cust_name, 		cpr_prosp_custname_shd, 
		cpr_registration_dt, 	cpr_created_at, 			cpr_number_type, 			cpr_created_transaction, 
		cpr_addrline1, 			cpr_addrline2, 				cpr_addrline3, 				cpr_city, 
		cpr_state, 				cpr_country, 				cpr_zip, 					cpr_phone1, 
		cpr_mobile, 			cpr_fax, 					cpr_email, 					cpr_status, 
		cpr_created_by, 		cpr_created_date, 			cpr_modified_by, 			cpr_modified_date, 
		cpr_timestamp_value, 	cpr_cont_person, 			cpr_prosp_long_desc, 		cpr_industry, 
		cpr_priority, 			cpr_region, 				cpr_prosp_contact_name, 	cpr_registration_no, 
		cpr_registration_type, 	cpr_address_id, 			cpr_crm_flag, 				cpr_segment, 
		cpr_sp_code, 			cpr_cust_loyalty, 			cpr_pannumber, 				cpr_job_title, 
		etlactiveind, 			etljobname, 				envsourcecd, 				datasourcecd, 
		etlcreatedatetime
	)
	
    SELECT 
		s.cpr_lo, 					s.cpr_prosp_cust_code, 		s.cpr_prosp_cust_name, 		s.cpr_prosp_custname_shd, 
		s.cpr_registration_dt, 		s.cpr_created_at, 			s.cpr_number_type, 			s.cpr_created_transaction, 
		s.cpr_addrline1, 			s.cpr_addrline2, 			s.cpr_addrline3, 			s.cpr_city, 
		s.cpr_state, 				s.cpr_country, 				s.cpr_zip, 					s.cpr_phone1, 
		s.cpr_mobile, 				s.cpr_fax, 					s.cpr_email, 				s.cpr_status, 
		s.cpr_created_by, 			s.cpr_created_date, 		s.cpr_modified_by, 			s.cpr_modified_date, 
		s.cpr_timestamp_value, 		s.cpr_cont_person, 			s.cpr_prosp_long_desc, 		s.cpr_industry, 
		s.cpr_priority, 			s.cpr_region, 				s.cpr_prosp_contact_name, 	s.cpr_registration_no, 
		s.cpr_registration_type, 	s.cpr_address_id, 			s.cpr_crm_flag, 			s.cpr_segment, 
		s.cpr_sp_code, 				s.cpr_cust_loyalty, 		s.cpr_pannumber, 			s.cpr_job_title, 
		1, 							p_etljobname, 				p_envsourcecd, 				p_datasourcecd, 
		now()
	FROM stg.stg_cust_prospect_info s
    LEFT JOIN dwh.D_CustProspectInfo t
    ON 	s.cpr_lo  				= t.cpr_lo
	AND s.cpr_prosp_cust_code 	= t.cpr_prosp_cust_code 
    WHERE t.cpr_lo IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
 
	
	INSERT INTO raw.raw_cust_prospect_info
	(
		 cpr_lo, cpr_prosp_cust_code, cpr_prosp_cust_name, cpr_prosp_custname_shd, cpr_registration_dt, 
        cpr_created_at, cpr_cust_code, cpr_number_type, cpr_parent_cust_code, cpr_created_transaction, 
        cpr_supp_code, cpr_addrline1, cpr_addrline2, cpr_addrline3, cpr_city, cpr_state, cpr_country, 
        cpr_zip, cpr_phone1, cpr_phone2, cpr_mobile, cpr_fax, cpr_email, cpr_url, cpr_status, 
        cpr_created_by, cpr_created_date, cpr_modified_by, cpr_modified_date, cpr_timestamp_value,
        cpr_addnl1, cpr_addnl2, cpr_addnl3, cpr_cont_person, cpr_prosp_long_desc, cpr_industry, 
        cpr_priority, cpr_region, cpr_prosp_contact_name, cpr_registration_no, cpr_registration_type,
        cpr_address_id, cpr_crm_flag, cpr_segment, cpr_sp_code, cpr_cust_loyalty, cpr_pannumber, 
        cpr_job_title, etlcreateddatetime

	)
	SELECT 
		cpr_lo, cpr_prosp_cust_code, cpr_prosp_cust_name, cpr_prosp_custname_shd, cpr_registration_dt, 
        cpr_created_at, cpr_cust_code, cpr_number_type, cpr_parent_cust_code, cpr_created_transaction, 
        cpr_supp_code, cpr_addrline1, cpr_addrline2, cpr_addrline3, cpr_city, cpr_state, cpr_country, 
        cpr_zip, cpr_phone1, cpr_phone2, cpr_mobile, cpr_fax, cpr_email, cpr_url, cpr_status, 
        cpr_created_by, cpr_created_date, cpr_modified_by, cpr_modified_date, cpr_timestamp_value,
        cpr_addnl1, cpr_addnl2, cpr_addnl3, cpr_cont_person, cpr_prosp_long_desc, cpr_industry, 
        cpr_priority, cpr_region, cpr_prosp_contact_name, cpr_registration_no, cpr_registration_type,
        cpr_address_id, cpr_crm_flag, cpr_segment, cpr_sp_code, cpr_cust_loyalty, cpr_pannumber, 
        cpr_job_title, etlcreateddatetime
	FROM stg.stg_cust_prospect_info;
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