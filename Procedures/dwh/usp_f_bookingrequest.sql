CREATE OR REPLACE PROCEDURE dwh.usp_f_bookingrequest(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_br_booking_request_hdr;

    UPDATE dwh.F_BookingRequest t
    SET
    
        br_loc_key							= COALESCE(l.loc_key,-1),
		br_curr_key							= COALESCE(c.curr_key,-1),
		br_rou_key							= COALESCE(r.rou_key,-1),
		br_customer_key						= COALESCE(ct.customer_key,-1),
        br_customer_id                      = s.br_customer_id,
        br_status                           = s.br_status,
        br_type                             = s.br_type,
        br_customer_ref_no                  = s.br_customer_ref_no,
        br_receiver_ref_no                  = s.br_receiver_ref_no,
        br_payment_ref_no                   = s.br_payment_ref_no,
        br_service_type                     = s.br_service_type,
        br_sub_service_type                 = s.br_sub_service_type,
        br_transport_mode                   = s.br_transport_mode,
        br_inco_terms                       = s.br_inco_terms,
        br_comments                         = s.br_comments,
        br_consigner_customer_same          = s.br_consigner_customer_same,
        br_timestamp                        = s.br_timestamp,
        br_original_br_id                   = s.br_original_br_id,
        br_request_confirmation_date        = s.br_request_confirmation_date,
        br_validation_profile_id            = s.br_validation_profile_id,
        br_contract_id                      = s.br_contract_id,
        br_route_id                         = s.br_route_id,
        br_revenue                          = s.br_revenue,
        br_error_code                       = s.br_error_code,
        br_priority                         = s.br_priority,
        br_recurring_flag                   = s.br_recurring_flag,
        br_customer_location                = s.br_customer_location,
        br_payment_type                     = s.br_payment_type,
        br_customer_primary_phone           = s.br_customer_primary_phone,
        br_customer_email_id                = s.br_customer_email_id,
        br_sender_ref_no                    = s.br_sender_ref_no,
        br_create_as_template               = s.br_create_as_template,
        br_creation_date                    = s.br_creation_date,
        br_created_by                       = s.br_created_by,
        br_last_modified_date               = s.br_last_modified_date,
        br_last_modified_by                 = s.br_last_modified_by,
        br_billing_status                   = s.br_billing_status,
        br_requested_date                   = s.br_requested_date,
        br_reason_code                      = s.br_reason_code,
        br_remarks                          = s.br_remarks,
        br_contract_amend_no                = s.br_contract_amend_no,
        br_Hazardous                        = s.br_Hazardous,
        br_order_type                       = s.br_order_type,
        br_inslia_redington                 = s.br_inslia_redington,
        br_shippers_inv_no                  = s.br_shippers_inv_no,
        br_invoice_value                    = s.br_invoice_value,
        br_currency                         = s.br_currency,
        brrd_shippers_invoice_date          = s.brrd_shippers_invoice_date,
        br_bill_to_id                       = s.br_bill_to_id,
        br_creation_source                  = s.br_creation_source,
        br_wf_guid                          = s.br_wf_guid,
        br_previous_status                  = s.br_previous_status,
        br_status_prior_Amend               = s.br_status_prior_Amend,
        br_declared_value                   = s.br_declared_value,
        br_Insurance_value                  = s.br_Insurance_value,
        br_cod                              = s.br_cod,
        br_cop                              = s.br_cop,
        br_shipping_fee                     = s.br_shipping_fee,
        br_collection_mode                  = s.br_collection_mode,
        br_include                          = s.br_include,
        br_reversal_jv_date                 = s.br_reversal_jv_date,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
    FROM stg.stg_tms_br_booking_request_hdr s
	LEFT JOIN dwh.d_location l 		
		ON 	s.br_customer_location 			= l.loc_code 
        AND s.br_ouinstance        			= l.loc_ou
	LEFT JOIN dwh.d_customer ct 		
		ON 	s.br_customer_id  				= ct.customer_id 
        AND s.br_ouinstance        			= ct.customer_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.br_currency  					= c.iso_curr_code 
	LEFT JOIN dwh.d_route r 		
		ON 	s.br_route_id  					= r.rou_route_id 
        AND s.br_ouinstance        			= r.rou_ou
    WHERE 	t.br_ouinstance 				= s.br_ouinstance
    AND 	t.br_request_Id 				= s.br_request_Id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_BookingRequest
    (
		br_loc_key,					br_curr_key,					br_rou_key,					br_customer_key,
        br_ouinstance, 				br_request_Id, 					br_customer_id, 			br_status, 					br_type, 
		br_customer_ref_no, 		br_receiver_ref_no, 			br_payment_ref_no, 			br_service_type, 			br_sub_service_type, 
		br_transport_mode, 			br_inco_terms, 					br_comments, 				br_consigner_customer_same, br_timestamp, 
		br_original_br_id, 			br_request_confirmation_date, 	br_validation_profile_id, 	br_contract_id, 			br_route_id, 
		br_revenue, 				br_error_code, 					br_priority, 				br_recurring_flag, 			br_customer_location, 
		br_payment_type, 			br_customer_primary_phone, 		br_customer_email_id, 		br_sender_ref_no, 			br_create_as_template, 
		br_creation_date, 			br_created_by, 					br_last_modified_date, 		br_last_modified_by, 		br_billing_status, 
		br_requested_date, 			br_reason_code, 				br_remarks, 				br_contract_amend_no, 		br_Hazardous, 
		br_order_type, 				br_inslia_redington, 			br_shippers_inv_no, 		br_invoice_value, 			br_currency, 
		brrd_shippers_invoice_date, br_bill_to_id, 					br_creation_source, 		br_wf_guid, 				br_previous_status, 
		br_status_prior_Amend, 		br_declared_value, 				br_Insurance_value, 		br_cod, br_cop, 			br_shipping_fee, 
		br_collection_mode, 		br_include, 					br_reversal_jv_date, 		etlactiveind, 				etljobname, 
		envsourcecd, 				datasourcecd, 					etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),			COALESCE(c.curr_key,-1),			COALESCE(r.rou_key,-1),			COALESCE(ct.customer_key,-1),
		s.br_ouinstance, 				s.br_request_Id, 					s.br_customer_id, 				s.br_status, 					s.br_type, 
		s.br_customer_ref_no, 			s.br_receiver_ref_no, 				s.br_payment_ref_no, 			s.br_service_type, 				s.br_sub_service_type, 
		s.br_transport_mode, 			s.br_inco_terms, 					s.br_comments, 					s.br_consigner_customer_same, 	s.br_timestamp, 
		s.br_original_br_id, 			s.br_request_confirmation_date, 	s.br_validation_profile_id, 	s.br_contract_id, 				s.br_route_id, 
		s.br_revenue, 					s.br_error_code, 					s.br_priority, 					s.br_recurring_flag, 			s.br_customer_location, 
		s.br_payment_type, 				s.br_customer_primary_phone, 		s.br_customer_email_id, 		s.br_sender_ref_no, 			s.br_create_as_template, 
		s.br_creation_date, 			s.br_created_by, 					s.br_last_modified_date, 		s.br_last_modified_by, 			s.br_billing_status, 
		s.br_requested_date, 			s.br_reason_code, 					s.br_remarks, 					s.br_contract_amend_no, 		s.br_Hazardous, 
		s.br_order_type, 				s.br_inslia_redington, 				s.br_shippers_inv_no, 			s.br_invoice_value, 			s.br_currency, 
		s.brrd_shippers_invoice_date, 	s.br_bill_to_id, 					s.br_creation_source, 			s.br_wf_guid, 					s.br_previous_status, 
		s.br_status_prior_Amend, 		s.br_declared_value, 				s.br_Insurance_value, 			s.br_cod, s.br_cop, 			s.br_shipping_fee, 
		s.br_collection_mode, 			s.br_include, 						s.br_reversal_jv_date, 		
        1, 								p_etljobname, 						p_envsourcecd, 					p_datasourcecd, 				NOW()
    FROM stg.stg_tms_br_booking_request_hdr s
	LEFT JOIN dwh.d_location l 		
		ON 	s.br_customer_location 			= l.loc_code 
        AND s.br_ouinstance        			= l.loc_ou
	LEFT JOIN dwh.d_customer ct 		
		ON 	s.br_customer_id  				= ct.customer_id 
        AND s.br_ouinstance        			= ct.customer_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.br_currency  					= c.iso_curr_code 
	LEFT JOIN dwh.d_route r 		
		ON 	s.br_route_id  					= r.rou_route_id 
        AND s.br_ouinstance        			= r.rou_ou
    LEFT JOIN dwh.F_BookingRequest t
    ON 		s.br_ouinstance 				= t.br_ouinstance
    AND 	s.br_request_Id 				= t.br_request_Id
    WHERE 	t.br_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_br_booking_request_hdr
    (
        br_ouinstance, 			br_request_Id, 					br_customer_id, 			br_status, 					br_type, 
		br_customer_ref_no, 	br_receiver_ref_no, 			br_payment_ref_no, 			br_service_type, 			br_sub_service_type, 
		br_transport_mode, 		br_inco_terms, 					br_ref_doc_type1, 			br_ref_doc_type2, 			br_ref_doc_type3, 
		br_ref_doc_no1, 		br_ref_doc_no2, 				br_ref_doc_no3, 			br_quote_requested, 		br_requestor_name, 
		br_phone_no, 			br_email_id, 					br_comments, 				br_consigner_customer_same, br_quote_currency, 
		br_pref_cha_name, 		br_pref_cha_phone_no, 			br_pref_cha_email_id, 		br_timestamp, 				br_original_br_id, 
		br_unique_id, 			br_request_confirmation_date, 	br_validation_profile_id, 	br_contract_id, 			br_rate_id, 
		br_route_id, 			br_sales_account, 				br_revenue, 				br_error_code, 				br_priority, 
		br_recurring_flag, 		br_customer_location, 			br_payment_type, 			br_customer_primary_phone, 	br_customer_email_id, 
		br_consignor_id, 		br_consignor_primary_phone, 	br_consignor_email_id, 		br_sender_ref_no, 			br_create_as_template, 
		br_creation_date, 		br_created_by, 					br_last_modified_date, 		br_last_modified_by, 		br_fc_or_regular, 
		br_billing_status, 		br_requested_date, 				br_reason_code, 			br_remarks, 				br_contract_amend_no, 
		br_Hazardous, 			br_break_burst_parent, 			br_break_burst_type, 		br_order_type, 				br_inslia_redington, 
		br_shippers_inv_no, 	br_invoice_value, 				br_currency, 				br_cargo_desc, 				br_marks_and_numbers, 
		br_load_type, 			br_delivery_terms, 				brrd_shippers_invoice_date, br_operating_plan_ref, 		br_bill_to_id, 
		br_creation_source, 	br_creation_source_id, 			br_workflow_status, 		br_workflow_error, 			br_wf_guid, 
		br_previous_status, 	br_status_prior_Amend, 			br_clubbing_type, 			br_time_bound, 				br_source, 
		br_declared_value, 		br_Insurance_value, 			br_tariff_adv_YN, 			br_cod, 					br_cop, 
		br_shipping_fee, 		br_collection_mode, 			br_advance_tariff_YN, 		br_penalty_flag, 			br_include, 
		br_error_desc, 			br_Franchisee_bill_status, 		br_creationservice_name, 	br_sla_period, 				br_sla_period_uom, 
		br_sla_breach_date, 	br_accrual_jv_no, 				br_reversal_jv_no, 			br_remit_billing_status, 	br_remit_no, 
		br_remit_date, 			br_remit_status, 				br_accrual_jv_date, 		br_accrual_jv_amount, 		br_reversal_jv_date, 
		br_reversal_jv_amount, 	br_promo_dis_amount, 			br_promo_code, 				etlcreateddatetime
    )
    SELECT
        br_ouinstance, 			br_request_Id, 					br_customer_id, 			br_status, 					br_type, 
		br_customer_ref_no, 	br_receiver_ref_no, 			br_payment_ref_no, 			br_service_type, 			br_sub_service_type, 
		br_transport_mode, 		br_inco_terms, 					br_ref_doc_type1, 			br_ref_doc_type2, 			br_ref_doc_type3, 
		br_ref_doc_no1, 		br_ref_doc_no2, 				br_ref_doc_no3, 			br_quote_requested, 		br_requestor_name, 
		br_phone_no, 			br_email_id, 					br_comments, 				br_consigner_customer_same, br_quote_currency, 
		br_pref_cha_name, 		br_pref_cha_phone_no, 			br_pref_cha_email_id, 		br_timestamp, 				br_original_br_id, 
		br_unique_id, 			br_request_confirmation_date, 	br_validation_profile_id, 	br_contract_id, 			br_rate_id, 
		br_route_id, 			br_sales_account, 				br_revenue, 				br_error_code, 				br_priority, 
		br_recurring_flag, 		br_customer_location, 			br_payment_type, 			br_customer_primary_phone, 	br_customer_email_id, 
		br_consignor_id, 		br_consignor_primary_phone, 	br_consignor_email_id, 		br_sender_ref_no, 			br_create_as_template, 
		br_creation_date, 		br_created_by, 					br_last_modified_date, 		br_last_modified_by, 		br_fc_or_regular, 
		br_billing_status, 		br_requested_date, 				br_reason_code, 			br_remarks, 				br_contract_amend_no, 
		br_Hazardous, 			br_break_burst_parent, 			br_break_burst_type, 		br_order_type, 				br_inslia_redington, 
		br_shippers_inv_no, 	br_invoice_value, 				br_currency, 				br_cargo_desc, 				br_marks_and_numbers, 
		br_load_type, 			br_delivery_terms, 				brrd_shippers_invoice_date, br_operating_plan_ref, 		br_bill_to_id, 
		br_creation_source, 	br_creation_source_id, 			br_workflow_status, 		br_workflow_error, 			br_wf_guid, 
		br_previous_status, 	br_status_prior_Amend, 			br_clubbing_type, 			br_time_bound, 				br_source, 
		br_declared_value, 		br_Insurance_value, 			br_tariff_adv_YN, 			br_cod, 					br_cop, 
		br_shipping_fee, 		br_collection_mode, 			br_advance_tariff_YN, 		br_penalty_flag, 			br_include, 
		br_error_desc, 			br_Franchisee_bill_status, 		br_creationservice_name, 	br_sla_period, 				br_sla_period_uom, 
		br_sla_breach_date, 	br_accrual_jv_no, 				br_reversal_jv_no, 			br_remit_billing_status, 	br_remit_no, 
		br_remit_date, 			br_remit_status, 				br_accrual_jv_date, 		br_accrual_jv_amount, 		br_reversal_jv_date, 
		br_reversal_jv_amount, 	br_promo_dis_amount, 			br_promo_code, 				etlcreateddatetime
    FROM stg.stg_tms_br_booking_request_hdr;
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