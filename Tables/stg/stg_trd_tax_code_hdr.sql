-- Table: stg.stg_trd_tax_code_hdr

-- DROP TABLE IF EXISTS stg.stg_trd_tax_code_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_trd_tax_code_hdr
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_code_desc character varying(160) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase,
    code_type character varying(40) COLLATE public.nocase,
    tax_basis character varying(32) COLLATE public.nocase NOT NULL,
    tax_uom character varying(40) COLLATE public.nocase,
    status character(8) COLLATE public.nocase NOT NULL,
    created_at integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    "timestamp" integer NOT NULL,
    code_classification character varying(160) COLLATE public.nocase,
    sub_code_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT trd_tax_code_hdr_pk PRIMARY KEY (company_code, tax_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_trd_tax_code_hdr
    OWNER to proconnect;
-- Index: stg_trd_tax_code_hdr_key_idx2

-- DROP INDEX IF EXISTS stg.stg_trd_tax_code_hdr_key_idx2;

CREATE INDEX IF NOT EXISTS stg_trd_tax_code_hdr_key_idx2
    ON stg.stg_trd_tax_code_hdr USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;