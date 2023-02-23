-- Table: raw.raw_tset_tax_category

-- DROP TABLE IF EXISTS "raw".raw_tset_tax_category;

CREATE TABLE IF NOT EXISTS "raw".raw_tset_tax_category
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_category character varying(160) COLLATE public.nocase NOT NULL,
    tax_category_desc character varying(400) COLLATE public.nocase NOT NULL,
    calc_tax character varying(32) COLLATE public.nocase,
    trade_type character varying(32) COLLATE public.nocase NOT NULL,
    status character(8) COLLATE public.nocase,
    predefined_type character varying(32) COLLATE public.nocase NOT NULL,
    created_at integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tax_category_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_tset_tax_category_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_tset_tax_category
    OWNER to proconnect;