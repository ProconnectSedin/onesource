-- Table: raw.raw_bnkdef_cash_mst

-- DROP TABLE IF EXISTS "raw".raw_bnkdef_cash_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_bnkdef_cash_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    cash_code character varying(128) COLLATE public.nocase NOT NULL,
    serial_no integer NOT NULL,
    "timestamp" integer,
    cash_desc character varying(160) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    creation_ou integer,
    modification_ou integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_bnkdef_cash_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_bnkdef_cash_mst
    OWNER to proconnect;