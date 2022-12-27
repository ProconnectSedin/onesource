CREATE TABLE raw.raw_tms_tleh_trip_log_expence_hdr (
    raw_id bigint NOT NULL,
    tleh_ouinstance integer NOT NULL,
    tleh_report_no character varying(80) NOT NULL COLLATE public.nocase,
    tleh_report_creation_date character varying(100) COLLATE public.nocase,
    tleh_trip_id character varying(80) NOT NULL COLLATE public.nocase,
    tleh_expense_for character varying(80) COLLATE public.nocase,
    tleh_trip_leg_no character varying(160) COLLATE public.nocase,
    tleh_resource_id character varying(160) COLLATE public.nocase,
    tleh_resource_name character varying(160) COLLATE public.nocase,
    tleh_advance_amount numeric,
    tleh_expense_amount numeric,
    tleh_report_status character varying(160) COLLATE public.nocase,
    tleh_guid character varying(512) NOT NULL COLLATE public.nocase,
    tleh_workflow_status character varying(160) COLLATE public.nocase,
    tleh_reject_reason character varying(160) COLLATE public.nocase,
    tleh_reject_reason_desc character varying(160) COLLATE public.nocase,
    tleh_cancel_reason character varying(160) COLLATE public.nocase,
    tleh_remarks character varying(160) COLLATE public.nocase,
    tleh_creation_date character varying(100) COLLATE public.nocase,
    tleh_created_by character varying(120) COLLATE public.nocase,
    tleh_last_modified_date character varying(100) COLLATE public.nocase,
    tleh_last_modified_by character varying(120) COLLATE public.nocase,
    tleh_timestamp integer,
    tleh_draft_bill_status character varying(160) COLLATE public.nocase,
    tleh_resource_type character varying(160) COLLATE public.nocase,
    tleh_refdoc_type character varying(160) COLLATE public.nocase,
    tleh_refdoc_no character varying(160) COLLATE public.nocase,
    tleh_agency_id character varying(72) COLLATE public.nocase,
    tleh_agency_name character varying(1020) COLLATE public.nocase,
    tleh_requester_id character varying(72) COLLATE public.nocase,
    tleh_requester_name character varying(1020) COLLATE public.nocase,
    tleh_estimated_setlmnt_date timestamp without time zone,
    tleh_amendment_no integer,
    tleh_amend_reason character varying(1020) COLLATE public.nocase,
    tleh_amend_reason_desc character varying(1020) COLLATE public.nocase,
    tleh_rpt_mob_ref_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tleh_trip_log_expence_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tleh_trip_log_expence_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tleh_trip_log_expence_hdr
    ADD CONSTRAINT raw_tms_tleh_trip_log_expence_hdr_pkey PRIMARY KEY (raw_id);