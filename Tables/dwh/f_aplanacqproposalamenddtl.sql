-- Table: dwh.f_aplanacqproposalamenddtl

-- DROP TABLE IF EXISTS dwh.f_aplanacqproposalamenddtl;

CREATE TABLE IF NOT EXISTS dwh.f_aplanacqproposalamenddtl
(
    f_aplanacqproposalamenddtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    currency_key bigint,
    proposal_number character varying(40) COLLATE public.nocase,
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    financial_year character varying(30) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    amendment_number character varying(40) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    no_of_units integer,
    proposal_cost numeric(13,2),
    cost_base_curr numeric(13,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_aplanacqproposalamenddtl_pkey PRIMARY KEY (f_aplanacqproposalamenddtl_key),
    CONSTRAINT f_aplanacqproposalamenddtl_ukey UNIQUE (ou_id, fb_id, financial_year, proposal_number, asset_class_code, currency_code, amendment_number, asset_desc)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_aplanacqproposalamenddtl
    OWNER to proconnect;
-- Index: f_aplanacqproposalamenddtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_aplanacqproposalamenddtl_key_idx;

CREATE INDEX IF NOT EXISTS f_aplanacqproposalamenddtl_key_idx
    ON dwh.f_aplanacqproposalamenddtl USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, financial_year COLLATE public.nocase ASC NULLS LAST, proposal_number COLLATE public.nocase ASC NULLS LAST, asset_class_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, amendment_number COLLATE public.nocase ASC NULLS LAST, asset_desc COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
	
CREATE INDEX IF NOT EXISTS f_aplanacqproposalamenddtl_key_idx1
    ON dwh.f_aplanacqproposalamenddtl USING btree
	(currency_code)