-- Table: raw.raw_aplan_budget_dtl

-- DROP TABLE IF EXISTS "raw".raw_aplan_budget_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_aplan_budget_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    asset_class_code character varying(80) COLLATE public.nocase NOT NULL,
    financial_year character varying(60) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    budget_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    amount_required numeric,
    exchange_rate numeric,
    base_amount numeric,
    allocated_amount numeric,
    allow_variance character varying(80) COLLATE public.nocase,
    variance_per integer,
    variance_amount numeric,
    base_alloc_amount numeric,
    base_variance_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    utilized_amount numeric,
    base_utilized_amount numeric,
    balance_amount numeric,
    base_balance_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_aplan_budget_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_aplan_budget_dtl
    OWNER to proconnect;