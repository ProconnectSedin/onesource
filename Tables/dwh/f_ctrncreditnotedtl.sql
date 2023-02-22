-- Table: dwh.f_ctrncreditnotedtl

-- DROP TABLE IF EXISTS dwh.f_ctrncreditnotedtl;

CREATE TABLE IF NOT EXISTS dwh.f_ctrncreditnotedtl
(
    ctrncreditnotedtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    ctrncreditnotedtl_customer_key bigint NOT NULL,
    ctrncreditnotedtl_currency_key bigint NOT NULL,
    ou_id integer,
    tcn_no character varying(36) COLLATE public.nocase,
    "timestamp" integer,
    transfer_doc_no character varying(36) COLLATE public.nocase,
    tran_date timestamp without time zone,
    customer_code character varying(36) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    tran_amount numeric(20,2),
    exchange_rate numeric(20,2),
    par_exchange_rate numeric(20,2),
    transferee_amt numeric(20,2),
    reason_code character varying(20) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    account_type character varying(30) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_doc_no character varying(36) COLLATE public.nocase,
    rev_doc_date timestamp without time zone,
    rev_reasoncode character varying(20) COLLATE public.nocase,
    rev_doc_trantype character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ctrncreditnotedtl_pkey PRIMARY KEY (ctrncreditnotedtl_key),
    CONSTRAINT f_ctrncreditnotedtl_ukey UNIQUE (ou_id, tcn_no),
    CONSTRAINT f_ctrncreditnotedtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ctrncreditnotedtl_ctrncreditnotedtl_currency_key_fkey FOREIGN KEY (ctrncreditnotedtl_currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ctrncreditnotedtl_ctrncreditnotedtl_customer_key_fkey FOREIGN KEY (ctrncreditnotedtl_customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ctrncreditnotedtl
    OWNER to proconnect;
-- Index: f_ctrncreditnotedtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ctrncreditnotedtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_ctrncreditnotedtl_key_idx1
    ON dwh.f_ctrncreditnotedtl USING btree
    (ou_id ASC NULLS LAST, tcn_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;