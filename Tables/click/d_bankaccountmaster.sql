CREATE TABLE click.d_bankaccountmaster (
    bank_acc_mst_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    bank_ref_no character varying(60) COLLATE public.nocase,
    bank_acc_no character varying(60) COLLATE public.nocase,
    serial_no integer,
    btimestamp integer,
    flag character varying(10) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    credit_limit numeric(13,2),
    draw_limit numeric(13,2),
    status character varying(60) COLLATE public.nocase,
    effective_from timestamp without time zone,
    creation_ou integer,
    createdby character varying(100) COLLATE public.nocase,
    createddate timestamp without time zone,
    acctrf character varying(10) COLLATE public.nocase,
    neft character varying(10) COLLATE public.nocase,
    rtgs character varying(10) COLLATE public.nocase,
    restpostingaftrrecon character varying(60) COLLATE public.nocase,
    echeq character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_pkey PRIMARY KEY (bank_acc_mst_key);

ALTER TABLE ONLY click.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_ukey UNIQUE (company_code, bank_ref_no, bank_acc_no, serial_no);