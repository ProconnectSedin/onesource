-- Table: dwh.f_rpvoucherdtl

-- DROP TABLE IF EXISTS dwh.f_rpvoucherdtl;

CREATE TABLE IF NOT EXISTS dwh.f_rpvoucherdtl
(
    rpvoucherdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bankcash_key bigint,
    currency_key bigint,
    bankcode_key bigint,
    companycode_key bigint,
    ou_id integer,
    serial_no integer,
    doc_type character varying(24) COLLATE public.nocase,
    tran_ou integer,
    voucher_no character varying(36) COLLATE public.nocase,
    payment_category character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    checkseries_no character varying(64) COLLATE public.nocase,
    check_no character varying(60) COLLATE public.nocase,
    comp_reference character varying(80) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    payee_name character varying(240) COLLATE public.nocase,
    voucher_date timestamp without time zone,
    voucher_amount numeric(25,2),
    fb_id character varying(40) COLLATE public.nocase,
    bank_code character varying(64) COLLATE public.nocase,
    flag character varying(8) COLLATE public.nocase,
    pay_date timestamp without time zone,
    priority character varying(8) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    voucher_status character varying(8) COLLATE public.nocase,
    void_tran_no character varying(36) COLLATE public.nocase,
    nolinesinstub integer,
    stubpropt character varying(8) COLLATE public.nocase,
    void_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    pay_charges numeric(25,2),
    company_code character varying(20) COLLATE public.nocase,
    bank_acc_no character varying(40) COLLATE public.nocase,
    pdc_void_flag character varying(24) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    paycharges_bnkcur numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_rpvoucherdtl_pkey PRIMARY KEY (rpvoucherdtl_key),
    CONSTRAINT f_rpvoucherdtl_ukey UNIQUE (ou_id, serial_no, doc_type, tran_ou, voucher_no, payment_category)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_rpvoucherdtl
    OWNER to proconnect;
-- Index: f_rpvoucherdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_rpvoucherdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_rpvoucherdtl_key_idx
    ON dwh.f_rpvoucherdtl USING btree
    (ou_id ASC NULLS LAST, serial_no ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, voucher_no COLLATE public.nocase ASC NULLS LAST, payment_category COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;