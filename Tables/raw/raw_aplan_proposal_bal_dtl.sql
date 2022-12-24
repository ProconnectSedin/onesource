CREATE TABLE raw.raw_aplan_proposal_bal_dtl (
    raw_id bigint NOT NULL,
    "timestamp" integer,
    ou_id integer,
    proposal_number character varying(72) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    proposal_amount numeric,
    balance_amount numeric,
    committed_amount numeric,
    liability_amount numeric,
    utilized_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    rpt_flag character varying(32) DEFAULT 'Y'::character varying NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);