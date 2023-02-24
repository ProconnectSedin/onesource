-- Table: raw.raw_tcal_partywise_balance

-- DROP TABLE IF EXISTS "raw".raw_tcal_partywise_balance;

CREATE TABLE IF NOT EXISTS "raw".raw_tcal_partywise_balance
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    party_type character varying(32) COLLATE public.nocase NOT NULL,
    party_code character varying(72) COLLATE public.nocase,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_class character varying(160) COLLATE public.nocase NOT NULL,
    tax_category character varying(160) COLLATE public.nocase NOT NULL,
    tax_year character varying(40) COLLATE public.nocase NOT NULL,
    assessee_type character varying(160) COLLATE public.nocase,
    cum_tran_amt_dr numeric NOT NULL,
    cum_taxable_amt_dr numeric NOT NULL,
    cum_tax_amt_dr numeric NOT NULL,
    cum_tran_amt_cr numeric NOT NULL,
    cum_taxable_amt_cr numeric NOT NULL,
    cum_tax_amt_cr numeric NOT NULL,
    "timestamp" integer NOT NULL,
    contract_no character varying(72) COLLATE public.nocase NOT NULL,
    tax_dedection_flag character varying(48) COLLATE public.nocase,
    tax_group character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_tcal_partywise_balance_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_tcal_partywise_balance
    OWNER to proconnect;