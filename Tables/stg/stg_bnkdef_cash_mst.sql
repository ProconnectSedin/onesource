-- Table: stg.stg_bnkdef_cash_mst

-- DROP TABLE IF EXISTS stg.stg_bnkdef_cash_mst;

CREATE TABLE IF NOT EXISTS stg.stg_bnkdef_cash_mst
(
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
    CONSTRAINT bnkdef_cash_mst_pkey PRIMARY KEY (company_code, cash_code, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_bnkdef_cash_mst
    OWNER to proconnect;
-- Index: stg_bnkdef_cash_mst_key_idx2

-- DROP INDEX IF EXISTS stg.stg_bnkdef_cash_mst_key_idx2;

CREATE INDEX IF NOT EXISTS stg_bnkdef_cash_mst_key_idx2
    ON stg.stg_bnkdef_cash_mst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, cash_code COLLATE public.nocase ASC NULLS LAST, serial_no ASC NULLS LAST)
    TABLESPACE pg_default;