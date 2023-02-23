-- Table: stg.stg_ci_cust_balance

-- DROP TABLE IF EXISTS stg.stg_ci_cust_balance;

CREATE TABLE IF NOT EXISTS stg.stg_ci_cust_balance
(
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    fin_period character varying(60) COLLATE public.nocase NOT NULL,
    cust_code character varying(72) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    balance_type character varying(20) COLLATE public.nocase NOT NULL,
    balance_currency character varying(20) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    ob_credit numeric,
    ob_debit numeric,
    period_credit numeric,
    period_debit numeric,
    cb_credit numeric,
    cb_debit numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    batch_id character varying(512) COLLATE public.nocase,
    account_type character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_cust_balance_pkey PRIMARY KEY (ou_id, company_code, fb_id, fin_year, fin_period, cust_code, account_code, currency_code, balance_type, balance_currency)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_cust_balance
    OWNER to proconnect;
-- Index: stg_ci_cust_balance_idx

-- DROP INDEX IF EXISTS stg.stg_ci_cust_balance_idx;

CREATE INDEX IF NOT EXISTS stg_ci_cust_balance_idx
    ON stg.stg_ci_cust_balance USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, cust_code COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, balance_type COLLATE public.nocase ASC NULLS LAST, balance_currency COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;