-- Table: raw.raw_si_supplier_balance

-- DROP TABLE IF EXISTS "raw".raw_si_supplier_balance;

CREATE TABLE IF NOT EXISTS "raw".raw_si_supplier_balance
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT si_supplier_balance_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_si_supplier_balance
    OWNER to proconnect;