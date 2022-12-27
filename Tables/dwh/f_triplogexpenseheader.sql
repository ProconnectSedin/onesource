CREATE TABLE dwh.f_triplogexpenseheader (
    tleh_key bigint NOT NULL,
    tleh_ouinstance integer,
    tleh_report_no character varying(40) COLLATE public.nocase,
    tleh_report_creation_date character varying(50) COLLATE public.nocase,
    tleh_trip_id character varying(40) COLLATE public.nocase,
    tleh_expense_for character varying(40) COLLATE public.nocase,
    tleh_trip_leg_no character varying(80) COLLATE public.nocase,
    tleh_resource_id character varying(80) COLLATE public.nocase,
    tleh_resource_name character varying(80) COLLATE public.nocase,
    tleh_advance_amount numeric(13,0),
    tleh_expense_amount numeric(13,0),
    tleh_report_status character varying(80) COLLATE public.nocase,
    tleh_guid character varying(300) COLLATE public.nocase,
    tleh_workflow_status character varying(80) COLLATE public.nocase,
    tleh_reject_reason character varying(80) COLLATE public.nocase,
    tleh_reject_reason_desc character varying(80) COLLATE public.nocase,
    tleh_cancel_reason character varying(80) COLLATE public.nocase,
    tleh_remarks character varying(80) COLLATE public.nocase,
    tleh_creation_date character varying(50) COLLATE public.nocase,
    tleh_created_by character varying(60) COLLATE public.nocase,
    tleh_last_modified_date character varying(50) COLLATE public.nocase,
    tleh_last_modified_by character varying(60) COLLATE public.nocase,
    tleh_timestamp integer,
    tleh_draft_bill_status character varying(80) COLLATE public.nocase,
    tleh_resource_type character varying(80) COLLATE public.nocase,
    tleh_refdoc_type character varying(80) COLLATE public.nocase,
    tleh_refdoc_no character varying(80) COLLATE public.nocase,
    tleh_agency_id character varying(40) COLLATE public.nocase,
    tleh_agency_name character varying(510) COLLATE public.nocase,
    tleh_requester_id character varying(40) COLLATE public.nocase,
    tleh_requester_name character varying(510) COLLATE public.nocase,
    tleh_estimated_setlmnt_date timestamp without time zone,
    tleh_amendment_no integer,
    tleh_amend_reason character varying(510) COLLATE public.nocase,
    tleh_amend_reason_desc character varying(510) COLLATE public.nocase,
    tleh_rpt_mob_ref_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogexpenseheader ALTER COLUMN tleh_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogexpenseheader_tleh_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogexpenseheader
    ADD CONSTRAINT f_triplogexpenseheader_pkey PRIMARY KEY (tleh_key);

ALTER TABLE ONLY dwh.f_triplogexpenseheader
    ADD CONSTRAINT f_triplogexpenseheader_ukey UNIQUE (tleh_ouinstance, tleh_report_no, tleh_trip_id, tleh_report_creation_date);

CREATE INDEX f_triplogexpenseheader_key_idx ON dwh.f_triplogexpenseheader USING btree (tleh_ouinstance, tleh_report_no, tleh_trip_id, tleh_report_creation_date);