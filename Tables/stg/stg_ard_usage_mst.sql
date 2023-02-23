-- Table: stg.stg_ard_usage_mst

-- DROP TABLE IF EXISTS stg.stg_ard_usage_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ard_usage_mst
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    usage_id character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    usage_type character varying(16) COLLATE public.nocase,
    usage_shortdesc character varying(160) COLLATE public.nocase,
    usage_desc character varying(1020) COLLATE public.nocase,
    account_desc character varying(160) COLLATE public.nocase,
    ard_type character varying(80) COLLATE public.nocase,
    account_group character varying(60) COLLATE public.nocase,
    account_currency character varying(20) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ard_usage_mst_pkey PRIMARY KEY (company_code, usage_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ard_usage_mst
    OWNER to proconnect;