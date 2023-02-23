-- Table: stg.stg_ard_tax_addn_acct_mst

-- DROP TABLE IF EXISTS stg.stg_ard_tax_addn_acct_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ard_tax_addn_acct_mst
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    usage_id character varying(80) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    finance_book character varying(80) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    effective_to timestamp without time zone,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ard_tax_addn_acct_mst_pk PRIMARY KEY (company_code, tax_type, tax_community, usage_id, effective_from, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ard_tax_addn_acct_mst
    OWNER to proconnect;