-- PROCEDURE: dwh.usp_f_contractheaderweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_contractheaderweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_contractheaderweekly(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/*****************************************************************************************************************/
/* PROCEDURE		:	dwh.usp_f_contractheaderweekly														 				 */
/* DESCRIPTION		:	This sp is used to load f_contractheaderweekly table from stg_wms_contract_hdr;        			 			 */
/*						Load Strategy: Insert/Update 															 */
/*						Sources: wms_contract_hdr_w;					 		 									 */
/*****************************************************************************************************************/
/* DEVELOPMENT HISTORY																							 */
/*****************************************************************************************************************/
/* AUTHOR    		:	AKASH V																						 */
/* DATE				:	26-DEC-2022																				 */
/*****************************************************************************************************************/
/* MODIFICATION HISTORY																							 */
/*****************************************************************************************************************/
/* MODIFIED BY		:																							 */
/* DATE				:														 									 */
/* DESCRIPTION		:													  										 */
/*****************************************************************************************************************/
/* EXECUTION SAMPLE :CALL dwh.usp_f_contractheaderweekly('wms_contract_hdr_w','StgtoDW','f_contractheader',0,0,0,0,NULL,NULL);*/
/*****************************************************************************************************************/



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
	p_interval integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag, d.intervaldays
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_interval
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
		
	--	select 7 into p_interval;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_contract_hdr;

	UPDATE dwh.f_contractheader t
    SET 
			cont_amendno				=	S.wms_cont_amendno,
			cont_desc					=	S.wms_cont_desc,
			cont_date					=	S.wms_cont_date,
			cont_type					=	S.wms_cont_type,
			cont_status					=	S.wms_cont_status,
			cont_rsn_code				=	S.wms_cont_rsn_code,
			cont_service_type			=	S.wms_cont_service_type,
			cont_valid_from				=	S.wms_cont_valid_from,
			cont_valid_to				=	S.wms_cont_valid_to,
			cont_cust_contract_ref_no	=	S.wms_cont_cust_contract_ref_no,
			cont_customer_id			=	S.wms_cont_customer_id,
			cont_supp_contract_ref_no	=	S.wms_cont_supp_contract_ref_no,
			cont_vendor_id				=	S.wms_cont_vendor_id,
			cont_ref_doc_type			=	S.wms_cont_ref_doc_type,
			cont_ref_doc_no				=	S.wms_cont_ref_doc_no,
			cont_bill_freq				=	S.wms_cont_bill_freq,
			cont_bill_date_day			=	S.wms_cont_bill_date_day,
			cont_billing_stage			=	S.wms_cont_billing_stage,
			cont_currency				=	S.wms_cont_currency,
			cont_exchange_rate			=	S.wms_cont_exchange_rate,
			cont_bulk_rate_chg_per		=	S.wms_cont_bulk_rate_chg_per,
			cont_division				=	S.wms_cont_division,
			cont_location				=	S.wms_cont_location,
			cont_remarks				=	S.wms_cont_remarks,
			cont_slab_type				=	S.wms_cont_slab_type,
			cont_timestamp				=	S.wms_cont_timestamp,
			cont_created_by				=	S.wms_cont_created_by,
			cont_created_dt				=	S.wms_cont_created_dt,
			cont_modified_by			=	S.wms_cont_modified_by,
			cont_modified_dt			=	S.wms_cont_modified_dt,
			cont_space_last_bill_dt		=	S.wms_cont_space_last_bill_dt,
			cont_payment_type			=	S.wms_cont_payment_type,
			cont_std_cont_portal		=	S.wms_cont_std_cont_portal,
			cont_prev_status			=	S.wms_cont_prev_status,
			cont_cust_grp				=	S.wms_cont_cust_grp,
			cont_non_billable			=	S.wms_cont_non_billable,
			non_billable_chk			=	S.wms_non_billable_chk,
			cont_last_day				=	S.wms_cont_last_day,
			cont_div_loc_cust			=	S.wms_cont_div_loc_cust,
			cont_numbering_type			=	S.wms_cont_numbering_type,
			cont_wscchtsa_last_bil_date =	S.wms_cont_wscchtsa_last_bil_date,
			cont_stapbspo_last_bil_date =	S.wms_cont_stapbspo_last_bil_date,
			cont_WHRTCHAP_last_bil_date =	S.wms_cont_WHRTCHAP_last_bil_date,
			cont_Iata_chk				=	S.wms_cont_Iata_chk,
			etlactiveind 				=	1,
			etljobname 					=	p_etljobname,
			envsourcecd 				=	p_envsourcecd,
			datasourcecd 				=	p_datasourcecd,
			etlupdatedatetime 			=	NOW()
    FROM    stg.stg_wms_contract_hdr s
    WHERE	t.cont_id  					=	s.wms_cont_id
	AND		t.cont_ou 					=	s.wms_cont_ou;
	
	
	GET DIAGNOSTICS updcnt = ROW_COUNT;
	
	
/*
	
	Delete from dwh.f_contractheader
	USING stg.stg_wms_contract_hdr
	WHERE wms_cont_id  	= cont_id
	AND  wms_cont_ou 	= cont_ou;
*/
	INSERT INTO dwh.f_contractheader
	(
		cont_vendor_key				,	cont_location_key		,		cont_customer_key		,	cont_date_key
		,cont_id						,cont_ou						,cont_amendno					,cont_desc 
		,cont_date						,cont_type						,cont_status					,cont_rsn_code
		,cont_service_type				,cont_valid_from				,cont_valid_to					,cont_cust_contract_ref_no 
		,cont_customer_id				,cont_supp_contract_ref_no		,cont_vendor_id					,cont_ref_doc_type 
		,cont_ref_doc_no				,cont_bill_freq					,cont_bill_date_day				,cont_billing_stage ,cont_currency 
		,cont_exchange_rate				,cont_bulk_rate_chg_per			,cont_division					,cont_location  
		,cont_remarks					,cont_slab_type					,cont_timestamp					,cont_created_by,cont_created_dt
		,cont_modified_by				,cont_modified_dt				,cont_space_last_bill_dt		,cont_payment_type 
		,cont_std_cont_portal			,cont_prev_status				,cont_cust_grp					,cont_non_billable
		,non_billable_chk				,cont_last_day					,cont_div_loc_cust				,cont_numbering_type
		,cont_wscchtsa_last_bil_date	,cont_stapbspo_last_bil_date	,cont_WHRTCHAP_last_bil_date	,cont_Iata_chk 
		,etlactiveind					,etljobname						,envsourcecd					,datasourcecd			,etlcreatedatetime
	)
	
    SELECT 
		COALESCE(v.vendor_key,-1)			,COALESCE(l.loc_key,-1)					,COALESCE(c.customer_key,-1),	COALESCE(d.datekey,-1)
		,s.wms_cont_id						,s.wms_cont_ou							,s.wms_cont_amendno					,s.wms_cont_desc
		,s.wms_cont_date					,s.wms_cont_type						,s.wms_cont_status					,s.wms_cont_rsn_code
		,s.wms_cont_service_type			,s.wms_cont_valid_from					,s.wms_cont_valid_to				,s.wms_cont_cust_contract_ref_no
		,s.wms_cont_customer_id				,s.wms_cont_supp_contract_ref_no		,s.wms_cont_vendor_id				,s.wms_cont_ref_doc_type
		,s.wms_cont_ref_doc_no				,s.wms_cont_bill_freq					,s.wms_cont_bill_date_day			,s.wms_cont_billing_stage,s.wms_cont_currency
		,s.wms_cont_exchange_rate			,s.wms_cont_bulk_rate_chg_per			,s.wms_cont_division				,s.wms_cont_location
		,s.wms_cont_remarks					,s.wms_cont_slab_type					,s.wms_cont_timestamp				,s.wms_cont_created_by,s.wms_cont_created_dt			
		,s.wms_cont_modified_by				,s.wms_cont_modified_dt					,s.wms_cont_space_last_bill_dt		,s.wms_cont_payment_type			
		,s.wms_cont_std_cont_portal			,s.wms_cont_prev_status					,s.wms_cont_cust_grp				,s.wms_cont_non_billable			
		,s.wms_non_billable_chk				,s.wms_cont_last_day					,s.wms_cont_div_loc_cust			,s.wms_cont_numbering_type
		,s.wms_cont_wscchtsa_last_bil_date	,s.wms_cont_stapbspo_last_bil_date		,s.wms_cont_WHRTCHAP_last_bil_date	,s.wms_cont_Iata_chk
		,1									,p_etljobname							,p_envsourcecd						,p_datasourcecd			,NOW()
	FROM stg.stg_wms_contract_hdr s
	left join dwh.D_Vendor v
	on  v.vendor_id	= s.wms_cont_vendor_id
	and v.vendor_ou	= s.wms_cont_ou
	left join dwh.D_Location l
	on l.loc_code	= s.wms_cont_location
	and l.loc_ou	= s.wms_cont_ou
	left join dwh.D_Customer c
	on c.customer_id = s.wms_cont_customer_id
	and c.customer_ou = s.wms_cont_ou
	LEFT JOIN dwh.d_date d 			
	ON 	s.wms_cont_date::date = d.dateactual	
    LEFT JOIN dwh.f_contractheader t
    ON 	s.wms_cont_id  		= t.cont_id
	AND s.wms_cont_ou 		= t.cont_ou
    WHERE t.cont_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	update dwh.f_contractheader t1
	set etlactiveind =  0,
	etlupdatedatetime = Now()::timestamp
	from dwh.f_contractheader t
	left join stg.stg_wms_contract_hdr s
	on s.wms_cont_id=t.cont_id
	and s.wms_cont_ou=t.cont_ou
	and s.wms_cont_amendno=t.cont_amendno
	WHERE  t.cont_hdr_key=t1.cont_hdr_key 
	and COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	AND s.wms_cont_id is null;
	
	--GET DIAGNOSTICS updcnt = ROW_COUNT;
	
-- select 0 into updcnt;
	
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_contract_hdr
	(
		wms_cont_id							,wms_cont_ou							,wms_cont_amendno					,wms_cont_desc
		,wms_cont_date						,wms_cont_type							,wms_cont_status					,wms_cont_rsn_code
		,wms_cont_service_type				,wms_cont_valid_from					,wms_cont_valid_to					,wms_cont_cust_contract_ref_no
		,wms_cont_customer_id				,wms_cont_supp_contract_ref_no			,wms_cont_vendor_id					,wms_cont_ref_doc_type
		,wms_cont_ref_doc_no				,wms_cont_bill_freq						,wms_cont_bill_date_day				,wms_cont_billing_stage,wms_cont_currency
		,wms_cont_exchange_rate				,wms_cont_bulk_rate_chg_per				,wms_cont_division					,wms_cont_location
		,wms_cont_remarks					,wms_cont_slab_type						,wms_cont_timestamp					,wms_cont_created_by,wms_cont_created_dt			
		,wms_cont_modified_by				,wms_cont_modified_dt					,wms_cont_space_last_bill_dt		,wms_cont_payment_type			
		,wms_cont_std_cont_portal			,wms_cont_prev_status					,wms_cont_cust_grp					,wms_cont_non_billable			
		,wms_non_billable_chk				,wms_cont_last_day						,wms_cont_div_loc_cust				,wms_cont_numbering_type
		,wms_cont_wscchtsa_last_bil_date	,wms_cont_stapbspo_last_bil_date		,wms_cont_WHRTCHAP_last_bil_date	,wms_cont_Iata_chk
		,etlcreateddatetime
	)
	SELECT 
		wms_cont_id						,wms_cont_ou							,wms_cont_amendno					,wms_cont_desc
		,wms_cont_date						,wms_cont_type							,wms_cont_status					,wms_cont_rsn_code
		,wms_cont_service_type				,wms_cont_valid_from					,wms_cont_valid_to					,wms_cont_cust_contract_ref_no
		,wms_cont_customer_id				,wms_cont_supp_contract_ref_no			,wms_cont_vendor_id					,wms_cont_ref_doc_type
		,wms_cont_ref_doc_no				,wms_cont_bill_freq						,wms_cont_bill_date_day				,wms_cont_billing_stage,wms_cont_currency
		,wms_cont_exchange_rate				,wms_cont_bulk_rate_chg_per				,wms_cont_division					,wms_cont_location
		,wms_cont_remarks					,wms_cont_slab_type						,wms_cont_timestamp					,wms_cont_created_by,wms_cont_created_dt			
		,wms_cont_modified_by				,wms_cont_modified_dt					,wms_cont_space_last_bill_dt		,wms_cont_payment_type			
		,wms_cont_std_cont_portal			,wms_cont_prev_status					,wms_cont_cust_grp					,wms_cont_non_billable			
		,wms_non_billable_chk				,wms_cont_last_day						,wms_cont_div_loc_cust				,wms_cont_numbering_type
		,wms_cont_wscchtsa_last_bil_date	,wms_cont_stapbspo_last_bil_date		,wms_cont_WHRTCHAP_last_bil_date	,wms_cont_Iata_chk 				
		,etlcreateddatetime
	FROM stg.stg_wms_contract_hdr;
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
$BODY$;
ALTER PROCEDURE dwh.usp_f_contractheaderweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
