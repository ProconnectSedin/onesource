CREATE TABLE raw.raw_tms_br_booking_request_hdr (
    raw_id bigint NOT NULL,
    br_ouinstance bigint,
    br_request_id text COLLATE public.nocase,
    br_customer_id text COLLATE public.nocase,
    br_status text COLLATE public.nocase,
    br_type text COLLATE public.nocase,
    br_customer_ref_no text COLLATE public.nocase,
    br_receiver_ref_no text COLLATE public.nocase,
    br_payment_ref_no text COLLATE public.nocase,
    br_service_type text COLLATE public.nocase,
    br_sub_service_type text COLLATE public.nocase,
    br_transport_mode text COLLATE public.nocase,
    br_inco_terms text COLLATE public.nocase,
    br_ref_doc_type1 text COLLATE public.nocase,
    br_ref_doc_type2 text COLLATE public.nocase,
    br_ref_doc_type3 text COLLATE public.nocase,
    br_ref_doc_no1 text COLLATE public.nocase,
    br_ref_doc_no2 text COLLATE public.nocase,
    br_ref_doc_no3 text COLLATE public.nocase,
    br_quote_requested text COLLATE public.nocase,
    br_requestor_name text COLLATE public.nocase,
    br_phone_no text COLLATE public.nocase,
    br_email_id text COLLATE public.nocase,
    br_comments text COLLATE public.nocase,
    br_consigner_customer_same text COLLATE public.nocase,
    br_quote_currency text COLLATE public.nocase,
    br_pref_cha_name text COLLATE public.nocase,
    br_pref_cha_phone_no text COLLATE public.nocase,
    br_pref_cha_email_id text COLLATE public.nocase,
    br_timestamp double precision,
    br_original_br_id text COLLATE public.nocase,
    br_unique_id text COLLATE public.nocase,
    br_request_confirmation_date timestamp without time zone,
    br_validation_profile_id text COLLATE public.nocase,
    br_contract_id text COLLATE public.nocase,
    br_rate_id text COLLATE public.nocase,
    br_route_id text COLLATE public.nocase,
    br_sales_account text COLLATE public.nocase,
    br_revenue double precision,
    br_error_code text COLLATE public.nocase,
    br_priority text COLLATE public.nocase,
    br_recurring_flag text COLLATE public.nocase,
    br_customer_location text COLLATE public.nocase,
    br_payment_type text COLLATE public.nocase,
    br_customer_primary_phone text COLLATE public.nocase,
    br_customer_email_id text COLLATE public.nocase,
    br_consignor_id text COLLATE public.nocase,
    br_consignor_primary_phone text COLLATE public.nocase,
    br_consignor_email_id text COLLATE public.nocase,
    br_sender_ref_no text COLLATE public.nocase,
    br_create_as_template text COLLATE public.nocase,
    br_creation_date timestamp without time zone,
    br_created_by text COLLATE public.nocase,
    br_last_modified_date timestamp without time zone,
    br_last_modified_by text COLLATE public.nocase,
    br_fc_or_regular text COLLATE public.nocase,
    br_billing_status text COLLATE public.nocase,
    br_requested_date timestamp without time zone,
    br_reason_code text COLLATE public.nocase,
    br_remarks text COLLATE public.nocase,
    br_contract_amend_no double precision,
    br_hazardous text COLLATE public.nocase,
    br_break_burst_parent text COLLATE public.nocase,
    br_break_burst_type text COLLATE public.nocase,
    br_order_type text COLLATE public.nocase,
    br_inslia_redington text COLLATE public.nocase,
    br_shippers_inv_no text COLLATE public.nocase,
    br_invoice_value double precision,
    br_currency text COLLATE public.nocase,
    br_cargo_desc text COLLATE public.nocase,
    br_marks_and_numbers text COLLATE public.nocase,
    br_load_type text COLLATE public.nocase,
    br_delivery_terms text COLLATE public.nocase,
    brrd_shippers_invoice_date timestamp without time zone,
    br_operating_plan_ref text COLLATE public.nocase,
    br_bill_to_id text COLLATE public.nocase,
    br_creation_source text COLLATE public.nocase,
    br_creation_source_id text COLLATE public.nocase,
    br_workflow_status text COLLATE public.nocase,
    br_workflow_error text COLLATE public.nocase,
    br_wf_guid text COLLATE public.nocase,
    br_previous_status text COLLATE public.nocase,
    br_status_prior_amend text COLLATE public.nocase,
    br_clubbing_type text COLLATE public.nocase,
    br_time_bound text COLLATE public.nocase,
    br_source text COLLATE public.nocase,
    br_declared_value double precision,
    br_insurance_value double precision,
    br_tariff_adv_yn text COLLATE public.nocase,
    br_cod text COLLATE public.nocase,
    br_cop text COLLATE public.nocase,
    br_shipping_fee text COLLATE public.nocase,
    br_collection_mode text COLLATE public.nocase,
    br_advance_tariff_yn text COLLATE public.nocase,
    br_penalty_flag text COLLATE public.nocase,
    br_include text COLLATE public.nocase,
    br_error_desc text COLLATE public.nocase,
    br_franchisee_bill_status text COLLATE public.nocase,
    br_creationservice_name text COLLATE public.nocase,
    br_sla_period text COLLATE public.nocase,
    br_sla_period_uom text COLLATE public.nocase,
    br_sla_breach_date text COLLATE public.nocase,
    br_accrual_jv_no text COLLATE public.nocase,
    br_reversal_jv_no text COLLATE public.nocase,
    br_remit_billing_status text COLLATE public.nocase,
    br_remit_no text COLLATE public.nocase,
    br_remit_date text COLLATE public.nocase,
    br_remit_status text COLLATE public.nocase,
    br_accrual_jv_date text COLLATE public.nocase,
    br_accrual_jv_amount text COLLATE public.nocase,
    br_reversal_jv_date timestamp without time zone,
    br_reversal_jv_amount text COLLATE public.nocase,
    br_promo_dis_amount text COLLATE public.nocase,
    br_promo_code text COLLATE public.nocase,
    etlcreateddatetime timestamp without time zone
);