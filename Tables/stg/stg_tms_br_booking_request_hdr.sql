CREATE TABLE stg.stg_tms_br_booking_request_hdr (
    br_ouinstance bigint,
    br_request_id text,
    br_customer_id text,
    br_status text,
    br_type text,
    br_customer_ref_no text,
    br_receiver_ref_no text,
    br_payment_ref_no text,
    br_service_type text,
    br_sub_service_type text,
    br_transport_mode text,
    br_inco_terms text,
    br_ref_doc_type1 text,
    br_ref_doc_type2 text,
    br_ref_doc_type3 text,
    br_ref_doc_no1 text,
    br_ref_doc_no2 text,
    br_ref_doc_no3 text,
    br_quote_requested text,
    br_requestor_name text,
    br_phone_no text,
    br_email_id text,
    br_comments text,
    br_consigner_customer_same text,
    br_quote_currency text,
    br_pref_cha_name text,
    br_pref_cha_phone_no text,
    br_pref_cha_email_id text,
    br_timestamp double precision,
    br_original_br_id text,
    br_unique_id text,
    br_request_confirmation_date timestamp without time zone,
    br_validation_profile_id text,
    br_contract_id text,
    br_rate_id text,
    br_route_id text,
    br_sales_account text,
    br_revenue double precision,
    br_error_code text,
    br_priority text,
    br_recurring_flag text,
    br_customer_location text,
    br_payment_type text,
    br_customer_primary_phone text,
    br_customer_email_id text,
    br_consignor_id text,
    br_consignor_primary_phone text,
    br_consignor_email_id text,
    br_sender_ref_no text,
    br_create_as_template text,
    br_creation_date timestamp without time zone,
    br_created_by text,
    br_last_modified_date timestamp without time zone,
    br_last_modified_by text,
    br_fc_or_regular text,
    br_billing_status text,
    br_requested_date timestamp without time zone,
    br_reason_code text,
    br_remarks text,
    br_contract_amend_no double precision,
    br_hazardous text,
    br_break_burst_parent text,
    br_break_burst_type text,
    br_order_type text,
    br_inslia_redington text,
    br_shippers_inv_no text,
    br_invoice_value double precision,
    br_currency text,
    br_cargo_desc text,
    br_marks_and_numbers text,
    br_load_type text,
    br_delivery_terms text,
    brrd_shippers_invoice_date timestamp without time zone,
    br_operating_plan_ref text,
    br_bill_to_id text,
    br_creation_source text,
    br_creation_source_id text,
    br_workflow_status text,
    br_workflow_error text,
    br_wf_guid text,
    br_previous_status text,
    br_status_prior_amend text,
    br_clubbing_type text,
    br_time_bound text,
    br_source text,
    br_declared_value double precision,
    br_insurance_value double precision,
    br_tariff_adv_yn text,
    br_cod text,
    br_cop text,
    br_shipping_fee text,
    br_collection_mode text,
    br_advance_tariff_yn text,
    br_penalty_flag text,
    br_include text,
    br_error_desc text,
    br_franchisee_bill_status text,
    br_creationservice_name text,
    br_sla_period text,
    br_sla_period_uom text,
    br_sla_breach_date text,
    br_accrual_jv_no text,
    br_reversal_jv_no text,
    br_remit_billing_status text,
    br_remit_no text,
    br_remit_date text,
    br_remit_status text,
    br_accrual_jv_date text,
    br_accrual_jv_amount text,
    br_reversal_jv_date timestamp without time zone,
    br_reversal_jv_amount text,
    br_promo_dis_amount text,
    br_promo_code text,
    etlcreateddatetime timestamp without time zone
);