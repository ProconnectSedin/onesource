-- Table: dwh.f_tcalpartywisebalance

-- DROP TABLE IF EXISTS dwh.f_tcalpartywisebalance;

CREATE TABLE IF NOT EXISTS dwh.f_tcalpartywisebalance
(
    tcal_party_wise_balance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tcalpartywisebalance_company_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    party_type character varying(16) COLLATE public.nocase,
    party_code character varying(36) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    tax_class character varying(80) COLLATE public.nocase,
    tax_category character varying(80) COLLATE public.nocase,
    tax_year character varying(20) COLLATE public.nocase,
    assessee_type character varying(80) COLLATE public.nocase,
    cum_tran_amt_dr numeric(25,2),
    cum_taxable_amt_dr numeric(25,2),
    cum_tax_amt_dr numeric(25,2),
    cum_tran_amt_cr numeric(25,2),
    cum_taxable_amt_cr numeric(25,2),
    cum_tax_amt_cr numeric(25,2),
    "timestamp" integer,
    contract_no character varying(36) COLLATE public.nocase,
    tax_dedection_flag character varying(24) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_tcalpartywisebalance_pkey PRIMARY KEY (tcal_party_wise_balance_key),
    CONSTRAINT f_tcalpartywisebalance_ukey UNIQUE (company_code, party_type, party_code, tax_type, tax_class, tax_category, tax_year, assessee_type, contract_no),
    CONSTRAINT f_tcalpartywisebalance_tcalpartywisebalance_company_key_fkey FOREIGN KEY (tcalpartywisebalance_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tcalpartywisebalance
    OWNER to proconnect;