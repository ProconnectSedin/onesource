-- Table: dwh.d_trdtaxcodehdr

-- DROP TABLE IF EXISTS dwh.d_trdtaxcodehdr;

CREATE TABLE IF NOT EXISTS dwh.d_trdtaxcodehdr
(
    trdtaxcodehdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    tax_code character varying(20) COLLATE public.nocase,
    tax_code_desc character varying(80) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    tax_region character varying(20) COLLATE public.nocase,
    code_type character varying(20) COLLATE public.nocase,
    tax_basis character varying(16) COLLATE public.nocase,
    tax_uom character varying(20) COLLATE public.nocase,
    status character varying(20) COLLATE public.nocase,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    "timestamp" integer,
    code_classification character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdtaxcodehdr_pkey PRIMARY KEY (trdtaxcodehdr_key),
    CONSTRAINT d_trdtaxcodehdr_ukey UNIQUE (company_code, tax_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdtaxcodehdr
    OWNER to proconnect;
-- Index: d_trdtaxcodehdr_key_idx1

-- DROP INDEX IF EXISTS dwh.d_trdtaxcodehdr_key_idx1;

CREATE INDEX IF NOT EXISTS d_trdtaxcodehdr_key_idx1
    ON dwh.d_trdtaxcodehdr USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;