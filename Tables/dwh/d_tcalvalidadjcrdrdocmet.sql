-- Table: dwh.d_tcalvalidadjcrdrdocmet

-- DROP TABLE IF EXISTS dwh.d_tcalvalidadjcrdrdocmet;

CREATE TABLE IF NOT EXISTS dwh.d_tcalvalidadjcrdrdocmet
(
    d_tcalvalidadjcrdrdocmet_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    component character varying(40) COLLATE public.nocase,
    cr_doc_type character varying(510) COLLATE public.nocase,
    dr_doc_type character varying(510) COLLATE public.nocase,
    allow character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_tcalvalidadjcrdrdocmet_pkey PRIMARY KEY (d_tcalvalidadjcrdrdocmet_key),
    CONSTRAINT d_tcalvalidadjcrdrdocmet_ukey UNIQUE (tax_type, tax_community, component, cr_doc_type, dr_doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_tcalvalidadjcrdrdocmet
    OWNER to proconnect;
-- Index: d_tcalvalidadjcrdrdocmet_key_idx

-- DROP INDEX IF EXISTS dwh.d_tcalvalidadjcrdrdocmet_key_idx;

CREATE INDEX IF NOT EXISTS d_tcalvalidadjcrdrdocmet_key_idx
    ON dwh.d_tcalvalidadjcrdrdocmet USING btree
    (tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, component COLLATE public.nocase ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;