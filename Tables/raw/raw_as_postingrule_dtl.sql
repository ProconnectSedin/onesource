-- Table: raw.raw_as_postingrule_dtl

-- DROP TABLE IF EXISTS "raw".raw_as_postingrule_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_as_postingrule_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    jv_type character varying(100) COLLATE public.nocase NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    autopost_acctype character varying(160) COLLATE public.nocase NOT NULL,
    ctrl_acctype character varying(160) COLLATE public.nocase NOT NULL,
    account_class character varying(80) COLLATE public.nocase NOT NULL,
    account_group character varying(80) COLLATE public.nocase NOT NULL,
    sequence_no integer NOT NULL,
    "timestamp" integer,
    account_code character varying(128) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    effective_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_as_postingrule_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_as_postingrule_dtl
    OWNER to proconnect;