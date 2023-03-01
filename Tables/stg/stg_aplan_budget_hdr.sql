-- Table: stg.stg_aplan_budget_hdr

-- DROP TABLE IF EXISTS stg.stg_aplan_budget_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_aplan_budget_hdr
(
    ou_id integer NOT NULL,
    financial_year character varying(60) COLLATE public.nocase NOT NULL,
    budget_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    budget_date timestamp without time zone,
    numbering_typeno character varying(40) COLLATE public.nocase,
    total_base_req_amount numeric,
    total_base_alloc_amount numeric,
    total_base_variance_amount numeric,
    budget_status character varying(100) COLLATE public.nocase,
    doc_type character varying(100) COLLATE public.nocase,
    utilized_amount numeric,
    total_proposed_amount numeric,
    amendment_number character varying(72) COLLATE public.nocase,
    total_alloc_amount numeric,
    total_utilized_amount numeric,
    total_base_bal_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT aplan_budget_hdr_pkey PRIMARY KEY (ou_id, financial_year, budget_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_aplan_budget_hdr
    OWNER to proconnect;
-- Index: stg_aplan_budget_hdr_key_idx

-- DROP INDEX IF EXISTS stg.stg_aplan_budget_hdr_key_idx;

CREATE INDEX IF NOT EXISTS stg_aplan_budget_hdr_key_idx
    ON stg.stg_aplan_budget_hdr USING btree
    (ou_id ASC NULLS LAST, financial_year COLLATE public.nocase ASC NULLS LAST, budget_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;