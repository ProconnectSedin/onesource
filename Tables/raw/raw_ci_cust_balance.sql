-- Table: raw.raw_ci_cust_balance

-- DROP TABLE IF EXISTS "raw".raw_ci_cust_balance;

CREATE TABLE IF NOT EXISTS "raw".raw_ci_cust_balance
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_ci_cust_balance_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ci_cust_balance
    OWNER to proconnect;