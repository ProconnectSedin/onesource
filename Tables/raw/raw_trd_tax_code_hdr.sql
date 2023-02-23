-- Table: raw.raw_trd_tax_code_hdr

-- DROP TABLE IF EXISTS "raw".raw_trd_tax_code_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_trd_tax_code_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_trd_tax_code_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_trd_tax_code_hdr
    OWNER to proconnect;