-- Table: raw.raw_aplan_acq_proposal_amend_dtl

-- DROP TABLE IF EXISTS "raw".raw_aplan_acq_proposal_amend_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_aplan_acq_proposal_amend_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    proposal_number character varying(72) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    financial_year character varying(60) COLLATE public.nocase NOT NULL,
    asset_class_code character varying(80) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    amendment_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_desc character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    no_of_units integer,
    proposal_cost numeric,
    cost_base_curr numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_aplan_acq_proposal_amend_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_aplan_acq_proposal_amend_dtl
    OWNER to proconnect;