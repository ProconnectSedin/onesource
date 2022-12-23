CREATE PROCEDURE dwh.usp_d_vendor(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_wms_vendor_hdr;

	UPDATE dwh.d_vendor t
    SET 
		 vendor_status				= s.wms_vendor_status
		,vendor_name				= s.wms_vendor_name
		,vendor_payterm				= s.wms_vendor_payterm
		,vendor_reason_code			= s.wms_vendor_reason_code
		,vendor_classifcation		= s.wms_vendor_classifcation
		,vendor_currency			= s.wms_vendor_currency
		,vendor_for_self			= s.wms_vendor_for_self
		,vendor_created_by			= s.wms_vendor_created_by
		,vendor_created_date		= s.wms_vendor_created_date
		,vendor_modified_by			= s.wms_vendor_modified_by
		,vendor_modified_date		= s.wms_vendor_modified_date
		,vendor_timestamp			= s.wms_vendor_timestamp
		,vendor_address1			= s.wms_vendor_address1
		,vendor_address2			= s.wms_vendor_address2
		,vendor_address3			= s.wms_vendor_address3
		,vendor_city				= s.wms_vendor_city
		,vendor_state				= s.wms_vendor_state
		,vendor_country				= s.wms_vendor_country
		,vendor_phone1				= s.wms_vendor_phone1
		,vendor_phone2				= s.wms_vendor_phone2
		,vendor_email				= s.wms_vendor_email
		,vendor_fax					= s.wms_vendor_fax
		,vendor_url					= s.wms_vendor_url
		,vendor_subzone				= s.wms_vendor_subzone
		,vendor_timezone			= s.wms_vendor_timezone
		,vendor_zone				= s.wms_vendor_zone
		,vendor_region				= s.wms_vendor_region
		,vendor_postal_code			= s.wms_vendor_postal_code
		,vendor_agnt_reg			= s.wms_vendor_agnt_reg
		,vendor_agnt_cha			= s.wms_vendor_agnt_cha
		,vendor_carrier_road		= s.wms_vendor_carrier_road
		,vendor_carrier_rail		= s.wms_vendor_carrier_rail
		,vendor_carrier_air			= s.wms_vendor_carrier_air
		,vendor_carrier_sea			= s.wms_vendor_carrier_sea
		,vendor_sub_cntrct_veh		= s.wms_vendor_sub_cntrct_veh
		,vendor_sub_cntrct_emp		= s.wms_vendor_sub_cntrct_emp
		,vendor_lat					= s.wms_vendor_lat
		,vendor_long				= s.wms_vendor_long
		,vendor_reg					= s.wms_vendor_reg
		,vendor_dept				= s.wms_vendor_dept
		,vendor_ln_business			= s.wms_vendor_ln_business
		,vendor_rcti				= s.wms_vendor_rcti
		,vendor_gen_from			= s.wms_vendor_gen_from
		,vendor_group				= s.wms_vendor_group
		,vendor_std_contract		= s.wms_vendor_std_contract
		,vendor_final_bill_stage	= s.wms_vendor_final_bill_stage
		,vendor_allwdb_billto		= s.wms_vendor_allwdb_billto
		,vendor_insrnc_prvdr		= s.wms_vendor_insrnc_prvdr
		,etlactiveind 				= 1
		,etljobname 				= p_etljobname
		,envsourcecd 				= p_envsourcecd 
		,datasourcecd 				= p_datasourcecd
		,etlupdatedatetime 			= NOW()
    FROM stg.stg_wms_vendor_hdr s
    WHERE t.vendor_id  				= s.wms_vendor_id
	AND t.vendor_ou 				= s.wms_vendor_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_vendor
	(
		 vendor_id					,vendor_ou
		,vendor_status				,vendor_name			,vendor_payterm			,vendor_reason_code		,vendor_classifcation
		,vendor_currency			,vendor_for_self		,vendor_created_by		,vendor_created_date	,vendor_modified_by
		,vendor_modified_date		,vendor_timestamp		,vendor_address1		,vendor_address2		,vendor_address3
		,vendor_city				,vendor_state			,vendor_country			,vendor_phone1			,vendor_phone2
		,vendor_email				,vendor_fax				,vendor_url				,vendor_subzone			,vendor_timezone
		,vendor_zone				,vendor_region			,vendor_postal_code		,vendor_agnt_reg		,vendor_agnt_cha
		,vendor_carrier_road		,vendor_carrier_rail	,vendor_carrier_air		,vendor_carrier_sea		,vendor_sub_cntrct_veh
		,vendor_sub_cntrct_emp		,vendor_lat				,vendor_long			,vendor_reg				,vendor_dept
		,vendor_ln_business			,vendor_rcti			,vendor_gen_from		,vendor_group			,vendor_std_contract
		,vendor_final_bill_stage	,vendor_allwdb_billto	,vendor_insrnc_prvdr
		,etlactiveind				,etljobname				,envsourcecd			,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		 s.wms_vendor_id				,s.wms_vendor_ou
		,s.wms_vendor_status			,s.wms_vendor_name			,s.wms_vendor_payterm		,s.wms_vendor_reason_code	,s.wms_vendor_classifcation
		,s.wms_vendor_currency			,s.wms_vendor_for_self		,s.wms_vendor_created_by	,s.wms_vendor_created_date	,s.wms_vendor_modified_by
		,s.wms_vendor_modified_date		,s.wms_vendor_timestamp		,s.wms_vendor_address1		,s.wms_vendor_address2		,s.wms_vendor_address3
		,s.wms_vendor_city				,s.wms_vendor_state			,s.wms_vendor_country		,s.wms_vendor_phone1		,s.wms_vendor_phone2
		,s.wms_vendor_email				,s.wms_vendor_fax			,s.wms_vendor_url			,s.wms_vendor_subzone		,s.wms_vendor_timezone
		,s.wms_vendor_zone				,s.wms_vendor_region		,s.wms_vendor_postal_code	,s.wms_vendor_agnt_reg		,s.wms_vendor_agnt_cha
		,s.wms_vendor_carrier_road		,s.wms_vendor_carrier_rail	,s.wms_vendor_carrier_air	,s.wms_vendor_carrier_sea	,s.wms_vendor_sub_cntrct_veh
		,s.wms_vendor_sub_cntrct_emp	,s.wms_vendor_lat			,s.wms_vendor_long			,s.wms_vendor_reg			,s.wms_vendor_dept
		,s.wms_vendor_ln_business		,s.wms_vendor_rcti			,s.wms_vendor_gen_from		,s.wms_vendor_group			,s.wms_vendor_std_contract
		,s.wms_vendor_final_bill_stage	,s.wms_vendor_allwdb_billto	,s.wms_vendor_insrnc_prvdr
		,1							,p_etljobname			,p_envsourcecd			,p_datasourcecd			,NOW()
	FROM stg.stg_wms_vendor_hdr s
    LEFT JOIN dwh.d_vendor t
    ON 	s.wms_vendor_id  		= t.vendor_id
	AND s.wms_vendor_ou 		= t.vendor_ou
    WHERE t.vendor_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_wms_vendor_hdr
	(
		wms_vendor_id, 					wms_vendor_ou, 				wms_vendor_status, 			wms_vendor_name, 			wms_vendor_payterm, 
		wms_vendor_reason_code, 		wms_vendor_classifcation, 	wms_vendor_currency, 		wms_vendor_pay_addressid, 	wms_vendor_order_addressid, 
		wms_vendor_ship_addressid, 		wms_vendor_for_self, 		wms_vendor_created_by, 		wms_vendor_created_date, 	wms_vendor_modified_by, 
		wms_vendor_modified_date, 		wms_vendor_timestamp, 		wms_vendor_userdefined1, 	wms_vendor_userdefined2, 	wms_vendor_userdefined3, 
		wms_vendor_address1, 			wms_vendor_address2, 		wms_vendor_address3, 		wms_vendor_city, 			wms_vendor_state, 
		wms_vendor_country, 			wms_vendor_phone1, 			wms_vendor_phone2, 			wms_vendor_email,			wms_vendor_fax, 
		wms_vendor_url, 				wms_vendor_subzone, 		wms_vendor_timezone, 		wms_vendor_zone, 			wms_vendor_region, 
		wms_vendor_postal_code, 		wms_vendor_agnt_reg, 		wms_vendor_agnt_cha, 		wms_vendor_carrier_road, 	wms_vendor_carrier_rail, 
		wms_vendor_carrier_air, 		wms_vendor_carrier_sea, 	wms_vendor_sub_cntrct_veh, 	wms_vendor_sub_cntrct_emp, 	wms_vendor_lat, 
		wms_vendor_long, 				wms_vendor_reg, 			wms_vendor_dept, 			wms_vendor_ln_business, 	wms_vendor_bill_profile, 
		wms_vendor_rcti, 				wms_vendor_vfg, 			wms_vendor_gen_from, 		wms_vendor_group, 			wms_vendor_std_contract, 
		wms_vendor_final_bill_stage, 	wms_vendor_iata_code, 		wms_vendor_allwdb_billto, 	wms_vendor_suburb, 			wms_vendor_insrnc_prvdr, 
		wms_vendor_tempid, 				etlcreateddatetime
	)
	SELECT 
		wms_vendor_id, 					wms_vendor_ou, 				wms_vendor_status, 			wms_vendor_name, 			wms_vendor_payterm, 
		wms_vendor_reason_code, 		wms_vendor_classifcation, 	wms_vendor_currency, 		wms_vendor_pay_addressid, 	wms_vendor_order_addressid, 
		wms_vendor_ship_addressid, 		wms_vendor_for_self, 		wms_vendor_created_by, 		wms_vendor_created_date, 	wms_vendor_modified_by, 
		wms_vendor_modified_date, 		wms_vendor_timestamp, 		wms_vendor_userdefined1, 	wms_vendor_userdefined2, 	wms_vendor_userdefined3, 
		wms_vendor_address1, 			wms_vendor_address2, 		wms_vendor_address3, 		wms_vendor_city, 			wms_vendor_state, 
		wms_vendor_country, 			wms_vendor_phone1, 			wms_vendor_phone2, 			wms_vendor_email,			wms_vendor_fax, 
		wms_vendor_url, 				wms_vendor_subzone, 		wms_vendor_timezone, 		wms_vendor_zone, 			wms_vendor_region, 
		wms_vendor_postal_code, 		wms_vendor_agnt_reg, 		wms_vendor_agnt_cha, 		wms_vendor_carrier_road, 	wms_vendor_carrier_rail, 
		wms_vendor_carrier_air, 		wms_vendor_carrier_sea, 	wms_vendor_sub_cntrct_veh, 	wms_vendor_sub_cntrct_emp, 	wms_vendor_lat, 
		wms_vendor_long, 				wms_vendor_reg, 			wms_vendor_dept, 			wms_vendor_ln_business, 	wms_vendor_bill_profile, 
		wms_vendor_rcti, 				wms_vendor_vfg, 			wms_vendor_gen_from, 		wms_vendor_group, 			wms_vendor_std_contract, 
		wms_vendor_final_bill_stage, 	wms_vendor_iata_code, 		wms_vendor_allwdb_billto, 	wms_vendor_suburb, 			wms_vendor_insrnc_prvdr, 
		wms_vendor_tempid, 				etlcreateddatetime
	FROM stg.stg_wms_vendor_hdr;
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