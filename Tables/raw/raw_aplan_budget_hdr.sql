-- Table: raw.raw_aplan_budget_hdr

-- DROP TABLE IF EXISTS "raw".raw_aplan_budget_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_aplan_budget_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT aplan_budget_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_aplan_budget_hdr
    OWNER to proconnect;