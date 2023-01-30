-- PROCEDURE: click.usp_f_outboundheader()

-- DROP PROCEDURE IF EXISTS click.usp_f_outboundheader();

CREATE OR REPLACE PROCEDURE click.usp_f_outboundheader(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	SELECT COALESCE(MAX(etlcreatedatetime),'1900-01-01')::DATE	
	INTO v_maxdate
	FROM CLICK.F_OutboundHeader;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO click.F_outboundheader
	(
		obh_hr_key				, oub_ou						, oub_loc_code					, oub_outbound_ord				, obh_loc_key,
		obh_cust_key			, oub_orderdatekey				, oub_prim_rf_dc_typ			, oub_prim_rf_dc_no				, oub_prim_rf_dc_date,
		oub_orderdate			, oub_ob_status					, oub_order_type				, oub_order_priority			, oub_urgent_chk,
		oub_cust_code			, oub_cust_type					, oub_end_cust_ref_doc			, oub_ord_src					, oub_amendno,
		oub_refdoctype			, oub_refdocno					, oub_refdocdate				, oub_carriername				, oub_shipment_mode,
		oub_shipment_type		, oub_cnsgn_code_shpto			, oub_ship_point_id				, oub_address1					, oub_address2,
		oub_address3			, oub_postcode					, oub_country					, oub_state						, oub_city,
		oub_phoneno				, oub_delivery_date				, oub_service_from				, oub_service_to				, oub_itm_plan_gd_iss_dt,
		oub_itm_plan_dt_iss		, oub_instructions				, oub_incoterms					, oub_created_by				, oub_created_date,
		oub_modified_by			, oub_modified_date				, oub_timestamp					, oub_operation_status			, oub_contract_id,
		oub_contract_amend_no	, oub_subservice_type			, oub_shp_name					, oub_shp_zone					, oub_shp_sub_zne,
		oub_shp_region			, oub_pickup_from_date_time		, oub_pickup_to_date_time		, oub_transport_location		, oub_transport_service,
		oub_gen_req_id			, oub_gen_from					, oub_opfeboty_bil_status		, oub_exp_stk					, oub_consolidation_no,
		oub_bill_to_name		, oub_bill_det_addr_line1		, oub_bill_det_addr_line2		, oub_bill_det_post_code		, oub_bill_det_country,
		oub_bill_det_city		, oub_bill_det_state			, oub_bill_det_phone			, oub_bill_det_ship_addr		, oub_consgn_name,
		oub_cancel				, oub_cancel_code				, oub_prt_full_fill				, oub_reason_code				, etlactiveind,
		etljobname				, envsourcecd					, datasourcecd					, etlcreatedatetime				, etlupdatedatetime,
		createddate	
	)
	select
		oh.obh_hr_key			, oh.oub_ou						, oh.oub_loc_code				, oh.oub_outbound_ord			, oh.obh_loc_key,
		oh.obh_cust_key			, oh.oub_orderdatekey			, oh.oub_prim_rf_dc_typ			, oh.oub_prim_rf_dc_no			, oh.oub_prim_rf_dc_date,
		oh.oub_orderdate		, oh.oub_ob_status				, oh.oub_order_type				, oh.oub_order_priority			, oh.oub_urgent_chk,
		oh.oub_cust_code		, oh.oub_cust_type				, oh.oub_end_cust_ref_doc		, oh.oub_ord_src				, oh.oub_amendno,
		oh.oub_refdoctype		, oh.oub_refdocno				, oh.oub_refdocdate				, oh.oub_carriername			, oh.oub_shipment_mode,
		oh.oub_shipment_type	, oh.oub_cnsgn_code_shpto		, oh.oub_ship_point_id			, oh.oub_address1				, oh.oub_address2,
		oh.oub_address3			, oh.oub_postcode				, oh.oub_country				, oh.oub_state					, oh.oub_city,
		oh.oub_phoneno			, oh.oub_delivery_date			, oh.oub_service_from			, oh.oub_service_to				, oh.oub_itm_plan_gd_iss_dt,
		oh.oub_itm_plan_dt_iss	, oh.oub_instructions			, oh.oub_incoterms				, oh.oub_created_by				, oh.oub_created_date,
		oh.oub_modified_by		, oh.oub_modified_date			, oh.oub_timestamp				, oh.oub_operation_status		, oh.oub_contract_id,
		oh.oub_contract_amend_no, oh.oub_subservice_type		, oh.oub_shp_name				, oh.oub_shp_zone				, oh.oub_shp_sub_zne,
		oh.oub_shp_region		, oh.oub_pickup_from_date_time	, oh.oub_pickup_to_date_time	, oh.oub_transport_location		, oh.oub_transport_service,
		oh.oub_gen_req_id		, oh.oub_gen_from				, oh.oub_opfeboty_bil_status	, oh.oub_exp_stk				, oh.oub_consolidation_no,
		oh.oub_bill_to_name		, oh.oub_bill_det_addr_line1	, oh.oub_bill_det_addr_line2	, oh.oub_bill_det_post_code		, oh.oub_bill_det_country,
		oh.oub_bill_det_city	, oh.oub_bill_det_state			, oh.oub_bill_det_phone			, oh.oub_bill_det_ship_addr		, oh.oub_consgn_name,
		oh.oub_cancel			, oh.oub_cancel_code			, oh.oub_prt_full_fill			, oh.oub_reason_code			, oh.etlactiveind,
		oh.etljobname			, oh.envsourcecd				, oh.datasourcecd				, oh.etlcreatedatetime			, oh.etlupdatedatetime,
		NOW()
    FROM dwh.f_outboundheader oh;

	ELSE

	UPDATE click.F_OutboundHeader coh
    SET
		obh_hr_key						= oh.obh_hr_key,
		oub_ou							= oh.oub_ou,
		oub_loc_code					= oh.oub_loc_code,
		oub_outbound_ord				= oh.oub_outbound_ord,
        obh_loc_key     				= oh.obh_loc_key,
        obh_cust_key    				= oh.obh_cust_key,
		oub_orderdatekey				= oh.oub_orderdatekey,
        oub_prim_rf_dc_typ				= oh.oub_prim_rf_dc_typ,
        oub_prim_rf_dc_no				= oh.oub_prim_rf_dc_no,
        oub_prim_rf_dc_date				= oh.oub_prim_rf_dc_date,
        oub_orderdate					= oh.oub_orderdate,
        oub_ob_status					= oh.oub_ob_status,
        oub_order_type					= oh.oub_order_type,
        oub_order_priority				= oh.oub_order_priority,
        oub_urgent_chk					= oh.oub_urgent_chk,
        oub_cust_code					= oh.oub_cust_code,
        oub_cust_type					= oh.oub_cust_type,
        oub_end_cust_ref_doc			= oh.oub_end_cust_ref_doc,
        oub_ord_src						= oh.oub_ord_src,
        oub_amendno						= oh.oub_amendno,
        oub_refdoctype					= oh.oub_refdoctype,
        oub_refdocno					= oh.oub_refdocno,
        oub_refdocdate					= oh.oub_refdocdate,
        oub_carriername					= oh.oub_carriername,
        oub_shipment_mode				= oh.oub_shipment_mode,
        oub_shipment_type				= oh.oub_shipment_type,
        oub_cnsgn_code_shpto			= oh.oub_cnsgn_code_shpto,
        oub_ship_point_id				= oh.oub_ship_point_id,
        oub_address1					= oh.oub_address1,
        oub_address2					= oh.oub_address2,
        oub_address3					= oh.oub_address3,
        oub_postcode					= oh.oub_postcode,
        oub_country						= oh.oub_country,
        oub_state						= oh.oub_state,
        oub_city						= oh.oub_city,
        oub_phoneno						= oh.oub_phoneno,
        oub_delivery_date				= oh.oub_delivery_date,
        oub_service_from				= oh.oub_service_from,
        oub_service_to					= oh.oub_service_to,
        oub_itm_plan_gd_iss_dt			= oh.oub_itm_plan_gd_iss_dt,
        oub_itm_plan_dt_iss				= oh.oub_itm_plan_dt_iss,
        oub_instructions				= oh.oub_instructions,
        oub_incoterms					= oh.oub_incoterms,
        oub_created_by					= oh.oub_created_by,
        oub_created_date				= oh.oub_created_date,
        oub_modified_by					= oh.oub_modified_by,
        oub_modified_date				= oh.oub_modified_date,
        oub_timestamp					= oh.oub_timestamp,
        oub_operation_status			= oh.oub_operation_status,
        oub_contract_id					= oh.oub_contract_id,
        oub_contract_amend_no			= oh.oub_contract_amend_no,
        oub_subservice_type				= oh.oub_subservice_type,
        oub_shp_name					= oh.oub_shp_name,
        oub_shp_zone					= oh.oub_shp_zone,
        oub_shp_sub_zne					= oh.oub_shp_sub_zne,
        oub_shp_region					= oh.oub_shp_region,
        oub_pickup_from_date_time		= oh.oub_pickup_from_date_time,
        oub_pickup_to_date_time			= oh.oub_pickup_to_date_time,
        oub_transport_location			= oh.oub_transport_location,
        oub_transport_service			= oh.oub_transport_service,
        oub_gen_req_id					= oh.oub_gen_req_id,
        oub_gen_from					= oh.oub_gen_from,
        oub_opfeboty_bil_status			= oh.oub_opfeboty_bil_status,
        oub_exp_stk						= oh.oub_exp_stk,
        oub_consolidation_no			= oh.oub_consolidation_no,
        oub_bill_to_name				= oh.oub_bill_to_name,
        oub_bill_det_addr_line1			= oh.oub_bill_det_addr_line1,
        oub_bill_det_addr_line2			= oh.oub_bill_det_addr_line2,
        oub_bill_det_post_code			= oh.oub_bill_det_post_code,
        oub_bill_det_country			= oh.oub_bill_det_country,
        oub_bill_det_city				= oh.oub_bill_det_city,
        oub_bill_det_state				= oh.oub_bill_det_state,
        oub_bill_det_phone				= oh.oub_bill_det_phone,
        oub_bill_det_ship_addr			= oh.oub_bill_det_ship_addr,
        oub_consgn_name					= oh.oub_consgn_name,
        oub_cancel						= oh.oub_cancel,
        oub_cancel_code					= oh.oub_cancel_code,
        oub_prt_full_fill				= oh.oub_prt_full_fill,
        oub_reason_code					= oh.oub_reason_code,
        etlactiveind					= oh.etlactiveind,
        etljobname						= oh.etljobname,
        envsourcecd						= oh.envsourcecd,
        datasourcecd					= oh.datasourcecd,
		etlcreatedatetime				= oh.etlcreatedatetime,
        etlupdatedatetime				= oh.etlupdatedatetime,
		updatedatetime					= NOW()
    FROM dwh.f_outboundheader oh
	WHERE coh.obh_hr_key				= oh.obh_hr_key
	AND COALESCE(oh.etlupdatedatetime,oh.etlcreatedatetime) >= v_maxdate;

	INSERT INTO click.F_outboundheader
	(
		obh_hr_key				, oub_ou						, oub_loc_code					, oub_outbound_ord				, obh_loc_key,
		obh_cust_key			, oub_orderdatekey				, oub_prim_rf_dc_typ			, oub_prim_rf_dc_no				, oub_prim_rf_dc_date,
		oub_orderdate			, oub_ob_status					, oub_order_type				, oub_order_priority			, oub_urgent_chk,
		oub_cust_code			, oub_cust_type					, oub_end_cust_ref_doc			, oub_ord_src					, oub_amendno,
		oub_refdoctype			, oub_refdocno					, oub_refdocdate				, oub_carriername				, oub_shipment_mode,
		oub_shipment_type		, oub_cnsgn_code_shpto			, oub_ship_point_id				, oub_address1					, oub_address2,
		oub_address3			, oub_postcode					, oub_country					, oub_state						, oub_city,
		oub_phoneno				, oub_delivery_date				, oub_service_from				, oub_service_to				, oub_itm_plan_gd_iss_dt,
		oub_itm_plan_dt_iss		, oub_instructions				, oub_incoterms					, oub_created_by				, oub_created_date,
		oub_modified_by			, oub_modified_date				, oub_timestamp					, oub_operation_status			, oub_contract_id,
		oub_contract_amend_no	, oub_subservice_type			, oub_shp_name					, oub_shp_zone					, oub_shp_sub_zne,
		oub_shp_region			, oub_pickup_from_date_time		, oub_pickup_to_date_time		, oub_transport_location		, oub_transport_service,
		oub_gen_req_id			, oub_gen_from					, oub_opfeboty_bil_status		, oub_exp_stk					, oub_consolidation_no,
		oub_bill_to_name		, oub_bill_det_addr_line1		, oub_bill_det_addr_line2		, oub_bill_det_post_code		, oub_bill_det_country,
		oub_bill_det_city		, oub_bill_det_state			, oub_bill_det_phone			, oub_bill_det_ship_addr		, oub_consgn_name,
		oub_cancel				, oub_cancel_code				, oub_prt_full_fill				, oub_reason_code				, etlactiveind,
		etljobname				, envsourcecd					, datasourcecd					, etlcreatedatetime				, etlupdatedatetime,
		createddate	
	)
	select
		oh.obh_hr_key			, oh.oub_ou						, oh.oub_loc_code				, oh.oub_outbound_ord			, oh.obh_loc_key,
		oh.obh_cust_key			, oh.oub_orderdatekey			, oh.oub_prim_rf_dc_typ			, oh.oub_prim_rf_dc_no			, oh.oub_prim_rf_dc_date,
		oh.oub_orderdate		, oh.oub_ob_status				, oh.oub_order_type				, oh.oub_order_priority			, oh.oub_urgent_chk,
		oh.oub_cust_code		, oh.oub_cust_type				, oh.oub_end_cust_ref_doc		, oh.oub_ord_src				, oh.oub_amendno,
		oh.oub_refdoctype		, oh.oub_refdocno				, oh.oub_refdocdate				, oh.oub_carriername			, oh.oub_shipment_mode,
		oh.oub_shipment_type	, oh.oub_cnsgn_code_shpto		, oh.oub_ship_point_id			, oh.oub_address1				, oh.oub_address2,
		oh.oub_address3			, oh.oub_postcode				, oh.oub_country				, oh.oub_state					, oh.oub_city,
		oh.oub_phoneno			, oh.oub_delivery_date			, oh.oub_service_from			, oh.oub_service_to				, oh.oub_itm_plan_gd_iss_dt,
		oh.oub_itm_plan_dt_iss	, oh.oub_instructions			, oh.oub_incoterms				, oh.oub_created_by				, oh.oub_created_date,
		oh.oub_modified_by		, oh.oub_modified_date			, oh.oub_timestamp				, oh.oub_operation_status		, oh.oub_contract_id,
		oh.oub_contract_amend_no, oh.oub_subservice_type		, oh.oub_shp_name				, oh.oub_shp_zone				, oh.oub_shp_sub_zne,
		oh.oub_shp_region		, oh.oub_pickup_from_date_time	, oh.oub_pickup_to_date_time	, oh.oub_transport_location		, oh.oub_transport_service,
		oh.oub_gen_req_id		, oh.oub_gen_from				, oh.oub_opfeboty_bil_status	, oh.oub_exp_stk				, oh.oub_consolidation_no,
		oh.oub_bill_to_name		, oh.oub_bill_det_addr_line1	, oh.oub_bill_det_addr_line2	, oh.oub_bill_det_post_code		, oh.oub_bill_det_country,
		oh.oub_bill_det_city	, oh.oub_bill_det_state			, oh.oub_bill_det_phone			, oh.oub_bill_det_ship_addr		, oh.oub_consgn_name,
		oh.oub_cancel			, oh.oub_cancel_code			, oh.oub_prt_full_fill			, oh.oub_reason_code			, oh.etlactiveind,
		oh.etljobname			, oh.envsourcecd				, oh.datasourcecd				, oh.etlcreatedatetime			, oh.etlupdatedatetime,
		NOW()
    FROM dwh.f_outboundheader OH
	LEFT JOIN click.F_outboundheader COH
	ON COH.obh_hr_key		= OH.obh_hr_key
	WHERE COALESCE(oh.etlupdatedatetime,oh.etlcreatedatetime) >= v_maxdate
	AND COH.obh_hr_key IS NULL;

END IF;

	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','F_outboundheader','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
  
END;
$BODY$;
ALTER PROCEDURE click.usp_f_outboundheader()
    OWNER TO proconnect;
