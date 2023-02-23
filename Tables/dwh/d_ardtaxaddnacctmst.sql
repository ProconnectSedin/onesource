-- Table: dwh.d_ardtaxaddnacctmst

-- DROP TABLE IF EXISTS dwh.d_ardtaxaddnacctmst;

CREATE TABLE IF NOT EXISTS dwh.d_ardtaxaddnacctmst
(
    ard_tax_addn_acct_mst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    tax_region character varying(20) COLLATE public.nocase,
    effective_from timestamp without time zone,
    sequence_no integer,
    finance_book character varying(40) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ardtaxaddnacctmst_pkey PRIMARY KEY (ard_tax_addn_acct_mst_key),
    CONSTRAINT d_ardtaxaddnacctmst_ukey UNIQUE (company_code, tax_type, tax_community, usage_id, effective_from, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardtaxaddnacctmst
    OWNER to proconnect;