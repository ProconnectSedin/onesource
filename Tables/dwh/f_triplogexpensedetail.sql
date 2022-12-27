CREATE TABLE dwh.f_triplogexpensedetail (
    tled_key bigint NOT NULL,
    tled_ouinstance integer,
    tled_trip_plan_id character varying(40) COLLATE public.nocase,
    tled_trip_plan_line_id character varying(300) COLLATE public.nocase,
    tled_expense_record character varying(40) COLLATE public.nocase,
    tled_expense_type character varying(80) COLLATE public.nocase,
    tled_bill_no character varying(80) COLLATE public.nocase,
    tled_bill_date character varying(50) COLLATE public.nocase,
    tled_bill_amount numeric(13,2),
    tled_claimed_amount numeric(13,2),
    tled_approved_amount numeric(13,2),
    tled_currency character varying(10) COLLATE public.nocase,
    tled_remarks character varying(200) COLLATE public.nocase,
    tled_created_date character varying(50) COLLATE public.nocase,
    tled_created_by character varying(60) COLLATE public.nocase,
    tled_modified_date character varying(50) COLLATE public.nocase,
    tled_modified_by character varying(60) COLLATE public.nocase,
    tled_timestamp integer,
    tled_status character varying(50) COLLATE public.nocase,
    tled_leq_no character varying(80) COLLATE public.nocase,
    tled_previous_status character varying(50) COLLATE public.nocase,
    tled_workflow_status character varying(510) COLLATE public.nocase,
    tled_workflow_error character varying(510) COLLATE public.nocase,
    tled_wf_guid character varying(300) COLLATE public.nocase,
    tms_tled_hdr_guid character varying(300) COLLATE public.nocase,
    tms_tled_guid character varying(300) COLLATE public.nocase,
    tms_tled_exp_requset_no character varying(40) COLLATE public.nocase,
    tms_tled_exp_resource_id character varying(40) COLLATE public.nocase,
    tms_tled_adv_amount numeric(13,2),
    tms_tled_adv_amt_ref character varying(40) COLLATE public.nocase,
    tled_bill_base_amount numeric(13,2),
    tled_claimed_base_amount numeric(13,2),
    tled_approved_base_amount numeric(13,2),
    tms_tled_adv_base_amount numeric(13,2),
    tleh_draft_bill_line_status character varying(80) COLLATE public.nocase,
    tled_via_point character varying(80) COLLATE public.nocase,
    tled_resource_reimbursement character varying(80) COLLATE public.nocase,
    tled_customer_reimbursement character varying(80) COLLATE public.nocase,
    tled_transaction_date timestamp without time zone,
    tled_refdoc_type character varying(80) COLLATE public.nocase,
    tled_refdoc_no character varying(80) COLLATE public.nocase,
    tled_tariff_id character varying(40) COLLATE public.nocase,
    tled_amendment_no integer,
    tled_rejection_remarks character varying(80) COLLATE public.nocase,
    tled_attachment character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogexpensedetail ALTER COLUMN tled_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogexpensedetail_tled_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogexpensedetail
    ADD CONSTRAINT f_triplogexpensedetail_pkey PRIMARY KEY (tled_key);

CREATE INDEX f_triplogexpensedetail_key_idx ON dwh.f_triplogexpensedetail USING btree (tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_id);