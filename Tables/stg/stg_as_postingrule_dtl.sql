-- Table: stg.stg_as_postingrule_dtl

-- DROP TABLE IF EXISTS stg.stg_as_postingrule_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_as_postingrule_dtl
(
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
    CONSTRAINT as_postingrule_dtl_pkey PRIMARY KEY (company_code, jv_type, effective_from, autopost_acctype, ctrl_acctype, account_class, account_group, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_as_postingrule_dtl
    OWNER to proconnect;
-- Index: stg_as_postingrule_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_as_postingrule_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_as_postingrule_dtl_key_idx2
    ON stg.stg_as_postingrule_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, jv_type COLLATE public.nocase ASC NULLS LAST, effective_from ASC NULLS LAST, autopost_acctype COLLATE public.nocase ASC NULLS LAST, ctrl_acctype COLLATE public.nocase ASC NULLS LAST, account_class COLLATE public.nocase ASC NULLS LAST, account_group COLLATE public.nocase ASC NULLS LAST, sequence_no ASC NULLS LAST)
    TABLESPACE pg_default;