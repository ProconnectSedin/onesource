-- Table: dwh.f_ctrndebitnotedtl

-- DROP TABLE IF EXISTS dwh.f_ctrndebitnotedtl;

CREATE TABLE IF NOT EXISTS dwh.f_ctrndebitnotedtl
(
    ctrndebitnotedtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    customer_key bigint,
    currency_key bigint,
    account_code_key bigint,
    ou_id integer,
    tdn_no character varying(36) COLLATE public.nocase,
    "timestamp" integer,
    transfer_doc_no character varying(36) COLLATE public.nocase,
    tran_date timestamp without time zone,
    customer_code character varying(36) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    tran_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    exchange_rate numeric(25,2),
    transferee_amt numeric(25,2),
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
    CONSTRAINT f_ctrndebitnotedtl_pkey PRIMARY KEY (ctrndebitnotedtl_key),
    CONSTRAINT f_ctrndebitnotedtl_ukey UNIQUE (ou_id, tdn_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ctrndebitnotedtl
    OWNER to proconnect;
-- Index: f_ctrndebitnotedtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_ctrndebitnotedtl_key_idx;

CREATE INDEX IF NOT EXISTS f_ctrndebitnotedtl_key_idx
    ON dwh.f_ctrndebitnotedtl USING btree
    (ou_id ASC NULLS LAST, tdn_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_ctrndebitnotedtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ctrndebitnotedtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_ctrndebitnotedtl_key_idx1
    ON dwh.f_ctrndebitnotedtl USING btree
    (customer_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_ctrndebitnotedtl_key_idx2

-- DROP INDEX IF EXISTS dwh.f_ctrndebitnotedtl_key_idx2;

CREATE INDEX IF NOT EXISTS f_ctrndebitnotedtl_key_idx2
    ON dwh.f_ctrndebitnotedtl USING btree
    (currency_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_ctrndebitnotedtl_key_idx3

-- DROP INDEX IF EXISTS dwh.f_ctrndebitnotedtl_key_idx3;

CREATE INDEX IF NOT EXISTS f_ctrndebitnotedtl_key_idx3
    ON dwh.f_ctrndebitnotedtl USING btree
    (account_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;