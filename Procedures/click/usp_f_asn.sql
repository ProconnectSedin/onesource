-- PROCEDURE: click.usp_f_asn()

-- DROP PROCEDURE IF EXISTS click.usp_f_asn();

CREATE OR REPLACE PROCEDURE click.usp_f_asn(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

/*
	SELECT (CASE WHEN MAX(COALESCE(asn_modified_date,asn_created_date)) <> NULL 
					THEN MAX(COALESCE(asn_modified_date,asn_created_date))
				ELSE COALESCE(MAX(COALESCE(asn_modified_date,asn_created_date)),'1900-01-01') END)::DATE
	INTO v_maxdate
	FROM click.f_asn;

	UPDATE click.f_asn ct
	SET
		  asn_hr_key 				= ah.asn_hr_key
		, asn_dtl_key 				= ad. asn_dtl_key
		, gate_exec_dtl_key			= COALESCE(gd.gate_exec_dtl_key,-1)
		, asn_loc_key 				= ah. asn_loc_key
		, asn_date_key 				= ah. asn_date_key
		, asn_cust_key 				= ah. asn_cust_key
		, asn_dtl_itm_hdr_key 		= ad. asn_dtl_itm_hdr_key
		, gate_exec_dtl_veh_key 	= COALESCE(gd.gate_exec_dtl_veh_key,-1)
		, asn_prefdoc_type 			= ah. asn_prefdoc_type
		, asn_prefdoc_no 			= ah. asn_prefdoc_no
		, asn_prefdoc_date 			= ah. asn_prefdoc_date
		, asn_date 					= ah. asn_date
		, asn_status 				= ah. asn_status
		, asn_operation_status 		= ah. asn_operation_status
		, asn_ib_order 				= ah. asn_ib_order
		, asn_ship_frm 				= ah. asn_ship_frm
		, asn_dlv_date 				= ah. asn_dlv_date
		, asn_sup_asn_no 			= ah. asn_sup_asn_no
		, asn_sup_asn_date 			= ah. asn_sup_asn_date
		, asn_sent_by 				= ah. asn_sent_by
		, asn_ship_date 			= ah. asn_ship_date
		, asn_rem 					= ah. asn_rem
		, asn_shp_ref_typ 			= ah. asn_shp_ref_typ
		, asn_shp_ref_no 			= ah. asn_shp_ref_no
		, asn_shp_ref_date 			= ah. asn_shp_ref_date
		, asn_shp_carrier 			= ah. asn_shp_carrier
		, asn_shp_mode 				= ah. asn_shp_mode
		, asn_shp_rem 				= ah. asn_shp_rem
		, asn_cust_code 			= ah. asn_cust_code
		, asn_type 					= ah. asn_type
		, asn_reason_code 			= ah. asn_reason_code
		, asn_gate_no 				= ah. asn_gate_no
		, gate_actual_date 			= gd. gate_actual_date
		, gate_ser_provider 		= gd. gate_ser_provider
		, gate_veh_type 			= gd. gate_veh_type
		, gate_vehicle_no 			= gd. gate_vehicle_no
		, gate_employee 			= gd. gate_employee
		, gate_created_date 		= gd. gate_created_date
		, asn_line_status 			= ad. asn_line_status
		, asn_itm_code 				= ad. asn_itm_code
		, asn_qty 					= ad. asn_qty
		, asn_rec_qty 				= ad. asn_rec_qty
		, asn_acc_qty 				= ad. asn_acc_qty
		, asn_rej_qty 				= ad. asn_rej_qty
		, asn_order_uom 			= ad. asn_order_uom
		, asn_master_uom_qty 		= ad. asn_master_uom_qty
		, asn_modified_date			= ah.asn_modified_date
		, asn_created_date			= ah.asn_created_date
		, etlupdatedatetime 		= NOW()		
	FROM dwh.f_asnheader ah
	INNER JOIN dwh.f_asndetails ad
		ON  ah.asn_hr_key = ad.asn_hr_key
	LEFT JOIN dwh.f_gateexecdetail gd
		ON  gd.gate_loc_code 			= ah.asn_location 
		AND gd.gate_exec_no 			= ah.asn_gate_no 
		AND gd.gate_exec_ou 			= ah.asn_ou
	WHERE	ah.asn_no 					= ct.asn_no 
		AND ah.asn_ou 					= ct.asn_ou 
		AND ah.asn_location 			= ct.asn_location
		AND ad.asn_lineno				= ct.asn_lineno
		AND COALESCE(ah.asn_modified_date,ah.asn_created_date) > v_maxdate;
	*/	
	
	SELECT (CASE WHEN MAX(etlcreatedatetime) <> NULL 
					THEN MAX(etlcreatedatetime)
				ELSE COALESCE(MAX(etlcreatedatetime),'1900-01-01') END)::DATE
	INTO v_maxdate
	FROM click.f_asn;
	
	IF v_maxdate = '1900-01-01'
	
	THEN
	
	INSERT INTO click.f_asn
	(
		asn_hr_key				, asn_dtl_key				, gate_exec_dtl_key						, asn_loc_key, 
		asn_itm_itemgroup		, asn_itm_class				, activeindicator,
		asn_date_key			, asn_cust_key				, asn_dtl_itm_hdr_key					, gate_exec_dtl_veh_key, 
		asn_ou					, asn_location				, asn_no								, gate_actual_date, 
		asn_prefdoc_type		, asn_prefdoc_no			, asn_prefdoc_date						, asn_date, 
		asn_status				, asn_operation_status		, asn_ib_order							, asn_ship_frm, 
		asn_dlv_date			, asn_sup_asn_no			, asn_sup_asn_date						, asn_sent_by, 
		asn_ship_date			, asn_rem					, asn_shp_ref_typ						, asn_shp_ref_no, 
		asn_shp_ref_date		, asn_shp_carrier			, asn_shp_mode							, asn_shp_rem, 
		asn_cust_code			, asn_type					, asn_reason_code						, asn_gate_no, 		
		gate_ser_provider		, gate_veh_type				, gate_vehicle_no						, gate_employee, 
		gate_created_date		, asn_line_status			, asn_itm_code 							, asn_qty, 
		asn_rec_qty				, asn_acc_qty				, asn_rej_qty							, asn_order_uom, 
		asn_master_uom_qty		, etlcreatedatetime			, etlupdatedatetime						, asn_lineno,
		asn_created_date		, asn_modified_date			, createdatetime						, updatedatetime
	)
	SELECT
		ah.asn_hr_key			, ad.asn_dtl_key			, COALESCE(gd.gate_exec_dtl_key,-1)		, ah.asn_loc_key,
		ad.asn_itm_itemgroup	, ad.asn_itm_class			,(ah.etlactiveind*ad.etlactiveind),
		ah.asn_date_key			, ah.asn_cust_key			, ad.asn_dtl_itm_hdr_key				, COALESCE(gd.gate_exec_dtl_veh_key,-1), 
		ah.asn_ou				, ah.asn_location			, ah.asn_no								, gd.gate_actual_date,			
		ah.asn_prefdoc_type		, ah.asn_prefdoc_no			, ah.asn_prefdoc_date					, ah.asn_date,
		ah.asn_status			, ah.asn_operation_status	, ah.asn_ib_order						, ah.asn_ship_frm,
		ah.asn_dlv_date			, ah.asn_sup_asn_no			, ah.asn_sup_asn_date					, ah.asn_sent_by,
		ah.asn_ship_date		, ah.asn_rem				, ah.asn_shp_ref_typ					, ah.asn_shp_ref_no,
		ah.asn_shp_ref_date		, ah.asn_shp_carrier		, ah.asn_shp_mode						, ah.asn_shp_rem,
		ah.asn_cust_code		, ah.asn_type				, ah.asn_reason_code					, ah.asn_gate_no,
		gd.gate_ser_provider	, gd.gate_veh_type			, gd.gate_vehicle_no					, gd.gate_employee, 
		gd.gate_created_date	, ad.asn_line_status		, ad.asn_itm_code						, ad.asn_qty, 
		ad.asn_rec_qty			, ad.asn_acc_qty			, ad.asn_rej_qty						, ad.asn_order_uom, 
		ad.asn_master_uom_qty	, ad.etlcreatedatetime		, ad.etlupdatedatetime					, ad.asn_lineno,
		ah.asn_created_date		, ah.asn_modified_date		, NOW()::TIMESTAMP						, NULL
	FROM dwh.f_asnheader ah
	INNER JOIN dwh.f_asndetails ad
		ON  ah.asn_hr_key = ad.asn_hr_key
	LEFT JOIN dwh.f_gateexecdetail gd  
		ON  gd.gate_loc_code 	= ah.asn_location 
		AND gd.gate_exec_no 	= ah.asn_gate_no 
		AND gd.gate_exec_ou 	= ah.asn_ou
	WHERE 	1=1;
	
ELSE

-- 	DELETE FROM click.f_asn
-- 	WHERE etlcreatedatetime::DATE >= v_maxdate;
	
	UPDATE click.f_asn ct
	SET
		  asn_hr_key 				= ah.asn_hr_key
		, asn_dtl_key 				= ad. asn_dtl_key
		, activeindicator			= (ah.etlactiveind*ad.etlactiveind)
		, gate_exec_dtl_key			= COALESCE(gd.gate_exec_dtl_key,-1)
		, asn_loc_key 				= ah. asn_loc_key
		, asn_date_key 				= ah. asn_date_key
		, asn_cust_key 				= ah. asn_cust_key
		, asn_dtl_itm_hdr_key 		= ad. asn_dtl_itm_hdr_key
		, gate_exec_dtl_veh_key 	= COALESCE(gd.gate_exec_dtl_veh_key,-1)
		, asn_prefdoc_type 			= ah. asn_prefdoc_type
		, asn_prefdoc_no 			= ah. asn_prefdoc_no
		, asn_prefdoc_date 			= ah. asn_prefdoc_date
		, asn_date 					= ah. asn_date
		, asn_status 				= ah. asn_status
		, asn_operation_status 		= ah. asn_operation_status
		, asn_ib_order 				= ah. asn_ib_order
		, asn_ship_frm 				= ah. asn_ship_frm
		, asn_dlv_date 				= ah. asn_dlv_date
		, asn_sup_asn_no 			= ah. asn_sup_asn_no
		, asn_sup_asn_date 			= ah. asn_sup_asn_date
		, asn_sent_by 				= ah. asn_sent_by
		, asn_ship_date 			= ah. asn_ship_date
		, asn_rem 					= ah. asn_rem
		, asn_shp_ref_typ 			= ah. asn_shp_ref_typ
		, asn_shp_ref_no 			= ah. asn_shp_ref_no
		, asn_shp_ref_date 			= ah. asn_shp_ref_date
		, asn_shp_carrier 			= ah. asn_shp_carrier
		, asn_shp_mode 				= ah. asn_shp_mode
		, asn_shp_rem 				= ah. asn_shp_rem
		, asn_cust_code 			= ah. asn_cust_code
		, asn_type 					= ah. asn_type
		, asn_reason_code 			= ah. asn_reason_code
		, asn_gate_no 				= ah. asn_gate_no
		, gate_actual_date 			= gd. gate_actual_date
		, gate_ser_provider 		= gd. gate_ser_provider
		, gate_veh_type 			= gd. gate_veh_type
		, gate_vehicle_no 			= gd. gate_vehicle_no
		, gate_employee 			= gd. gate_employee
		, gate_created_date 		= gd. gate_created_date
		, asn_line_status 			= ad. asn_line_status
		, asn_itm_code 				= ad. asn_itm_code
		, asn_qty 					= ad. asn_qty
		, asn_rec_qty 				= ad. asn_rec_qty
		, asn_acc_qty 				= ad. asn_acc_qty
		, asn_rej_qty 				= ad. asn_rej_qty
		, asn_order_uom 			= ad. asn_order_uom
		, asn_master_uom_qty 		= ad. asn_master_uom_qty
		, asn_modified_date			= ah.asn_modified_date
		, asn_created_date			= ah.asn_created_date
		, etlcreatedatetime			= ad.etlcreatedatetime
		, etlupdatedatetime			= ad.etlupdatedatetime
		, updatedatetime 		= NOW()		
	FROM dwh.f_asnheader ah
	INNER JOIN dwh.f_asndetails ad
		ON  ah.asn_hr_key = ad.asn_hr_key
	LEFT JOIN dwh.f_gateexecdetail gd
		ON  gd.gate_loc_code 			= ah.asn_location 
		AND gd.gate_exec_no 			= ah.asn_gate_no 
		AND gd.gate_exec_ou 			= ah.asn_ou
	WHERE	ah.asn_no 					= ct.asn_no 
		AND ah.asn_ou 					= ct.asn_ou 
		AND ah.asn_location 			= ct.asn_location
		AND ad.asn_lineno				= ct.asn_lineno
		AND COALESCE(ad.etlupdatedatetime,ad.etlcreatedatetime) >= v_maxdate;
		
	INSERT INTO click.f_asn
	(
		asn_hr_key				, asn_dtl_key				, gate_exec_dtl_key						, asn_loc_key,
		asn_itm_itemgroup		, asn_itm_class				, activeindicator,
		asn_date_key			, asn_cust_key				, asn_dtl_itm_hdr_key					, gate_exec_dtl_veh_key, 
		asn_ou					, asn_location				, asn_no								, gate_actual_date, 
		asn_prefdoc_type		, asn_prefdoc_no			, asn_prefdoc_date						, asn_date, 
		asn_status				, asn_operation_status		, asn_ib_order							, asn_ship_frm, 
		asn_dlv_date			, asn_sup_asn_no			, asn_sup_asn_date						, asn_sent_by, 
		asn_ship_date			, asn_rem					, asn_shp_ref_typ						, asn_shp_ref_no, 
		asn_shp_ref_date		, asn_shp_carrier			, asn_shp_mode							, asn_shp_rem, 
		asn_cust_code			, asn_type					, asn_reason_code						, asn_gate_no, 		
		gate_ser_provider		, gate_veh_type				, gate_vehicle_no						, gate_employee, 
		gate_created_date		, asn_line_status			, asn_itm_code 							, asn_qty, 
		asn_rec_qty				, asn_acc_qty				, asn_rej_qty							, asn_order_uom, 
		asn_master_uom_qty		, etlcreatedatetime			, etlupdatedatetime						, asn_lineno,
		asn_created_date		, asn_modified_date			, createdatetime						, updatedatetime
	)
	SELECT
		ah.asn_hr_key			, ad.asn_dtl_key			, COALESCE(gd.gate_exec_dtl_key,-1)		, ah.asn_loc_key,
		ad.asn_itm_itemgroup	, ad.asn_itm_class			, (ah.etlactiveind*ad.etlactiveind),
		ah.asn_date_key			, ah.asn_cust_key			, ad.asn_dtl_itm_hdr_key				, COALESCE(gd.gate_exec_dtl_veh_key,-1), 
		ah.asn_ou				, ah.asn_location			, ah.asn_no								, gd.gate_actual_date,			
		ah.asn_prefdoc_type		, ah.asn_prefdoc_no			, ah.asn_prefdoc_date					, ah.asn_date,
		ah.asn_status			, ah.asn_operation_status	, ah.asn_ib_order						, ah.asn_ship_frm,
		ah.asn_dlv_date			, ah.asn_sup_asn_no			, ah.asn_sup_asn_date					, ah.asn_sent_by,
		ah.asn_ship_date		, ah.asn_rem				, ah.asn_shp_ref_typ					, ah.asn_shp_ref_no,
		ah.asn_shp_ref_date		, ah.asn_shp_carrier		, ah.asn_shp_mode						, ah.asn_shp_rem,
		ah.asn_cust_code		, ah.asn_type				, ah.asn_reason_code					, ah.asn_gate_no,
		gd.gate_ser_provider	, gd.gate_veh_type			, gd.gate_vehicle_no					, gd.gate_employee, 
		gd.gate_created_date	, ad.asn_line_status		, ad.asn_itm_code						, ad.asn_qty, 
		ad.asn_rec_qty			, ad.asn_acc_qty			, ad.asn_rej_qty						, ad.asn_order_uom, 
		ad.asn_master_uom_qty	, ad.etlcreatedatetime		, ad.etlupdatedatetime					, ad.asn_lineno,
		ah.asn_created_date		, ah.asn_modified_date		, NOW()::TIMESTAMP						, NULL
	FROM dwh.f_asnheader ah
	INNER JOIN dwh.f_asndetails ad
		ON  ah.asn_hr_key = ad.asn_hr_key
	LEFT JOIN dwh.f_gateexecdetail gd
		ON  gd.gate_loc_code 	= ah.asn_location 
		AND gd.gate_exec_no 	= ah.asn_gate_no 
		AND gd.gate_exec_ou 	= ah.asn_ou
	LEFT JOIN click.f_asn ct
	ON ah.asn_no 					= ct.asn_no 
	AND ah.asn_ou 					= ct.asn_ou 
	AND ah.asn_location 			= ct.asn_location
	AND ad.asn_lineno				= ct.asn_lineno
	WHERE 	COALESCE(ad.etlupdatedatetime,ad.etlcreatedatetime) >= v_maxdate
	AND ct.asn_no IS NULL;
	
-- 	UPDATE CLICK.F_ASN A
-- 	SET asn_qualifieddate=CASE WHEN COALESCE(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE)::TIME>=B.CUTOFFTIME
-- 							   THEN((coalesce(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE)) + INTERVAL '1 DAY')
-- 							else COALESCE(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE) end,
-- 		asn_cutofftime   =B.CUTOFFTIME					
-- 	FROM click.d_inboundtat B
-- 	WHERE B.OU=A.ASN_OU
-- 	AND B.LOCATIONCODE=A.ASN_LOCATION
-- 	AND B.ORDERTYPE=A.ASN_PREFDOC_TYPE
-- 	AND B.SERVICETYPE=A.ASN_TYPE
-- 	AND COALESCE(A.updatedatetime, A.createdatetime)>=v_maxdate;

UPDATE CLICK.F_ASN A
	SET asn_qualifieddate=CASE WHEN COALESCE(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE)::TIME>=B.CUTOFFTIME
					THEN(((coalesce(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE)) + INTERVAL '1 DAY')::DATE ||' '|| B.openingtime)::TIMESTAMP
							else COALESCE(A.ASN_MODIFIED_DATE,A.ASN_CREATED_DATE) end,
		asn_cutofftime   =B.CUTOFFTIME,
		asn_openingtime  =B.OPENINGTIME
	FROM CLICK.F_ASN A1 
	LEFT JOIN click.d_inboundtat B
	ON B.OU=A1.ASN_OU
	AND B.LOCATIONCODE=A1.ASN_LOCATION
	AND B.ORDERTYPE=A1.ASN_PREFDOC_TYPE
	AND B.SERVICETYPE=A1.ASN_TYPE
	WHERE A.asn_key=A1.asn_key
	AND COALESCE(A.updatedatetime, A.createdatetime)>=v_maxdate;
	
	UPDATE CLICK.F_ASN A
	SET asn_qualifieddate =	 CASE WHEN A1.asn_qualifieddate::date = holidaydate THEN nextworkingdate + (A1.asn_openingtime || ' Minutes')::INTERVAL 
	ELSE A1.asn_qualifieddate END		
	FROM CLICK.F_ASN A1 
	LEFT JOIN click.f_locationholiday
	ON A1.ASN_LOCATION = locationcode
	AND A1.asn_qualifieddate::date = holidaydate
	WHERE A.asn_key=A1.asn_key
	AND COALESCE(A.updatedatetime, A.createdatetime)>=v_maxdate;
	
	UPDATE CLICK.F_ASN A
	SET asn_qualifieddatekey = d.datekey
	FROM click.d_date d	
	WHERE dateactual = asn_qualifieddate::DATE
	AND COALESCE(A.updatedatetime, A.createdatetime)>=v_maxdate;
END IF;
		
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_asn','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

  
END;
$BODY$;
ALTER PROCEDURE click.usp_f_asn()
    OWNER TO proconnect;
