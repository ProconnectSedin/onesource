-- Table: dwh.f_aplanacqproposaldtl

-- DROP TABLE IF EXISTS dwh.f_aplanacqproposaldtl;

CREATE TABLE IF NOT EXISTS dwh.f_aplanacqproposaldtl
(
    aplan_acq_proposal_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fb_id character varying(40) COLLATE public.nocase,
    ou_id integer,
    financial_year character varying(30) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    proposal_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    no_of_units integer,
    proposal_cost numeric(25,2),
    cost_base_curr numeric(25,2),
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
    CONSTRAINT f_aplanacqproposaldtl_pkey PRIMARY KEY (aplan_acq_proposal_dtl_key),
    CONSTRAINT f_aplanacqproposaldtl_ukey UNIQUE (fb_id, ou_id, financial_year, asset_class_code, currency_code, asset_desc, proposal_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_aplanacqproposaldtl
    OWNER to proconnect;