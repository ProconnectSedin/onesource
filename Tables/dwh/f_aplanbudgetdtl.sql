-- Table: dwh.f_aplanbudgetdtl

-- DROP TABLE IF EXISTS dwh.f_aplanbudgetdtl;

CREATE TABLE IF NOT EXISTS dwh.f_aplanbudgetdtl
(
    aplan_budget_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    financial_year character varying(30) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    budget_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    amount_required numeric(25,2),
    exchange_rate numeric(25,2),
    base_amount numeric(25,2),
    allocated_amount numeric(25,2),
    allow_variance character varying(40) COLLATE public.nocase,
    variance_per integer,
    variance_amount numeric(25,2),
    base_alloc_amount numeric(25,2),
    base_variance_amount numeric(25,2),
    remarks character varying(510) COLLATE public.nocase,
    utilized_amount numeric(25,2),
    base_utilized_amount numeric(25,2),
    balance_amount numeric(25,2),
    base_balance_amount numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_aplanbudgetdtl_pkey PRIMARY KEY (aplan_budget_dtl_key),
    CONSTRAINT f_aplanbudgetdtl_ukey UNIQUE (ou_id, fb_id, asset_class_code, financial_year, currency_code, budget_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_aplanbudgetdtl
    OWNER to proconnect;