-- Table: dwh.f_rpcheckseriesdtl

-- DROP TABLE IF EXISTS dwh.f_rpcheckseriesdtl;

CREATE TABLE IF NOT EXISTS dwh.f_rpcheckseriesdtl
(
    rpcheckseriesdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bankaccount_key bigint,
    companycode_key bigint,
    ou_id integer,
    bank_code character varying(64) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    checkseries_no character varying(64) COLLATE public.nocase,
    check_no character varying(60) COLLATE public.nocase,
    "timestamp" integer,
    sequence_no integer,
    check_date timestamp without time zone,
    check_amount numeric(25,2),
    reason_code character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    pay_charges numeric(25,2),
    checkno_status character varying(8) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    bank_acc_no character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_rpcheckseriesdtl_pkey PRIMARY KEY (rpcheckseriesdtl_key),
    CONSTRAINT f_rpcheckseriesdtl_ukey UNIQUE (ou_id, bank_code, checkseries_no, check_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_rpcheckseriesdtl
    OWNER to proconnect;
-- Index: f_rpcheckseriesdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_rpcheckseriesdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_rpcheckseriesdtl_key_idx
    ON dwh.f_rpcheckseriesdtl USING btree
    (ou_id ASC NULLS LAST, bank_code COLLATE public.nocase ASC NULLS LAST, checkseries_no COLLATE public.nocase ASC NULLS LAST, check_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;