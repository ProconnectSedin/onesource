CREATE TABLE dwh.f_tenderrequirementheader (
    trh_hdr_key bigint NOT NULL,
    trh_date_key bigint NOT NULL,
    trh_ouinstance integer,
    trh_tender_req_no character varying(40) COLLATE public.nocase,
    trh_numtype character varying(40) COLLATE public.nocase,
    trh_tender_req_status character varying(80) COLLATE public.nocase,
    trh_tender_req_date timestamp without time zone,
    trh_req_type character varying(80) COLLATE public.nocase,
    trh_req_id character varying(60) COLLATE public.nocase,
    trh_resp_time_limit integer,
    trh_resp_time_limit_uom character varying(80) COLLATE public.nocase,
    trh_tender_inst character varying(1000) COLLATE public.nocase,
    trh_transport_mode character varying(80) COLLATE public.nocase,
    trh_created_by character varying(60) COLLATE public.nocase,
    trh_created_date timestamp without time zone,
    trh_last_modified_by character varying(60) COLLATE public.nocase,
    trh_lst_modified_date timestamp without time zone,
    trh_timestamp integer,
    trh_tender_confirm_status character varying(80) COLLATE public.nocase,
    trh_resp_before timestamp without time zone,
    trh_tender_req_status_old character varying(80) COLLATE public.nocase,
    trh_tender_req_prevstatus character varying(50) COLLATE public.nocase,
    trh_workflow_status character varying(50) COLLATE public.nocase,
    trh_workflow_error character varying(40) COLLATE public.nocase,
    trh_wf_guid character varying(300) COLLATE public.nocase,
    trh_multi_del_ins_flag character varying(20) COLLATE public.nocase,
    trh_multi_del_ins character varying(510) COLLATE public.nocase,
    trh_request_cost_currency character varying(80) COLLATE public.nocase,
    trh_requested_ext_cost numeric(20,2),
    trh_reason_rejection_mtr character varying(1000) COLLATE public.nocase,
    trh_workflow_status_mtr character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tenderrequirementheader ALTER COLUMN trh_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tenderrequirementheader_trh_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_pkey PRIMARY KEY (trh_hdr_key);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_ukey UNIQUE (trh_ouinstance, trh_tender_req_no);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_trh_date_key_fkey FOREIGN KEY (trh_date_key) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_tenderrequirementheader_key_idx ON dwh.f_tenderrequirementheader USING btree (trh_date_key);