-- Table: stg.stg_trd_tax_group_hdr

-- DROP TABLE IF EXISTS stg.stg_trd_tax_group_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_trd_tax_group_hdr
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_group_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_group_desc character varying(400) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase,
    protest_flag integer NOT NULL,
    tax_uom character varying(40) COLLATE public.nocase,
    created_at integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    "timestamp" integer NOT NULL,
    tax_community character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT trd_tax_group_hdr_pk PRIMARY KEY (company_code, tax_group_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_trd_tax_group_hdr
    OWNER to proconnect;