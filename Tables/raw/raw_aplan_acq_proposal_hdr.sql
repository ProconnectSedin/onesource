CREATE TABLE raw.raw_aplan_acq_proposal_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    financial_year character varying(60) NOT NULL COLLATE public.nocase,
    asset_class_code character varying(80) NOT NULL COLLATE public.nocase,
    currency_code character varying(20) NOT NULL COLLATE public.nocase,
    proposal_number character varying(72) NOT NULL COLLATE public.nocase,
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
    proposed_cost_variance numeric,
    proposal_status character varying(100) COLLATE public.nocase,
    amendment_number character varying(72) COLLATE public.nocase,
    proposed_cost numeric,
    commited_amount numeric,
    liability_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    workflow_status character varying(80) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    addnl_entity character varying(8) DEFAULT '0'::character varying NOT NULL COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_aplan_acq_proposal_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_aplan_acq_proposal_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_aplan_acq_proposal_hdr
    ADD CONSTRAINT raw_aplan_acq_proposal_hdr_pkey PRIMARY KEY (raw_id);