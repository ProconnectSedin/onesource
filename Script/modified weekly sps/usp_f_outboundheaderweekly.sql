-- PROCEDURE: dwh.usp_f_outboundheaderweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outboundheaderweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outboundheaderweekly(
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
/* PROCEDURE		:	dwh.usp_f_outboundheaderweekly														 				 */
/* DESCRIPTION		:	This sp is used to load f_outboundheaderweekly table from stg_wms_outbound_header        			 			 */
/*						Load Strategy: Insert/Update 															 */
/*						Sources: wms_outbound_header_w					 		 									 */
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
/* EXECUTION SAMPLE :CALL dwh.usp_f_outboundheaderweekly('wms_outbound_header_w','StgtoDW','f_outboundheader',0,0,0,0,NULL,NULL);*/
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, d.intervaldays
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_interval
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
		

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_outbound_header;

    UPDATE dwh.F_OutboundHeader t
    SET
        obh_loc_key     				= COALESCE(l.loc_key,-1),
        obh_cust_key    				= COALESCE(c.customer_key,-1),
		oub_orderdatekey				= COALESCE(d.datekey,-1),
        oub_prim_rf_dc_typ               = s.wms_oub_prim_rf_dc_typ,
        oub_prim_rf_dc_no                = s.wms_oub_prim_rf_dc_no,
        oub_prim_rf_dc_date              = s.wms_oub_prim_rf_dc_date,
        oub_orderdate                    = s.wms_oub_orderdate,
        oub_ob_status                    = s.wms_oub_ob_status,
        oub_order_type                   = s.wms_oub_order_type,
        oub_order_priority               = s.wms_oub_order_priority,
        oub_urgent_chk                   = s.wms_oub_urgent_chk,
        oub_cust_code                    = s.wms_oub_cust_code,
        oub_cust_type                    = s.wms_oub_cust_type,
        oub_end_cust_ref_doc             = s.wms_oub_end_cust_ref_doc,
        oub_ord_src                      = s.wms_oub_ord_src,
        oub_amendno                      = s.wms_oub_amendno,
        oub_refdoctype                   = s.wms_oub_refdoctype,
        oub_refdocno                     = s.wms_oub_refdocno,
        oub_refdocdate                   = s.wms_oub_refdocdate,
        oub_carriername                  = s.wms_oub_carriername,
        oub_shipment_mode                = s.wms_oub_shipment_mode,
        oub_shipment_type                = s.wms_oub_shipment_type,
        oub_cnsgn_code_shpto             = s.wms_oub_cnsgn_code_shpto,
        oub_ship_point_id                = s.wms_oub_ship_point_id,
        oub_address1                     = s.wms_oub_address1,
        oub_address2                     = s.wms_oub_address2,
        oub_address3                     = s.wms_oub_address3,
        oub_postcode                     = s.wms_oub_postcode,
        oub_country                      = s.wms_oub_country,
        oub_state                        = s.wms_oub_state,
        oub_city                         = s.wms_oub_city,
        oub_phoneno                      = s.wms_oub_phoneno,
        oub_delivery_date                = s.wms_oub_delivery_date,
        oub_service_from                 = s.wms_oub_service_from,
        oub_service_to                   = s.wms_oub_service_to,
        oub_itm_plan_gd_iss_dt           = s.wms_oub_itm_plan_gd_iss_dt,
        oub_itm_plan_dt_iss              = s.wms_oub_itm_plan_dt_iss,
        oub_instructions                 = s.wms_oub_instructions,
        oub_incoterms                    = s.wms_oub_incoterms,
        oub_created_by                   = s.wms_oub_created_by,
        oub_created_date                 = s.wms_oub_created_date,
        oub_modified_by                  = s.wms_oub_modified_by,
        oub_modified_date                = s.wms_oub_modified_date,
        oub_timestamp                    = s.wms_oub_timestamp,
        oub_operation_status             = s.wms_oub_operation_status,
        oub_contract_id                  = s.wms_oub_contract_id,
        oub_contract_amend_no            = s.wms_oub_contract_amend_no,
        oub_subservice_type              = s.wms_oub_subservice_type,
        oub_shp_name                     = s.wms_oub_shp_name,
        oub_shp_zone                     = s.wms_oub_shp_zone,
        oub_shp_sub_zne                  = s.wms_oub_shp_sub_zne,
        oub_shp_region                   = s.wms_oub_shp_region,
        oub_pickup_from_date_time        = s.wms_oub_pickup_from_date_time,
        oub_pickup_to_date_time          = s.wms_oub_pickup_to_date_time,
        oub_transport_location           = s.wms_oub_transport_location,
        oub_transport_service            = s.wms_oub_transport_service,
        oub_gen_req_id                   = s.wms_oub_gen_req_id,
        oub_gen_from                     = s.wms_oub_gen_from,
        oub_opfeboty_bil_status          = s.wms_oub_opfeboty_bil_status,
        oub_exp_stk                      = s.wms_oub_exp_stk,
        oub_consolidation_no             = s.wms_oub_consolidation_no,
        oub_bill_to_name                 = s.wms_oub_bill_to_name,
        oub_bill_det_addr_line1          = s.wms_oub_bill_det_addr_line1,
        oub_bill_det_addr_line2          = s.wms_oub_bill_det_addr_line2,
        oub_bill_det_post_code           = s.wms_oub_bill_det_post_code,
        oub_bill_det_country             = s.wms_oub_bill_det_country,
        oub_bill_det_city                = s.wms_oub_bill_det_city,
        oub_bill_det_state               = s.wms_oub_bill_det_state,
        oub_bill_det_phone               = s.wms_oub_bill_det_phone,
        oub_bill_det_ship_addr           = s.wms_oub_bill_det_ship_addr,
        oub_consgn_name                  = s.wms_oub_consgn_name,
        oub_cancel                       = s.wms_oub_cancel,
        oub_cancel_code                  = s.wms_oub_cancel_code,
        oub_prt_full_fill                = s.wms_oub_prt_full_fill,
        oub_reason_code                  = s.wms_oub_reason_code,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_wms_outbound_header s
	 LEFT JOIN dwh.d_location L      
        ON s.wms_oub_loc_code   = L.loc_code 
        AND s.wms_oub_ou      = L.loc_ou
    LEFT JOIN dwh.d_customer C      
        ON s.wms_oub_cust_code  = C.customer_id 
        AND s.wms_oub_ou        = C.customer_ou
	LEFT JOIN dwh.d_date d
		ON s.wms_oub_orderdate::date = d.dateactual
    WHERE t.oub_ou = s.wms_oub_ou
    AND t.oub_loc_code = s.wms_oub_loc_code
    AND t.oub_outbound_ord = s.wms_oub_outbound_ord;

    GET DIAGNOSTICS updcnt = ROW_COUNT;
	

/*
	DELETE from dwh.F_OutboundHeader t
	USING stg.stg_wms_outbound_header s
    where s.wms_oub_ou = t.oub_ou
    AND s.wms_oub_loc_code = t.oub_loc_code
    AND s.wms_oub_outbound_ord = t.oub_outbound_ord;
-- 	where COALESCE(oub_modified_date,oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
    INSERT INTO dwh.F_OutboundHeader
    (
		obh_loc_key, obh_cust_key, oub_orderdatekey,
		oub_ou, oub_loc_code, oub_outbound_ord, oub_prim_rf_dc_typ, oub_prim_rf_dc_no, oub_prim_rf_dc_date, 
		oub_orderdate, oub_ob_status, oub_order_type, oub_order_priority, oub_urgent_chk, oub_cust_code, 
		oub_cust_type, oub_end_cust_ref_doc, oub_ord_src, oub_amendno, oub_refdoctype, oub_refdocno, 
		oub_refdocdate, oub_carriername, oub_shipment_mode, oub_shipment_type, oub_cnsgn_code_shpto, 
		oub_ship_point_id, oub_address1, oub_address2, oub_address3, oub_postcode, oub_country, oub_state, 
		oub_city, oub_phoneno, oub_delivery_date, oub_service_from, oub_service_to, oub_itm_plan_gd_iss_dt, 
		oub_itm_plan_dt_iss, oub_instructions, oub_incoterms, oub_created_by, oub_created_date, oub_modified_by, 
		oub_modified_date, oub_timestamp, oub_operation_status, oub_contract_id, oub_contract_amend_no, oub_subservice_type, oub_shp_name, oub_shp_zone, oub_shp_sub_zne, oub_shp_region, oub_pickup_from_date_time, oub_pickup_to_date_time, oub_transport_location, oub_transport_service, oub_gen_req_id, oub_gen_from, oub_opfeboty_bil_status, oub_exp_stk, oub_consolidation_no, oub_bill_to_name, oub_bill_det_addr_line1, oub_bill_det_addr_line2, oub_bill_det_post_code, oub_bill_det_country, oub_bill_det_city, oub_bill_det_state, oub_bill_det_phone, oub_bill_det_ship_addr, oub_consgn_name, oub_cancel, oub_cancel_code, oub_prt_full_fill, oub_reason_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(l.loc_key,-1),COALESCE(c.customer_key,-1),COALESCE(d.datekey,-1),
	   s.wms_oub_ou, s.wms_oub_loc_code, s.wms_oub_outbound_ord, s.wms_oub_prim_rf_dc_typ, s.wms_oub_prim_rf_dc_no, s.wms_oub_prim_rf_dc_date, s.wms_oub_orderdate, s.wms_oub_ob_status, s.wms_oub_order_type, s.wms_oub_order_priority, s.wms_oub_urgent_chk, s.wms_oub_cust_code, s.wms_oub_cust_type, s.wms_oub_end_cust_ref_doc, s.wms_oub_ord_src, s.wms_oub_amendno, s.wms_oub_refdoctype, s.wms_oub_refdocno, s.wms_oub_refdocdate, s.wms_oub_carriername, s.wms_oub_shipment_mode, s.wms_oub_shipment_type, s.wms_oub_cnsgn_code_shpto, s.wms_oub_ship_point_id, s.wms_oub_address1, s.wms_oub_address2, s.wms_oub_address3, s.wms_oub_postcode, s.wms_oub_country, s.wms_oub_state, s.wms_oub_city, s.wms_oub_phoneno, s.wms_oub_delivery_date, s.wms_oub_service_from, s.wms_oub_service_to, s.wms_oub_itm_plan_gd_iss_dt, s.wms_oub_itm_plan_dt_iss, s.wms_oub_instructions, s.wms_oub_incoterms, s.wms_oub_created_by, s.wms_oub_created_date, s.wms_oub_modified_by, s.wms_oub_modified_date, s.wms_oub_timestamp, s.wms_oub_operation_status, s.wms_oub_contract_id, s.wms_oub_contract_amend_no, s.wms_oub_subservice_type, s.wms_oub_shp_name, s.wms_oub_shp_zone, s.wms_oub_shp_sub_zne, s.wms_oub_shp_region, s.wms_oub_pickup_from_date_time, s.wms_oub_pickup_to_date_time, s.wms_oub_transport_location, s.wms_oub_transport_service, s.wms_oub_gen_req_id, s.wms_oub_gen_from, s.wms_oub_opfeboty_bil_status, s.wms_oub_exp_stk, s.wms_oub_consolidation_no, s.wms_oub_bill_to_name, s.wms_oub_bill_det_addr_line1, s.wms_oub_bill_det_addr_line2, s.wms_oub_bill_det_post_code, s.wms_oub_bill_det_country, s.wms_oub_bill_det_city, s.wms_oub_bill_det_state, s.wms_oub_bill_det_phone, s.wms_oub_bill_det_ship_addr, s.wms_oub_consgn_name, s.wms_oub_cancel, s.wms_oub_cancel_code, s.wms_oub_prt_full_fill, s.wms_oub_reason_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_outbound_header s
	 LEFT JOIN dwh.d_location L      
        ON s.wms_oub_loc_code   = L.loc_code 
        AND s.wms_oub_ou      = L.loc_ou
    LEFT JOIN dwh.d_customer C      
        ON s.wms_oub_cust_code  = C.customer_id 
        AND s.wms_oub_ou        = C.customer_ou
	LEFT JOIN dwh.d_date d
		ON s.wms_oub_orderdate::date = d.dateactual
    LEFT JOIN dwh.F_OutboundHeader t
    ON s.wms_oub_ou = t.oub_ou
    AND s.wms_oub_loc_code = t.oub_loc_code
    AND s.wms_oub_outbound_ord = t.oub_outbound_ord
    WHERE t.oub_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	update dwh.F_OutboundHeader t1
	set etlactiveind =  0,
	etlupdatedatetime = Now()::timestamp
	from dwh.F_OutboundHeader t
	left join stg.stg_wms_outbound_header s
	ON s.wms_oub_ou = t.oub_ou
	AND s.wms_oub_loc_code = t.oub_loc_code
	AND s.wms_oub_outbound_ord = t.oub_outbound_ord
	AND t.obh_hr_key=t1.obh_hr_key
	WHERE COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	AND s.wms_oub_loc_code is null;
	
	--GET DIAGNOSTICS updcnt = ROW_COUNT;
	
	
	
	
	--select 0 into updcnt;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_outbound_header
    (
        wms_oub_ou, wms_oub_loc_code, wms_oub_outbound_ord, wms_oub_prim_rf_dc_typ, wms_oub_prim_rf_dc_no, wms_oub_prim_rf_dc_date, wms_oub_orderdate, wms_oub_ob_status, wms_oub_order_type, wms_oub_order_priority, wms_oub_urgent_chk, wms_oub_cust_code, wms_oub_cust_type, wms_oub_end_cust_ref_doc, wms_oub_address_id, wms_oub_ord_src, wms_oub_amendno, wms_oub_refdoctype, wms_oub_refdocno, wms_oub_refdocdate, wms_oub_secrefdoctype1, wms_oub_secrefdoctype2, wms_oub_secrefdoctype3, wms_oub_secrefdocno1, wms_oub_secrefdocno2, wms_oub_secrefdocno3, wms_oub_secrefdocdate1, wms_oub_secrefdocdate2, wms_oub_secrefdocdate3, wms_oub_carriername, wms_oub_shipment_mode, wms_oub_shipment_type, wms_oub_cnsgn_code_shpto, wms_oub_ship_point_id, wms_oub_address1, wms_oub_address2, wms_oub_address3, wms_oub_unqaddress, wms_oub_postcode, wms_oub_country, wms_oub_state, wms_oub_city, wms_oub_phoneno, wms_oub_delivery_date, wms_oub_service_from, wms_oub_service_to, wms_oub_itm_plan_gd_iss_dt, wms_oub_itm_plan_dt_iss, wms_oub_instructions, wms_oub_incoterms, wms_oub_inco_location, wms_oub_country_of_origin, wms_oub_port_of_shipment, wms_oub_destination_country, wms_oub_port_destination, wms_oub_created_by, wms_oub_created_date, wms_oub_modified_by, wms_oub_modified_date, wms_oub_timestamp, wms_oub_userdefined1, wms_oub_userdefined2, wms_oub_userdefined3, wms_oub_operation_status, wms_oub_contract_id, wms_oub_contract_amend_no, wms_oub_subservice_type, wms_oub_shp_name, wms_oub_shp_zone, wms_oub_shp_sub_zne, wms_oub_shp_region, wms_oub_pickup_from_date_time, wms_oub_pickup_to_date_time, wms_oub_transport_location, wms_oub_transport_service, wms_oub_edifee_bil_status, wms_oub_ordprfee_bil_status, wms_oub_baschgpo_bil_status, wms_oub_priority_bil_status, wms_oub_kmedipro_bil_status, wms_oub_odopln_bil_status, wms_oub_gen_req_id, wms_oub_gen_from, wms_oub_opfeboty_bil_status, wms_oub_exp_stk, wms_oub_consolidation_no, wms_oub_channel_type, wms_oub_seller_type, wms_oub_bill_to_name, wms_oub_bill_det_addr_line1, wms_oub_bill_det_addr_line2, wms_oub_bill_det_post_code, wms_oub_bill_det_country, wms_oub_bill_det_city, wms_oub_bill_det_state, wms_oub_bill_det_phone, wms_oub_bill_det_ship_addr, wms_oub_bill_det_pay_gate_auth_no, wms_oub_bill_det_auth_date, wms_oub_bill_det_pay_sts, wms_oub_consgn_name, wms_oub_cancel, wms_oub_cancel_code, wms_oub_prt_full_fill, wms_oub_staxcbuy_bil_status, wms_oub_orprfbos_bil_status, wms_oub_txchrgsl_bil_status, wms_oub_shpchrsl_bil_status, wms_oub_reason_code, wms_oub_odoprll_bil_status, wms_oub_verte_order_no, wms_oub_markprch_sell_bil_status, wms_oub_trippln_id, wms_oub_whexchpd_sell_bil_status, wms_oub_wechbain_sell_bil_status, wms_oub_chbtnsin_sell_bil_status, wms_oub_markmior_sell_bil_status, wms_oub_hcoqumot_sell_bil_status, wms_oub_hdchotqt_status, wms_oub_hcdeotqt_status, wms_oub_br_ou, wms_oub_chporcn_sell_bil_status, wms_oub_chactinv_sell_bil_status, wms_oub_ffgvsmmo_sell_bil_status, wms_oub_cupkslch_sell_bil_status, wms_transport_activity, etlcreateddatetime
    )
    SELECT
        wms_oub_ou, wms_oub_loc_code, wms_oub_outbound_ord, wms_oub_prim_rf_dc_typ, wms_oub_prim_rf_dc_no, wms_oub_prim_rf_dc_date, wms_oub_orderdate, wms_oub_ob_status, wms_oub_order_type, wms_oub_order_priority, wms_oub_urgent_chk, wms_oub_cust_code, wms_oub_cust_type, wms_oub_end_cust_ref_doc, wms_oub_address_id, wms_oub_ord_src, wms_oub_amendno, wms_oub_refdoctype, wms_oub_refdocno, wms_oub_refdocdate, wms_oub_secrefdoctype1, wms_oub_secrefdoctype2, wms_oub_secrefdoctype3, wms_oub_secrefdocno1, wms_oub_secrefdocno2, wms_oub_secrefdocno3, wms_oub_secrefdocdate1, wms_oub_secrefdocdate2, wms_oub_secrefdocdate3, wms_oub_carriername, wms_oub_shipment_mode, wms_oub_shipment_type, wms_oub_cnsgn_code_shpto, wms_oub_ship_point_id, wms_oub_address1, wms_oub_address2, wms_oub_address3, wms_oub_unqaddress, wms_oub_postcode, wms_oub_country, wms_oub_state, wms_oub_city, wms_oub_phoneno, wms_oub_delivery_date, wms_oub_service_from, wms_oub_service_to, wms_oub_itm_plan_gd_iss_dt, wms_oub_itm_plan_dt_iss, wms_oub_instructions, wms_oub_incoterms, wms_oub_inco_location, wms_oub_country_of_origin, wms_oub_port_of_shipment, wms_oub_destination_country, wms_oub_port_destination, wms_oub_created_by, wms_oub_created_date, wms_oub_modified_by, wms_oub_modified_date, wms_oub_timestamp, wms_oub_userdefined1, wms_oub_userdefined2, wms_oub_userdefined3, wms_oub_operation_status, wms_oub_contract_id, wms_oub_contract_amend_no, wms_oub_subservice_type, wms_oub_shp_name, wms_oub_shp_zone, wms_oub_shp_sub_zne, wms_oub_shp_region, wms_oub_pickup_from_date_time, wms_oub_pickup_to_date_time, wms_oub_transport_location, wms_oub_transport_service, wms_oub_edifee_bil_status, wms_oub_ordprfee_bil_status, wms_oub_baschgpo_bil_status, wms_oub_priority_bil_status, wms_oub_kmedipro_bil_status, wms_oub_odopln_bil_status, wms_oub_gen_req_id, wms_oub_gen_from, wms_oub_opfeboty_bil_status, wms_oub_exp_stk, wms_oub_consolidation_no, wms_oub_channel_type, wms_oub_seller_type, wms_oub_bill_to_name, wms_oub_bill_det_addr_line1, wms_oub_bill_det_addr_line2, wms_oub_bill_det_post_code, wms_oub_bill_det_country, wms_oub_bill_det_city, wms_oub_bill_det_state, wms_oub_bill_det_phone, wms_oub_bill_det_ship_addr, wms_oub_bill_det_pay_gate_auth_no, wms_oub_bill_det_auth_date, wms_oub_bill_det_pay_sts, wms_oub_consgn_name, wms_oub_cancel, wms_oub_cancel_code, wms_oub_prt_full_fill, wms_oub_staxcbuy_bil_status, wms_oub_orprfbos_bil_status, wms_oub_txchrgsl_bil_status, wms_oub_shpchrsl_bil_status, wms_oub_reason_code, wms_oub_odoprll_bil_status, wms_oub_verte_order_no, wms_oub_markprch_sell_bil_status, wms_oub_trippln_id, wms_oub_whexchpd_sell_bil_status, wms_oub_wechbain_sell_bil_status, wms_oub_chbtnsin_sell_bil_status, wms_oub_markmior_sell_bil_status, wms_oub_hcoqumot_sell_bil_status, wms_oub_hdchotqt_status, wms_oub_hcdeotqt_status, wms_oub_br_ou, wms_oub_chporcn_sell_bil_status, wms_oub_chactinv_sell_bil_status, wms_oub_ffgvsmmo_sell_bil_status, wms_oub_cupkslch_sell_bil_status, wms_transport_activity, etlcreateddatetime
    FROM stg.stg_wms_outbound_header;
    END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_outboundheaderweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
