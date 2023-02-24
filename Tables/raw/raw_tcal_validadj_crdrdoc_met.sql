-- Table: raw.raw_tcal_validadj_crdrdoc_met

-- DROP TABLE IF EXISTS "raw".raw_tcal_validadj_crdrdoc_met;

CREATE TABLE IF NOT EXISTS "raw".raw_tcal_validadj_crdrdoc_met
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    component character varying(80) COLLATE public.nocase NOT NULL,
    cr_doc_type character varying(1020) COLLATE public.nocase NOT NULL,
    dr_doc_type character varying(1020) COLLATE public.nocase NOT NULL,
    allow character varying(48) COLLATE public.nocase NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT d_tcalvalidadjcrdrdocmet_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_tcal_validadj_crdrdoc_met
    OWNER to proconnect;