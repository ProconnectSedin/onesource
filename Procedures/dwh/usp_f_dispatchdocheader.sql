CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_ddh_dispatch_document_hdr;

    UPDATE dwh.F_DispatchDocHeader t
    SET
	
		ddh_loc_key							= COALESCE(l.loc_key,-1),
		ddh_curr_key						= COALESCE(c.curr_key,-1),
		ddh_consignee_hdr_key				= COALESCE(co.consignee_hdr_key,-1),
		ddh_customer_key					= COALESCE(ct.customer_key,-1),
        ddh_dispatch_doc_type               = s.ddh_dispatch_doc_type,
        ddh_dispatch_doc_mode               = s.ddh_dispatch_doc_mode,
        ddh_dispatch_doc_num_type           = s.ddh_dispatch_doc_num_type,
        ddh_dispatch_doc_status             = s.ddh_dispatch_doc_status,
        ddh_dispatch_doc_date               = s.ddh_dispatch_doc_date,
        ddh_transport_mode                  = s.ddh_transport_mode,
        ddh_reference_doc_type              = s.ddh_reference_doc_type,
        ddh_reference_doc_no                = s.ddh_reference_doc_no,
        ddh_customer_id                     = s.ddh_customer_id,
        ddh_cust_ref_no                     = s.ddh_cust_ref_no,
        ddh_consignee_id                    = s.ddh_consignee_id,
        ddh_ship_from_id                    = s.ddh_ship_from_id,
        ddh_ship_to_id                      = s.ddh_ship_to_id,
        ddh_declared_goods_value            = s.ddh_declared_goods_value,
        ddh_currency                        = s.ddh_currency,
        ddh_spl_instructions                = s.ddh_spl_instructions,
        ddh_created_by                      = s.ddh_created_by,
        ddh_created_date                    = s.ddh_created_date,
        ddh_last_modified_by                = s.ddh_last_modified_by,
        ddh_lst_modified_date               = s.ddh_lst_modified_date,
        ddh_trip_log                        = s.ddh_trip_log,
        ddh_location                        = s.ddh_location,
        ddh_billing_status                  = s.ddh_billing_status,
        ddh_autocreateCN_YN                 = s.ddh_autocreateCN_YN,
        ddh_pkup_recpt_no                   = s.ddh_pkup_recpt_no,
        ddh_service_type                    = s.ddh_service_type,
        ddh_subservice_type                 = s.ddh_subservice_type,
        ddtd_pick_up_date_time_con          = s.ddtd_pick_up_date_time_con,
        ddtd_delivery_date_time_con         = s.ddtd_delivery_date_time_con,
        ddh_Placeof_Receipt                 = s.ddh_Placeof_Receipt,
        ddh_Final_Destination               = s.ddh_Final_Destination,
        ddh_Net_Weight                      = s.ddh_Net_Weight,
        ddh_Gross_Weight                    = s.ddh_Gross_Weight,
        ddh_Total_Packages                  = s.ddh_Total_Packages,
        ddh_Chargeable_Weight               = s.ddh_Chargeable_Weight,
        ddh_guid                            = s.ddh_guid,
        ddh_weight_uom                      = s.ddh_weight_uom,
        ddh_total_volume                    = s.ddh_total_volume,
        ddh_volume_uom                      = s.ddh_volume_uom,
        ddh_senders_ref_no                  = s.ddh_senders_ref_no,
        ddh_receivers_ref_no                = s.ddh_receivers_ref_no,
        ddh_amend_version_no                = s.ddh_amend_version_no,
        ddh_reason_amendment                = s.ddh_reason_amendment,
        ddh_dispatch_doc_dvry_status        = s.ddh_dispatch_doc_dvry_status,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
    FROM stg.stg_tms_ddh_dispatch_document_hdr s
	LEFT JOIN dwh.d_location l 		
		ON 	s.ddh_location 			= l.loc_code 
        AND s.ddh_ouinstance        = l.loc_ou
	LEFT JOIN dwh.d_customer ct 		
		ON 	s.ddh_customer_id  		= ct.customer_id 
        AND s.ddh_ouinstance        = ct.customer_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.ddh_currency  		= c.iso_curr_code 
	LEFT JOIN dwh.d_consignee co 		
		ON 	s.ddh_consignee_id  	= co.consignee_id 
        AND s.ddh_ouinstance        = co.consignee_ou
    WHERE 	t.ddh_ouinstance 		= s.ddh_ouinstance
    AND 	t.ddh_dispatch_doc_no 	= s.ddh_dispatch_doc_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocHeader
    (
		ddh_loc_key, ddh_curr_key, ddh_consignee_hdr_key, ddh_customer_key,
        ddh_ouinstance, ddh_dispatch_doc_no, ddh_dispatch_doc_type, ddh_dispatch_doc_mode, ddh_dispatch_doc_num_type, ddh_dispatch_doc_status, ddh_dispatch_doc_date, ddh_transport_mode, ddh_reference_doc_type, ddh_reference_doc_no, ddh_customer_id, ddh_cust_ref_no, ddh_consignee_id, ddh_ship_from_id, ddh_ship_to_id, ddh_declared_goods_value, ddh_currency, ddh_spl_instructions, ddh_created_by, ddh_created_date, ddh_last_modified_by, ddh_lst_modified_date, ddh_trip_log, ddh_location, ddh_billing_status, ddh_autocreateCN_YN, ddh_pkup_recpt_no, ddh_service_type, ddh_subservice_type, ddtd_pick_up_date_time_con, ddtd_delivery_date_time_con, ddh_Placeof_Receipt, ddh_Final_Destination, ddh_Net_Weight, ddh_Gross_Weight, ddh_Total_Packages, ddh_Chargeable_Weight, ddh_guid, ddh_weight_uom, ddh_total_volume, ddh_volume_uom, ddh_senders_ref_no, ddh_receivers_ref_no, ddh_amend_version_no, ddh_reason_amendment, ddh_dispatch_doc_dvry_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),COALESCE(c.curr_key,-1),COALESCE(co.consignee_hdr_key,-1),COALESCE(ct.customer_key,-1),
        s.ddh_ouinstance, s.ddh_dispatch_doc_no, s.ddh_dispatch_doc_type, s.ddh_dispatch_doc_mode, s.ddh_dispatch_doc_num_type, s.ddh_dispatch_doc_status, s.ddh_dispatch_doc_date, s.ddh_transport_mode, s.ddh_reference_doc_type, s.ddh_reference_doc_no, s.ddh_customer_id, s.ddh_cust_ref_no, s.ddh_consignee_id, s.ddh_ship_from_id, s.ddh_ship_to_id, s.ddh_declared_goods_value, s.ddh_currency, s.ddh_spl_instructions, s.ddh_created_by, s.ddh_created_date, s.ddh_last_modified_by, s.ddh_lst_modified_date, s.ddh_trip_log, s.ddh_location, s.ddh_billing_status, s.ddh_autocreateCN_YN, s.ddh_pkup_recpt_no, s.ddh_service_type, s.ddh_subservice_type, s.ddtd_pick_up_date_time_con, s.ddtd_delivery_date_time_con, s.ddh_Placeof_Receipt, s.ddh_Final_Destination, s.ddh_Net_Weight, s.ddh_Gross_Weight, s.ddh_Total_Packages, s.ddh_Chargeable_Weight, s.ddh_guid, s.ddh_weight_uom, s.ddh_total_volume, s.ddh_volume_uom, s.ddh_senders_ref_no, s.ddh_receivers_ref_no, s.ddh_amend_version_no, s.ddh_reason_amendment, s.ddh_dispatch_doc_dvry_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_ddh_dispatch_document_hdr s
	LEFT JOIN dwh.d_location l 		
		ON 	s.ddh_location 			= l.loc_code 
        AND s.ddh_ouinstance        = l.loc_ou
	LEFT JOIN dwh.d_customer ct 		
		ON 	s.ddh_customer_id  		= ct.customer_id 
        AND s.ddh_ouinstance        = ct.customer_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.ddh_currency  		= c.iso_curr_code 
	LEFT JOIN dwh.d_consignee co 		
		ON 	s.ddh_consignee_id  	= co.consignee_id 
        AND s.ddh_ouinstance        = co.consignee_ou
    LEFT JOIN dwh.F_DispatchDocHeader t
    ON 		s.ddh_ouinstance 		= t.ddh_ouinstance
    AND 	s.ddh_dispatch_doc_no 	= t.ddh_dispatch_doc_no
    WHERE t.ddh_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_ddh_dispatch_document_hdr
    (
        ddh_ouinstance, ddh_dispatch_doc_no, ddh_dispatch_doc_type, ddh_dispatch_doc_mode, ddh_dispatch_doc_num_type, ddh_dispatch_doc_status, ddh_dispatch_doc_date, ddh_transport_mode, ddh_reference_doc_type, ddh_reference_doc_no, ddh_customer_id, ddh_cust_ref_no, ddh_consignor_id, ddh_consignee_id, ddh_ship_from_id, ddh_ship_to_id, ddh_declared_goods_value, ddh_currency, ddh_proforma, ddh_ship_agent_id, ddh_ship_agent_address_id, ddh_deliver_agent_id, ddh_deliver_agent_address_id, ddh_notify_party_id, ddh_notify_party_address_id, ddh_carrier_id, ddh_vessel_flight_rail_number, ddh_loading_or_departure_point, ddh_discharge_or_destination_point, ddh_arrival_date, ddh_departure_date, ddh_mbl_of_hbl, ddh_mawb_of_hawb, ddh_spl_instructions, ddh_additional_info, ddh_created_by, ddh_created_date, ddh_last_modified_by, ddh_lst_modified_date, ddh_timestamp, ddh_trip_log, ddh_location, ddh_billing_status, ddh_revenue, ddh_autocreateCN_YN, ddh_pkup_recpt_no, ddh_dlvy_recpt_no, ddh_service_type, ddh_subservice_type, ddtd_pick_up_date_time_con, ddtd_delivery_date_time_con, ddh_Agent, ddh_Forwarding_Agent, ddh_Cargo_Description, ddh_Marks_numbers, ddh_Placeof_Receipt, ddh_Final_Destination, ddh_Net_Weight, ddh_Gross_Weight, ddh_Total_Packages, ddh_Chargeable_Weight, ddh_Freight_Charges, ddh_Delivery_Terms, ddh_guid, ddh_Nature_Quantity_Goods, ddh_AgentIATA_Code, ddh_Rate_Class, ddh_CommodityItemNo, ddh_Accounting_Information, ddh_DeclaredValue_Charge, ddh_Issuing_Carrier_AgentName, ddh_Remarks, ddh_Handling_Information, ddh_Declared_ValueCustoms, ddh_Amount_Insurance, ddh_weight_uom, ddh_total_volume, ddh_volume_uom, ddh_senders_ref_no, ddh_receivers_ref_no, ddh_amend_version_no, ddh_type_of_doc, ddh_registry_no, ddh_cc_charges_destn_currency, ddh_destination_currency, ddh_currency_conver_rate, ddh_charges_code, ddh_reason_amendment, ddh_reason_description, ddh_amendment_remarks, ddh_other_charges, ddh_wtval_charges, ddh_dispatch_doc_dvry_status, etlcreateddatetime
    )
    SELECT
        ddh_ouinstance, ddh_dispatch_doc_no, ddh_dispatch_doc_type, ddh_dispatch_doc_mode, ddh_dispatch_doc_num_type, ddh_dispatch_doc_status, ddh_dispatch_doc_date, ddh_transport_mode, ddh_reference_doc_type, ddh_reference_doc_no, ddh_customer_id, ddh_cust_ref_no, ddh_consignor_id, ddh_consignee_id, ddh_ship_from_id, ddh_ship_to_id, ddh_declared_goods_value, ddh_currency, ddh_proforma, ddh_ship_agent_id, ddh_ship_agent_address_id, ddh_deliver_agent_id, ddh_deliver_agent_address_id, ddh_notify_party_id, ddh_notify_party_address_id, ddh_carrier_id, ddh_vessel_flight_rail_number, ddh_loading_or_departure_point, ddh_discharge_or_destination_point, ddh_arrival_date, ddh_departure_date, ddh_mbl_of_hbl, ddh_mawb_of_hawb, ddh_spl_instructions, ddh_additional_info, ddh_created_by, ddh_created_date, ddh_last_modified_by, ddh_lst_modified_date, ddh_timestamp, ddh_trip_log, ddh_location, ddh_billing_status, ddh_revenue, ddh_autocreateCN_YN, ddh_pkup_recpt_no, ddh_dlvy_recpt_no, ddh_service_type, ddh_subservice_type, ddtd_pick_up_date_time_con, ddtd_delivery_date_time_con, ddh_Agent, ddh_Forwarding_Agent, ddh_Cargo_Description, ddh_Marks_numbers, ddh_Placeof_Receipt, ddh_Final_Destination, ddh_Net_Weight, ddh_Gross_Weight, ddh_Total_Packages, ddh_Chargeable_Weight, ddh_Freight_Charges, ddh_Delivery_Terms, ddh_guid, ddh_Nature_Quantity_Goods, ddh_AgentIATA_Code, ddh_Rate_Class, ddh_CommodityItemNo, ddh_Accounting_Information, ddh_DeclaredValue_Charge, ddh_Issuing_Carrier_AgentName, ddh_Remarks, ddh_Handling_Information, ddh_Declared_ValueCustoms, ddh_Amount_Insurance, ddh_weight_uom, ddh_total_volume, ddh_volume_uom, ddh_senders_ref_no, ddh_receivers_ref_no, ddh_amend_version_no, ddh_type_of_doc, ddh_registry_no, ddh_cc_charges_destn_currency, ddh_destination_currency, ddh_currency_conver_rate, ddh_charges_code, ddh_reason_amendment, ddh_reason_description, ddh_amendment_remarks, ddh_other_charges, ddh_wtval_charges, ddh_dispatch_doc_dvry_status, etlcreateddatetime
    FROM stg.stg_tms_ddh_dispatch_document_hdr;
    END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;