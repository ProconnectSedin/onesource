CREATE OR REPLACE PROCEDURE dwh.usp_d_customer(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename ,h.rawstorageflag

	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag
 
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_customer_hdr;

	UPDATE dwh.d_customer t
    SET 
		 customer_name					= s.wms_customer_name
		,customer_status				= s.wms_customer_status
		,customer_type					= s.wms_customer_type
		,customer_description			= s.wms_customer_description
		,customer_credit_term			= s.wms_customer_credit_term
		,customer_pay_term				= s.wms_customer_pay_term
		,customer_currency				= s.wms_customer_currency
		,customer_reason_code			= s.wms_customer_reason_code
		,customer_address1				= s.wms_customer_address1
		,customer_address2				= s.wms_customer_address2
		,customer_address3				= s.wms_customer_address3
		,customer_city					= s.wms_customer_city
		,customer_state					= s.wms_customer_state
		,customer_country				= s.wms_customer_country
		,customer_postal_code			= s.wms_customer_postal_code
		,customer_timezone				= s.wms_customer_timezone
		,customer_contact_person		= s.wms_customer_contact_person
		,customer_phone1				= s.wms_customer_phone1
		,customer_phone2				= s.wms_customer_phone2
		,customer_fax					= s.wms_customer_fax
		,customer_email					= s.wms_customer_email
		,customer_bill_same_as_customer	= s.wms_customer_bill_same_as_customer
		,customer_bill_address1			= s.wms_customer_bill_address1
		,customer_bill_address2			= s.wms_customer_bill_address2
		,customer_bill_address3			= s.wns_customer_bill_address3
		,customer_bill_city				= s.wms_customer_bill_city
		,customer_bill_state			= s.wms_customer_bill_state
		,customer_bill_country			= s.wms_customer_bill_country
		,customer_bill_postal_code		= s.wms_customer_bill_postal_code
		,customer_bill_contact_person	= s.wms_customer_bill_contact_person
		,customer_bill_phone			= s.wms_customer_bill_phone
		,customer_bill_fax				= s.wms_customer_bill_fax
		,customer_ret_undelivered		= s.wms_customer_ret_undelivered
		,customer_ret_same_as_customer	= s.wms_customer_ret_same_as_customer
		,customer_ret_address1			= s.wms_customer_ret_address1
		,customer_ret_address2			= s.wms_customer_ret_address2
		,customer_ret_address3			= s.wms_customer_ret_address3
		,customer_ret_city				= s.wms_customer_ret_city
		,customer_ret_state				= s.wms_customer_ret_state
		,customer_ret_country			= s.wms_customer_ret_country
		,customer_ret_postal_code		= s.wms_customer_ret_postal_code
		,customer_ret_contact_person	= s.wms_customer_ret_contact_person
		,customer_ret_phone1			= s.wms_customer_ret_phone1
		,customer_ret_fax				= s.wms_customer_ret_fax
		,customer_timestamp				= s.wms_customer_timestamp
		,customer_created_by			= s.wms_customer_created_by
		,customer_created_dt			= s.wms_customer_created_dt
		,customer_modified_by			= s.wms_customer_modified_by
		,customer_modified_dt			= s.wms_customer_modified_dt
		,customer_BR_valid_prof_id		= s.wms_customer_BR_valid_prof_id
		,customer_payment_typ			= s.wms_customer_payment_typ
		,customer_geo_fence				= s.wms_customer_geo_fence
		,customer_bill_geo_fence		= s.wms_customer_bill_geo_fence
		,customer_bill_longtitude		= s.wms_customer_bill_longtitude
		,customer_bill_latitude			= s.wms_customer_bill_latitude
		,customer_bill_zone				= s.wms_customer_bill_zone
		,customer_bill_sub_zone			= s.wms_customer_bill_sub_zone
		,customer_bill_region			= s.wms_customer_bill_region
		,customer_ret_geo_fence			= s.wms_customer_ret_geo_fence
		,customer_ret_longtitude		= s.wms_customer_ret_longtitude
		,customer_ret_latitude			= s.wms_customer_ret_latitude
		,customer_customer_grp			= s.wms_customer_customer_grp
		,customer_industry_typ			= s.wms_customer_industry_typ
		,allow_rev_protection			= s.wms_allow_rev_protection
		,customer_invrep				= s.wms_customer_invrep
		,customer_rcti					= s.wms_customer_rcti
		,customer_gen_from				= s.wms_customer_gen_from
		,customer_bill_Hrchy1			= s.wms_customer_bill_Hrchy1
		,customer_new_customer			= s.wms_customer_new_customer
		,customer_final_bill_stage		= s.wms_customer_final_bill_stage
		,customer_allwdb_billto			= s.wms_customer_allwdb_billto
		,customer_contact_person2		= s.wms_customer_contact_person2
		,cus_contact_person2_Email		= s.wms_cus_contact_person2_Email
		,etlactiveind 					= 1
		,etljobname 					= p_etljobname
		,envsourcecd 					= p_envsourcecd 
		,datasourcecd 					= p_datasourcecd
		,etlupdatedatetime 				= NOW()
    FROM stg.stg_wms_customer_hdr s
    WHERE t.customer_id  				= s.wms_customer_id
	AND t.customer_ou 					= s.wms_customer_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_customer
	(
		 customer_id,					customer_ou	,					customer_name,			customer_status,				customer_type
		,customer_description,			customer_credit_term,			customer_pay_term,		customer_currency,				customer_reason_code
		,customer_address1,				customer_address2,				customer_address3,		customer_city,					customer_state
		,customer_country,				customer_postal_code,			customer_timezone,		customer_contact_person,		customer_phone1
		,customer_phone2,				customer_fax,					customer_email,			customer_bill_same_as_customer,	customer_bill_address1
		,customer_bill_address2,		customer_bill_address3,			customer_bill_city,		customer_bill_state,			customer_bill_country
		,customer_bill_postal_code,		customer_bill_contact_person,	customer_bill_phone,	customer_bill_fax,				customer_ret_undelivered
		,customer_ret_same_as_customer,	customer_ret_address1,			customer_ret_address2,	customer_ret_address3,			customer_ret_city
		,customer_ret_state,			customer_ret_country,			customer_ret_postal_code,customer_ret_contact_person,	customer_ret_phone1
		,customer_ret_fax,				customer_timestamp,				customer_created_by,	customer_created_dt,			customer_modified_by
		,customer_modified_dt,			customer_BR_valid_prof_id,		customer_payment_typ,	customer_geo_fence,				customer_bill_geo_fence
		,customer_bill_longtitude,		customer_bill_latitude,			customer_bill_zone,		customer_bill_sub_zone,			customer_bill_region
		,customer_ret_geo_fence,		customer_ret_longtitude,		customer_ret_latitude,	customer_customer_grp,			customer_industry_typ
		,allow_rev_protection,			customer_invrep,				customer_rcti,			customer_gen_from,				customer_bill_Hrchy1
		,customer_new_customer,			customer_final_bill_stage,		customer_allwdb_billto,	customer_contact_person2,		cus_contact_person2_Email
		,etlactiveind,					etljobname,						envsourcecd,			datasourcecd,					etlcreatedatetime
	)
	
    SELECT 
		s.wms_customer_id,						s.wms_customer_ou,					s.wms_customer_name,			s.wms_customer_status,				s.wms_customer_type
		,s.wms_customer_description,			s.wms_customer_credit_term,			s.wms_customer_pay_term,		s.wms_customer_currency,			s.wms_customer_reason_code
		,s.wms_customer_address1,				s.wms_customer_address2,			s.wms_customer_address3,		s.wms_customer_city,				s.wms_customer_state
		,s.wms_customer_country,				s.wms_customer_postal_code,			s.wms_customer_timezone,		s.wms_customer_contact_person,		s.wms_customer_phone1
		,s.wms_customer_phone2,					s.wms_customer_fax,					s.wms_customer_email,			s.wms_customer_bill_same_as_customer,s.wms_customer_bill_address1
		,s.wms_customer_bill_address2,			s.wns_customer_bill_address3,		s.wms_customer_bill_city,		s.wms_customer_bill_state,			s.wms_customer_bill_country
		,s.wms_customer_bill_postal_code,		s.wms_customer_bill_contact_person,	s.wms_customer_bill_phone,		s.wms_customer_bill_fax,			s.wms_customer_ret_undelivered
		,s.wms_customer_ret_same_as_customer,	s.wms_customer_ret_address1,		s.wms_customer_ret_address2,	s.wms_customer_ret_address3,		s.wms_customer_ret_city
		,s.wms_customer_ret_state,				s.wms_customer_ret_country,			s.wms_customer_ret_postal_code,	s.wms_customer_ret_contact_person,	s.wms_customer_ret_phone1
		,s.wms_customer_ret_fax,				s.wms_customer_timestamp,			s.wms_customer_created_by,		s.wms_customer_created_dt,			s.wms_customer_modified_by
		,s.wms_customer_modified_dt,			s.wms_customer_BR_valid_prof_id,	s.wms_customer_payment_typ,		s.wms_customer_geo_fence,			s.wms_customer_bill_geo_fence
		,s.wms_customer_bill_longtitude,		s.wms_customer_bill_latitude,		s.wms_customer_bill_zone,		s.wms_customer_bill_sub_zone,		s.wms_customer_bill_region
		,s.wms_customer_ret_geo_fence,			s.wms_customer_ret_longtitude,		s.wms_customer_ret_latitude,	s.wms_customer_customer_grp,		s.wms_customer_industry_typ
		,s.wms_allow_rev_protection,			s.wms_customer_invrep,				s.wms_customer_rcti,			s.wms_customer_gen_from,			s.wms_customer_bill_Hrchy1
		,s.wms_customer_new_customer,			s.wms_customer_final_bill_stage,	s.wms_customer_allwdb_billto,	s.wms_customer_contact_person2,		s.wms_cus_contact_person2_Email
		,1,										p_etljobname,						p_envsourcecd,					p_datasourcecd,						NOW()
	FROM stg.stg_wms_customer_hdr s
    LEFT JOIN dwh.d_customer t
    ON 	s.wms_customer_id  		= t.customer_id
	AND s.wms_customer_ou 		= t.customer_ou
    WHERE t.customer_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_wms_customer_hdr
	(
		wms_customer_id, 				wms_customer_ou, 				wms_customer_name, 					wms_customer_status, 				wms_customer_type, 
		wms_customer_description, 		wms_customer_credit_term, 		wms_customer_pay_term, 				wms_customer_currency, 				wms_customer_reason_code, 
		wms_customer_address1, 			wms_customer_address2, 			wms_customer_address3, 				wms_customer_unique_address, 		wms_customer_city, 
		wms_customer_state, 			wms_customer_country, 			wms_customer_postal_code, 			wms_customer_timezone, 				wms_customer_contact_person, 
		wms_customer_phone1, 			wms_customer_phone2, 			wms_customer_fax, 					wms_customer_email, 				wms_customer_bill_same_as_customer, 
		wms_customer_bill_address1, 	wms_customer_bill_address2, 	wns_customer_bill_address3, 		wms_customer_bill_unique_address, 	wms_customer_bill_city, 
		wms_customer_bill_state, 		wms_customer_bill_country, 		wms_customer_bill_postal_code, 		wms_customer_bill_contact_person, 	wms_customer_bill_phone, 
		wms_customer_bill_fax, 			wms_customer_ret_undelivered, 	wms_customer_ret_same_as_customer, 	wms_customer_ret_address1, 			wms_customer_ret_address2, 
		wms_customer_ret_address3, 		wms_customer_ret_unique_address,wms_customer_ret_city, 				wms_customer_ret_state, 			wms_customer_ret_country, 
		wms_customer_ret_postal_code, 	wms_customer_ret_contact_person,wms_customer_ret_phone1, 			wms_customer_ret_fax, 				wms_customer_timestamp, 
		wms_customer_userdefined1, 		wms_customer_userdefined2, 		wms_customer_userdefined3, 			wms_customer_created_by, 			wms_customer_created_dt, 
		wms_customer_modified_by, 		wms_customer_modified_dt, 		wms_customer_route, 				wms_customer_br_valid_prof_id, 		wms_customer_payment_typ, 
		wms_customer_geo_fence, 		wms_customer_longtitude, 		wms_customer_latitude, 				wms_customer_zone, 					wms_customer_sub_zone, 
		wms_customer_region, 			wms_customer_bill_geo_fence, 	wms_customer_bill_longtitude, 		wms_customer_bill_latitude, 		wms_customer_bill_zone, 
		wms_customer_bill_sub_zone, 	wms_customer_bill_region, 		wms_customer_bill_timezone, 		wms_customer_ret_geo_fence, 		wms_customer_ret_longtitude, 
		wms_customer_ret_latitude, 		wms_customer_ret_zone, 			wms_customer_ret_sub_zone, 			wms_customer_ret_region, 			wms_customer_ret_timezone, 
		wms_customer_customer_grp, 		wms_customer_industry_typ, 		wms_customer_lsp, 					wms_customer_url, 					wms_customer_reg, 
		wms_customer_dept, 				wms_customer_ln_business, 		wms_allow_rev_protection, 			wms_customer_invrep, 				wms_customer_lspemail, 
		wms_customer_lspname, 			wms_customer_packing_bay, 		wms_customer_route_no, 				wms_customer_lspid, 				wms_customer_finance_grp, 
		wms_customer_rcti, 				wms_customer_gen_from, 			wms_customer_cont_derivation, 		wms_customer_bill_hrchy1,	 		wms_customer_bill_hrchy2, 
		wms_customer_bill_hrchy3, 		wms_customer_chnl_type, 		wms_customer_seller_type, 			wms_customer_profile_id, 			wms_customer_new_customer, 
		wms_customer_final_bill_stage, 	wms_bank_name, 					wms_bank_acc_no, 					wms_bank_ifsc_code, 				wms_prospect_customer_yn, 
		wms_customer_allwdb_billto, 	wms_customer_suburb, 			wms_customer_contact_person2, 		wms_cus_contact_person2_phone1, 	wms_cus_contact_person2_phone2, 
		wms_cus_contact_person2_fax,	wms_cus_contact_person2_email, 	wms_cus_contact_person2_url, 		wms_customer_tempid, 				etlcreateddatetime
	
	)
	SELECT 
		wms_customer_id, 				wms_customer_ou, 				wms_customer_name, 					wms_customer_status, 				wms_customer_type, 
		wms_customer_description, 		wms_customer_credit_term, 		wms_customer_pay_term, 				wms_customer_currency, 				wms_customer_reason_code, 
		wms_customer_address1, 			wms_customer_address2, 			wms_customer_address3, 				wms_customer_unique_address, 		wms_customer_city, 
		wms_customer_state, 			wms_customer_country, 			wms_customer_postal_code, 			wms_customer_timezone, 				wms_customer_contact_person, 
		wms_customer_phone1, 			wms_customer_phone2, 			wms_customer_fax, 					wms_customer_email, 				wms_customer_bill_same_as_customer, 
		wms_customer_bill_address1, 	wms_customer_bill_address2, 	wns_customer_bill_address3, 		wms_customer_bill_unique_address, 	wms_customer_bill_city, 
		wms_customer_bill_state, 		wms_customer_bill_country, 		wms_customer_bill_postal_code, 		wms_customer_bill_contact_person, 	wms_customer_bill_phone, 
		wms_customer_bill_fax, 			wms_customer_ret_undelivered, 	wms_customer_ret_same_as_customer, 	wms_customer_ret_address1, 			wms_customer_ret_address2, 
		wms_customer_ret_address3, 		wms_customer_ret_unique_address,wms_customer_ret_city, 				wms_customer_ret_state, 			wms_customer_ret_country, 
		wms_customer_ret_postal_code, 	wms_customer_ret_contact_person,wms_customer_ret_phone1, 			wms_customer_ret_fax, 				wms_customer_timestamp, 
		wms_customer_userdefined1, 		wms_customer_userdefined2, 		wms_customer_userdefined3, 			wms_customer_created_by, 			wms_customer_created_dt, 
		wms_customer_modified_by, 		wms_customer_modified_dt, 		wms_customer_route, 				wms_customer_br_valid_prof_id, 		wms_customer_payment_typ, 
		wms_customer_geo_fence, 		wms_customer_longtitude, 		wms_customer_latitude, 				wms_customer_zone, 					wms_customer_sub_zone, 
		wms_customer_region, 			wms_customer_bill_geo_fence, 	wms_customer_bill_longtitude, 		wms_customer_bill_latitude, 		wms_customer_bill_zone, 
		wms_customer_bill_sub_zone, 	wms_customer_bill_region, 		wms_customer_bill_timezone, 		wms_customer_ret_geo_fence, 		wms_customer_ret_longtitude, 
		wms_customer_ret_latitude, 		wms_customer_ret_zone, 			wms_customer_ret_sub_zone, 			wms_customer_ret_region, 			wms_customer_ret_timezone, 
		wms_customer_customer_grp, 		wms_customer_industry_typ, 		wms_customer_lsp, 					wms_customer_url, 					wms_customer_reg, 
		wms_customer_dept, 				wms_customer_ln_business, 		wms_allow_rev_protection, 			wms_customer_invrep, 				wms_customer_lspemail, 
		wms_customer_lspname, 			wms_customer_packing_bay, 		wms_customer_route_no, 				wms_customer_lspid, 				wms_customer_finance_grp, 
		wms_customer_rcti, 				wms_customer_gen_from, 			wms_customer_cont_derivation, 		wms_customer_bill_hrchy1,	 		wms_customer_bill_hrchy2, 
		wms_customer_bill_hrchy3, 		wms_customer_chnl_type, 		wms_customer_seller_type, 			wms_customer_profile_id, 			wms_customer_new_customer, 
		wms_customer_final_bill_stage, 	wms_bank_name, 					wms_bank_acc_no, 					wms_bank_ifsc_code, 				wms_prospect_customer_yn, 
		wms_customer_allwdb_billto, 	wms_customer_suburb, 			wms_customer_contact_person2, 		wms_cus_contact_person2_phone1, 	wms_cus_contact_person2_phone2, 
		wms_cus_contact_person2_fax,	wms_cus_contact_person2_email, 	wms_cus_contact_person2_url, 		wms_customer_tempid, 				etlcreateddatetime
	FROM stg.stg_wms_customer_hdr;	
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