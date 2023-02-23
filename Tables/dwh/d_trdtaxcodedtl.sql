-- Table: dwh.d_trdtaxcodedtl

-- DROP TABLE IF EXISTS dwh.d_trdtaxcodedtl;

CREATE TABLE IF NOT EXISTS dwh.d_trdtaxcodedtl
(
    trdtaxcodedtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    trdtaxcodehdr_key bigint NOT NULL,
    trdtaxcodecompany_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    tax_code character varying(20) COLLATE public.nocase,
    sequence_no integer,
    rate numeric(13,2),
    effective_from_date timestamp without time zone,
    effective_to_date timestamp without time zone,
    created_at integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdtaxcodedtl_pkey PRIMARY KEY (trdtaxcodedtl_key),
    CONSTRAINT d_trdtaxcodedtl_ukey UNIQUE (company_code, tax_code, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdtaxcodedtl
    OWNER to proconnect;
-- Index: d_trdtaxcodedtl_key_idx

-- DROP INDEX IF EXISTS dwh.d_trdtaxcodedtl_key_idx;

CREATE INDEX IF NOT EXISTS d_trdtaxcodedtl_key_idx
    ON dwh.d_trdtaxcodedtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_code COLLATE public.nocase ASC NULLS LAST, sequence_no ASC NULLS LAST)
    TABLESPACE pg_default;