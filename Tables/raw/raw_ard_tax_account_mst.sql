-- Table: raw.raw_ard_tax_account_mst

-- DROP TABLE IF EXISTS "raw".raw_ard_tax_account_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_ard_tax_account_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_class character varying(160) COLLATE public.nocase NOT NULL,
    tax_category character varying(160) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase NOT NULL,
    tax_accounttype character varying(160) COLLATE public.nocase NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    finance_book character varying(80) COLLATE public.nocase,
    tax_group character varying(40) COLLATE public.nocase NOT NULL,
    tax_code character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    effective_to timestamp without time zone,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_ard_tax_account_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ard_tax_account_mst
    OWNER to proconnect;