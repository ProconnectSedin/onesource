-- Table: dwh.d_tsettaxcategory

-- DROP TABLE IF EXISTS dwh.d_tsettaxcategory;

CREATE TABLE IF NOT EXISTS dwh.d_tsettaxcategory
(
    tsettaxcategory_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_community character varying(50) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    tax_category character varying(80) COLLATE public.nocase,
    tax_category_desc character varying(200) COLLATE public.nocase,
    calc_tax character varying(16) COLLATE public.nocase,
    trade_type character varying(16) COLLATE public.nocase,
    status character(8) COLLATE pg_catalog."default",
    predefined_type character varying(16) COLLATE public.nocase,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tax_category_type character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_tsettaxcategory_pkey PRIMARY KEY (tsettaxcategory_key),
    CONSTRAINT d_tsettaxcategory_ukey UNIQUE (tax_community, tax_type, company_code, tax_category, trade_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_tsettaxcategory
    OWNER to proconnect;