CREATE TABLE click.d_accountadditionalmaster (
    acc_mst_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    effective_from timestamp without time zone,
    currency_code character varying(10) COLLATE public.nocase,
    drcr_flag character varying(10) COLLATE public.nocase,
    dest_fbid character varying(40) COLLATE public.nocase,
    child_company character varying(20) COLLATE public.nocase,
    dest_company character varying(20) COLLATE public.nocase,
    sequence_no integer,
    "timestamp" integer,
    account_code character varying(80) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    usage_type character varying(10) COLLATE public.nocase,
    ard_type character varying(40) COLLATE public.nocase,
    flag character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_pkey PRIMARY KEY (acc_mst_key);

ALTER TABLE ONLY click.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_ukey UNIQUE (company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no);