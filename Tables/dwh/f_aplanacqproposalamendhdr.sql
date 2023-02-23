-- Table: dwh.f_aplanacqproposalamendhdr

-- DROP TABLE IF EXISTS dwh.f_aplanacqproposalamendhdr;

CREATE TABLE IF NOT EXISTS dwh.f_aplanacqproposalamendhdr
(
    aplanacqproposalamendhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    currency_key bigint,
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    financial_year character varying(30) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    amendment_number character varying(40) COLLATE public.nocase,
    proposal_number character varying(40) COLLATE public.nocase,
    proposal_date timestamp without time zone,
    numbering_typeno character varying(20) COLLATE public.nocase,
    proposal_desc character varying(80) COLLATE public.nocase,
    budget_number character varying(40) COLLATE public.nocase,
    board_ref character varying(200) COLLATE public.nocase,
    board_ref_date timestamp without time zone,
    expiry_date timestamp without time zone,
    exchange_rate numeric(25,2),
    total_proposed_cost_bc numeric(25,2),
    proposed_cost_variance numeric(25,2),
    proposal_status character varying(50) COLLATE public.nocase,
    committed_amount numeric(25,2),
    liability_amount numeric(25,2),
    proposed_cost numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_aplanacqproposalamendhdr_pkey PRIMARY KEY (aplanacqproposalamendhdr_key),
    CONSTRAINT f_aplanacqproposalamendhdr_ukey UNIQUE (ou_id, fb_id, financial_year, asset_class_code, currency_code, amendment_number, proposal_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_aplanacqproposalamendhdr
    OWNER to proconnect;
-- Index: f_aplanacqproposalamendhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_aplanacqproposalamendhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_aplanacqproposalamendhdr_key_idx
    ON dwh.f_aplanacqproposalamendhdr USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, financial_year COLLATE public.nocase ASC NULLS LAST, asset_class_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, amendment_number COLLATE public.nocase ASC NULLS LAST, proposal_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
	
CREATE INDEX IF NOT EXISTS f_aplanacqproposalamendhdr_key_idx1
    ON dwh.f_aplanacqproposalamendhdr USING btree
(currency_code)