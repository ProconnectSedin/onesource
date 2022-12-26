CREATE TABLE stg.stg_ard_tax_addn_acct_mst (
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    tax_type character varying(100) NOT NULL COLLATE public.nocase,
    tax_community character varying(100) NOT NULL COLLATE public.nocase,
    usage_id character varying(80) NOT NULL COLLATE public.nocase,
    tax_region character varying(40) NOT NULL COLLATE public.nocase,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    finance_book character varying(80) COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    effective_to timestamp without time zone,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);