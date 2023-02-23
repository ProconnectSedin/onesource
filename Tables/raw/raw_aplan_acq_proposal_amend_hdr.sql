-- Table: raw.raw_aplan_acq_proposal_amend_hdr

-- DROP TABLE IF EXISTS "raw".raw_aplan_acq_proposal_amend_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_aplan_acq_proposal_amend_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    financial_year character varying(60) COLLATE public.nocase NOT NULL,
    asset_class_code character varying(80) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    amendment_number character varying(72) COLLATE public.nocase NOT NULL,
    proposal_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    proposal_date timestamp without time zone,
    numbering_typeno character varying(40) COLLATE public.nocase,
    proposal_desc character varying(160) COLLATE public.nocase,
    budget_number character varying(72) COLLATE public.nocase,
    board_ref character varying(400) COLLATE public.nocase,
    board_ref_date timestamp without time zone,
    expiry_date timestamp without time zone,
    exchange_rate numeric,
    exchange_rate_var_per integer,
    cost_var_per integer,
    total_proposed_cost_bc numeric,
    total_prop_cost_orig numeric,
    proposed_cost_variance numeric,
    proposal_status character varying(100) COLLATE public.nocase,
    prop_cost_diff numeric,
    committed_amount numeric,
    liability_amount numeric,
    proposed_cost numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_aplan_acq_proposal_amend_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_aplan_acq_proposal_amend_hdr
    OWNER to proconnect;