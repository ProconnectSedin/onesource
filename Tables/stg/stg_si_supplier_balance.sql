-- Table: stg.stg_si_supplier_balance

-- DROP TABLE IF EXISTS stg.stg_si_supplier_balance;

CREATE TABLE IF NOT EXISTS stg.stg_si_supplier_balance
(
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    fin_period character varying(60) COLLATE public.nocase NOT NULL,
    supplier_code character varying(64) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    balance_type character varying(20) COLLATE public.nocase NOT NULL,
    balance_currency character varying(20) COLLATE public.nocase NOT NULL,
    account_type character varying(40) COLLATE public.nocase,
    ob_credit numeric,
    ob_debit numeric,
    period_credit numeric,
    period_debit numeric,
    cb_credit numeric,
    cb_debit numeric,
    created_by character varying(120) COLLATE public.nocase,
    created_date timestamp without time zone,
    last_modified_by character varying(120) COLLATE public.nocase,
    last_modified_date timestamp without time zone,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT si_supplier_balance_pkey UNIQUE (ou_id, company_code, fb_id, fin_year, fin_period, supplier_code, account_code, currency_code, balance_type, balance_currency)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_si_supplier_balance
    OWNER to proconnect;
-- Index: stg_si_supplier_balance_key_idx2

-- DROP INDEX IF EXISTS stg.stg_si_supplier_balance_key_idx2;

CREATE INDEX IF NOT EXISTS stg_si_supplier_balance_key_idx2
    ON stg.stg_si_supplier_balance USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, supplier_code COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, balance_type COLLATE public.nocase ASC NULLS LAST, balance_currency COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;