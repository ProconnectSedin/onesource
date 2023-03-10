CREATE TABLE raw.raw_tms_tled_trip_log_expense_details (
    raw_id bigint NOT NULL,
    tled_ouinstance integer NOT NULL,
    tled_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tled_trip_plan_line_id character varying(512) NOT NULL COLLATE public.nocase,
    tled_expense_record character varying(72) COLLATE public.nocase,
    tled_expense_type character varying(160) COLLATE public.nocase,
    tled_bill_no character varying(160) COLLATE public.nocase,
    tled_bill_date character varying(100) COLLATE public.nocase,
    tled_bill_amount numeric,
    tled_claimed_amount numeric,
    tled_approved_amount numeric,
    tled_currency character(20) COLLATE public.nocase,
    tled_remarks character varying(400) COLLATE public.nocase,
    tled_created_date character varying(100) COLLATE public.nocase,
    tled_created_by character varying(120) COLLATE public.nocase,
    tled_modified_date character varying(100) COLLATE public.nocase,
    tled_modified_by character varying(120) COLLATE public.nocase,
    tled_timestamp integer,
    tled_status character varying(100) COLLATE public.nocase,
    tled_leq_no character varying(160) COLLATE public.nocase,
    tled_previous_status character varying(100) COLLATE public.nocase,
    tled_workflow_status character varying(1020) COLLATE public.nocase,
    tled_workflow_error character varying(1020) COLLATE public.nocase,
    tled_wf_guid character varying(512) COLLATE public.nocase,
    tms_tled_hdr_guid character varying(512) COLLATE public.nocase,
    tms_tled_guid character varying(512) COLLATE public.nocase,
    tms_tled_exp_requset_no character varying(72) COLLATE public.nocase,
    tms_tled_exp_resource_id character varying(72) COLLATE public.nocase,
    tms_tled_adv_amount numeric,
    tms_tled_adv_amt_ref character varying(72) COLLATE public.nocase,
    tled_bill_base_amount numeric,
    tled_claimed_base_amount numeric,
    tled_approved_base_amount numeric,
    tms_tled_adv_base_amount numeric,
    tleh_draft_bill_line_status character varying(160) COLLATE public.nocase,
    tled_via_point character varying(160) COLLATE public.nocase,
    tled_resource_reimbursement character varying(160) COLLATE public.nocase,
    tled_customer_reimbursement character varying(160) COLLATE public.nocase,
    tled_transaction_date timestamp without time zone,
    tled_refdoc_type character varying(160) COLLATE public.nocase,
    tled_refdoc_no character varying(160) COLLATE public.nocase,
    tled_tariff_id character varying(72) COLLATE public.nocase,
    tled_amendment_no integer,
    tled_rejection_remarks character varying(160) COLLATE public.nocase,
    tled_attachment character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tled_trip_log_expense_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tled_trip_log_expense_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tled_trip_log_expense_details
    ADD CONSTRAINT raw_tms_tled_trip_log_expense_details_pkey PRIMARY KEY (raw_id);