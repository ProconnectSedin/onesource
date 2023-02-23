-- Table: stg.stg_trd_code_classification

-- DROP TABLE IF EXISTS stg.stg_trd_code_classification;

CREATE TABLE IF NOT EXISTS stg.stg_trd_code_classification
(
    tax_type character varying(100) COLLATE public.nocase,
    tax_community character varying(100) COLLATE public.nocase,
    code_classification character varying(100) COLLATE public.nocase,
    code_type character varying(100) COLLATE public.nocase,
    code_classification_code character varying(100) COLLATE public.nocase,
    code_type_code character varying(100) COLLATE public.nocase,
    language_id integer,
    default_flag character varying(48) COLLATE public.nocase,
    cml_len integer,
    cml_translate character varying(8) COLLATE public.nocase,
    orderby integer,
    sub_code_type character varying(100) COLLATE public.nocase,
    sub_code_type_code character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_trd_code_classification
    OWNER to proconnect;
-- Index: stg_trd_code_classification_key_idx2

-- DROP INDEX IF EXISTS stg.stg_trd_code_classification_key_idx2;

CREATE INDEX IF NOT EXISTS stg_trd_code_classification_key_idx2
    ON stg.stg_trd_code_classification USING btree
    (tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, code_classification COLLATE public.nocase ASC NULLS LAST, code_type COLLATE public.nocase ASC NULLS LAST, code_classification_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;