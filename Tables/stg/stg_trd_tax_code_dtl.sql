-- Table: stg.stg_trd_tax_code_dtl

-- DROP TABLE IF EXISTS stg.stg_trd_tax_code_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_trd_tax_code_dtl
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_code character varying(40) COLLATE public.nocase NOT NULL,
    sequence_no integer NOT NULL,
    rate numeric NOT NULL,
    effective_from_date timestamp without time zone NOT NULL,
    effective_to_date timestamp without time zone,
    created_at integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT trd_tax_code_dtl_pk PRIMARY KEY (company_code, tax_code, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_trd_tax_code_dtl
    OWNER to proconnect;
-- Index: stg_trd_tax_code_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_trd_tax_code_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_trd_tax_code_dtl_key_idx
    ON stg.stg_trd_tax_code_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_code COLLATE public.nocase ASC NULLS LAST, sequence_no ASC NULLS LAST)
    TABLESPACE pg_default;