-- Table: raw.raw_ard_usage_mst

-- DROP TABLE IF EXISTS "raw".raw_ard_usage_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_ard_usage_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_ard_usage_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ard_usage_mst
    OWNER to proconnect;