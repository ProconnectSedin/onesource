-- Table: dwh.d_trdtaxgroupdtl

-- DROP TABLE IF EXISTS dwh.d_trdtaxgroupdtl;

CREATE TABLE IF NOT EXISTS dwh.d_trdtaxgroupdtl
(
    trdtaxgroupdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    d_trdtaxgrouphdr_key bigint,
    company_code character varying(20) COLLATE public.nocase,
    tax_group_code character varying(20) COLLATE public.nocase,
    item_code character varying(64) COLLATE public.nocase,
    variant character varying(40) COLLATE public.nocase,
    effective_from_date timestamp without time zone,
    type character varying(40) COLLATE public.nocase,
    effective_to_date timestamp without time zone,
    created_at integer,
    assessable_rate numeric(20,3),
    commoditycode character varying(36) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdtaxgroupdtl_pkey PRIMARY KEY (trdtaxgroupdtl_key),
    CONSTRAINT d_trdtaxgroupdtl_ukey UNIQUE (company_code, tax_group_code, item_code, variant, type),
    CONSTRAINT d_trdtaxgroupdtl_d_trdtaxgrouphdr_key_fkey FOREIGN KEY (d_trdtaxgrouphdr_key)
        REFERENCES dwh.d_trdtaxgrouphdr (trdtaxgrouphdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdtaxgroupdtl
    OWNER to proconnect;
-- Index: d_trdtaxgroupdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.d_trdtaxgroupdtl_key_idx1;

CREATE INDEX IF NOT EXISTS d_trdtaxgroupdtl_key_idx1
    ON dwh.d_trdtaxgroupdtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_group_code COLLATE public.nocase ASC NULLS LAST, item_code COLLATE public.nocase ASC NULLS LAST, variant COLLATE public.nocase ASC NULLS LAST, type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;-- Table: dwh.d_trdtaxgroupdtl

-- DROP TABLE IF EXISTS dwh.d_trdtaxgroupdtl;

CREATE TABLE IF NOT EXISTS dwh.d_trdtaxgroupdtl
(
    trdtaxgroupdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    d_trdtaxgrouphdr_key bigint,
    company_code character varying(20) COLLATE public.nocase,
    tax_group_code character varying(20) COLLATE public.nocase,
    item_code character varying(64) COLLATE public.nocase,
    variant character varying(40) COLLATE public.nocase,
    effective_from_date timestamp without time zone,
    type character varying(40) COLLATE public.nocase,
    effective_to_date timestamp without time zone,
    created_at integer,
    assessable_rate numeric(20,3),
    commoditycode character varying(36) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdtaxgroupdtl_pkey PRIMARY KEY (trdtaxgroupdtl_key),
    CONSTRAINT d_trdtaxgroupdtl_ukey UNIQUE (company_code, tax_group_code, item_code, variant, type),
    CONSTRAINT d_trdtaxgroupdtl_d_trdtaxgrouphdr_key_fkey FOREIGN KEY (d_trdtaxgrouphdr_key)
        REFERENCES dwh.d_trdtaxgrouphdr (trdtaxgrouphdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdtaxgroupdtl
    OWNER to proconnect;
-- Index: d_trdtaxgroupdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.d_trdtaxgroupdtl_key_idx1;

CREATE INDEX IF NOT EXISTS d_trdtaxgroupdtl_key_idx1
    ON dwh.d_trdtaxgroupdtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_group_code COLLATE public.nocase ASC NULLS LAST, item_code COLLATE public.nocase ASC NULLS LAST, variant COLLATE public.nocase ASC NULLS LAST, type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;