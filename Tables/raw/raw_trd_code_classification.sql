-- Table: raw.raw_trd_code_classification

-- DROP TABLE IF EXISTS "raw".raw_trd_code_classification;

CREATE TABLE IF NOT EXISTS "raw".raw_trd_code_classification
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_trd_code_classification_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_trd_code_classification
    OWNER to proconnect;