-- Table: dwh.d_aplanbudgethdr

-- DROP TABLE IF EXISTS dwh.d_aplanbudgethdr;

CREATE TABLE IF NOT EXISTS dwh.d_aplanbudgethdr
(
    aplanbudgethdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START -1 MINVALUE -1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    financial_year character varying(30) COLLATE public.nocase,
    budget_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    budget_date timestamp without time zone,
    numbering_typeno character varying(20) COLLATE public.nocase,
    total_base_req_amount numeric(20,2),
    total_base_alloc_amount numeric(20,2),
    total_base_variance_amount numeric(20,2),
    budget_status character varying(50) COLLATE public.nocase,
    doc_type character varying(50) COLLATE public.nocase,
    utilized_amount numeric(20,2),
    total_proposed_amount numeric(20,2),
    amendment_number character varying(40) COLLATE public.nocase,
    total_alloc_amount numeric(20,2),
    total_utilized_amount numeric(20,2),
    total_base_bal_amount numeric(20,2),
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
    CONSTRAINT d_aplanbudgethdr_pkey PRIMARY KEY (aplanbudgethdr_key),
    CONSTRAINT d_aplanbudgethdr_ukey UNIQUE (ou_id, financial_year, budget_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_aplanbudgethdr
    OWNER to proconnect;
-- Index: d_aplanbudgethdr_key_idx

-- DROP INDEX IF EXISTS dwh.d_aplanbudgethdr_key_idx;

CREATE INDEX IF NOT EXISTS d_aplanbudgethdr_key_idx
    ON dwh.d_aplanbudgethdr USING btree
    (ou_id ASC NULLS LAST, financial_year COLLATE public.nocase ASC NULLS LAST, budget_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;