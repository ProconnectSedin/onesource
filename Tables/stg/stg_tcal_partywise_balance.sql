-- Table: stg.stg_tcal_partywise_balance

-- DROP TABLE IF EXISTS stg.stg_tcal_partywise_balance;

CREATE TABLE IF NOT EXISTS stg.stg_tcal_partywise_balance
(
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tcal_partywise_balance
    OWNER to proconnect;
-- Index: stg_tcal_partywise_balance_idx

-- DROP INDEX IF EXISTS stg.stg_tcal_partywise_balance_idx;

CREATE INDEX IF NOT EXISTS stg_tcal_partywise_balance_idx
    ON stg.stg_tcal_partywise_balance USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, party_type COLLATE public.nocase ASC NULLS LAST, party_code COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, assessee_type COLLATE public.nocase ASC NULLS LAST, tax_class COLLATE public.nocase ASC NULLS LAST, tax_category COLLATE public.nocase ASC NULLS LAST, tax_year COLLATE public.nocase ASC NULLS LAST, contract_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;