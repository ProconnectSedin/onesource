CREATE TABLE click.d_operationalaccountdetail (
    opcoa_key bigint NOT NULL,
    opcoa_id character varying(20) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    account_desc character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    account_group character varying(40) COLLATE public.nocase,
    account_class character varying(40) COLLATE public.nocase,
    ctrl_acctype character varying(80) COLLATE public.nocase,
    autopost_acctype character varying(80) COLLATE public.nocase,
    effective_from timestamp without time zone,
    layout_code character varying(80) COLLATE public.nocase,
    account_status character varying(10) COLLATE public.nocase,
    active_to timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    createdlangid integer,
    schedule_code character varying(120) COLLATE public.nocase,
    status character varying(10) COLLATE public.nocase,
    revised_schedule_code character varying(120) COLLATE public.nocase,
    revised_layout_code character varying(80) COLLATE public.nocase,
    revised_neg_layout_code character varying(50) COLLATE public.nocase,
    workflow_status character varying(50) COLLATE public.nocase,
    wf_flag character varying(30) COLLATE public.nocase,
    revised_asindas_layout_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_pkey PRIMARY KEY (opcoa_key);

ALTER TABLE ONLY click.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_ukey UNIQUE (opcoa_id, account_code);