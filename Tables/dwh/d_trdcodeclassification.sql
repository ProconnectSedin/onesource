-- Table: dwh.d_trdcodeclassification

-- DROP TABLE IF EXISTS dwh.d_trdcodeclassification;

CREATE TABLE IF NOT EXISTS dwh.d_trdcodeclassification
(
    trdcodeclassification_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    code_classification character varying(50) COLLATE public.nocase,
    code_type character varying(50) COLLATE public.nocase,
    code_classification_code character varying(50) COLLATE public.nocase,
    code_type_code character varying(50) COLLATE public.nocase,
    language_id integer,
    default_flag character varying(24) COLLATE public.nocase,
    cml_len integer,
    cml_translate character varying(4) COLLATE public.nocase,
    orderby integer,
    sub_code_type character varying(50) COLLATE public.nocase,
    sub_code_type_code character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdcodeclassification_pkey PRIMARY KEY (trdcodeclassification_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdcodeclassification
    OWNER to proconnect;
-- Index: d_trdcodeclassification_key_idx1

-- DROP INDEX IF EXISTS dwh.d_trdcodeclassification_key_idx1;

CREATE INDEX IF NOT EXISTS d_trdcodeclassification_key_idx1
    ON dwh.d_trdcodeclassification USING btree
    (tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, code_classification COLLATE public.nocase ASC NULLS LAST, code_type COLLATE public.nocase ASC NULLS LAST, code_classification_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;