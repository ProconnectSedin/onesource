-- Table: stg.stg_tcal_validadj_crdrdoc_met

-- DROP TABLE IF EXISTS stg.stg_tcal_validadj_crdrdoc_met;

CREATE TABLE IF NOT EXISTS stg.stg_tcal_validadj_crdrdoc_met
(
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    component character varying(80) COLLATE public.nocase NOT NULL,
    cr_doc_type character varying(1020) COLLATE public.nocase NOT NULL,
    dr_doc_type character varying(1020) COLLATE public.nocase NOT NULL,
    allow character varying(48) COLLATE public.nocase NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tcal_validadj_crdrdoc_met
    OWNER to proconnect;
-- Index: stg_tcal_validadj_crdrdoc_met_key_idx

-- DROP INDEX IF EXISTS stg.stg_tcal_validadj_crdrdoc_met_key_idx;

CREATE INDEX IF NOT EXISTS stg_tcal_validadj_crdrdoc_met_key_idx
    ON stg.stg_tcal_validadj_crdrdoc_met USING btree
    (tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, component COLLATE public.nocase ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;