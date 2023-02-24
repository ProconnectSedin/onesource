-- Table: stg.stg_aplan_acq_proposal_dtl

-- DROP TABLE IF EXISTS stg.stg_aplan_acq_proposal_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_aplan_acq_proposal_dtl
(
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    financial_year character varying(60) COLLATE public.nocase NOT NULL,
    asset_class_code character varying(80) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    asset_desc character varying(160) COLLATE public.nocase NOT NULL,
    proposal_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    no_of_units integer,
    proposal_cost numeric,
    cost_base_curr numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT aplan_acq_proposal_dtl_pkey PRIMARY KEY (fb_id, ou_id, financial_year, asset_class_code, currency_code, asset_desc, proposal_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_aplan_acq_proposal_dtl
    OWNER to proconnect;
-- Index: stg_aplan_acq_proposal_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_aplan_acq_proposal_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_aplan_acq_proposal_dtl_idx
    ON stg.stg_aplan_acq_proposal_dtl USING btree
    (fb_id COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, financial_year COLLATE public.nocase ASC NULLS LAST, asset_class_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, asset_desc COLLATE public.nocase ASC NULLS LAST, proposal_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;