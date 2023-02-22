-- Table: stg.stg_trd_tax_group_dtl

-- DROP TABLE IF EXISTS stg.stg_trd_tax_group_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_trd_tax_group_dtl
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_group_code character varying(40) COLLATE public.nocase NOT NULL,
    item_code character varying(128) COLLATE public.nocase NOT NULL,
    variant character varying(80) COLLATE public.nocase NOT NULL,
    effective_from_date timestamp without time zone NOT NULL,
    type character(8) COLLATE public.nocase NOT NULL,
    effective_to_date timestamp without time zone,
    created_at integer NOT NULL,
    assessable_rate numeric,
    commoditycode character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT trd_tax_group_dtl_pk PRIMARY KEY (company_code, tax_group_code, item_code, variant, type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_trd_tax_group_dtl
    OWNER to proconnect;
-- Index: stg_trd_tax_group_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_trd_tax_group_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_trd_tax_group_dtl_key_idx2
    ON stg.stg_trd_tax_group_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_group_code COLLATE public.nocase ASC NULLS LAST, item_code COLLATE public.nocase ASC NULLS LAST, variant COLLATE public.nocase ASC NULLS LAST, type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;