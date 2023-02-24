-- Table: raw.raw_trd_tax_code_dtl

-- DROP TABLE IF EXISTS "raw".raw_trd_tax_code_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_trd_tax_code_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_code character varying(40) COLLATE public.nocase NOT NULL,
    sequence_no integer NOT NULL,
    rate numeric NOT NULL,
    effective_from_date timestamp without time zone NOT NULL,
    effective_to_date timestamp without time zone,
    created_at integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT trd_tax_code_dtl_pk PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_trd_tax_code_dtl
    OWNER to proconnect;