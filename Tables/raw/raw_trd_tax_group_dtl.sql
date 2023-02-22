-- Table: raw.raw_trd_tax_group_dtl

-- DROP TABLE IF EXISTS "raw".raw_trd_tax_group_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_trd_tax_group_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_trd_tax_group_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_trd_tax_group_dtl
    OWNER to proconnect;