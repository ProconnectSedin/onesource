CREATE TABLE click.d_bankcashaccountmaster (
    d_bank_mst_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    bank_ptt_code character varying(80) COLLATE public.nocase,
    effective_from timestamp without time zone,
    sequence_no integer,
    "timestamp" integer,
    bankptt_account character varying(80) COLLATE public.nocase,
    bankcharge_account character varying(80) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
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

ALTER TABLE ONLY click.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_pkey PRIMARY KEY (d_bank_mst_key);

ALTER TABLE ONLY click.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_ukey UNIQUE (company_code, fb_id, bank_ptt_code, effective_from, sequence_no);