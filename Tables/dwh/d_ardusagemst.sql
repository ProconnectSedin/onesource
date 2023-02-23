-- Table: dwh.d_ardusagemst

-- DROP TABLE IF EXISTS dwh.d_ardusagemst;

CREATE TABLE IF NOT EXISTS dwh.d_ardusagemst
(
    ard_usage_mst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    usage_type character varying(8) COLLATE public.nocase,
    usage_shortdesc character varying(80) COLLATE public.nocase,
    usage_desc character varying(510) COLLATE public.nocase,
    account_desc character varying(80) COLLATE public.nocase,
    ard_type character varying(40) COLLATE public.nocase,
    account_group character varying(30) COLLATE public.nocase,
    account_currency character varying(10) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ardusagemst_pkey PRIMARY KEY (ard_usage_mst_key),
    CONSTRAINT d_ardusagemst_ukey UNIQUE (company_code, usage_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardusagemst
    OWNER to proconnect;