-- Table: stg.stg_sad_adjv_drdoc_ref

-- DROP TABLE IF EXISTS stg.stg_sad_adjv_drdoc_ref;

CREATE TABLE IF NOT EXISTS stg.stg_sad_adjv_drdoc_ref
(
    parent_key character varying(512) COLLATE public.nocase NOT NULL,
    ref_dr_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    dr_doc_ou integer NOT NULL,
    dr_doc_type character varying(160) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    dr_doc_adj_amt numeric,
    dr_doc_unadj_amt numeric,
    tran_type character varying(160) COLLATE public.nocase,
    discount numeric,
    guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sad_adjv_drdoc_ref_pkey UNIQUE (parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sad_adjv_drdoc_ref
    OWNER to proconnect;
-- Index: stg_sad_adjv_drdoc_ref_key_idx2

-- DROP INDEX IF EXISTS stg.stg_sad_adjv_drdoc_ref_key_idx2;

CREATE INDEX IF NOT EXISTS stg_sad_adjv_drdoc_ref_key_idx2
    ON stg.stg_sad_adjv_drdoc_ref USING btree
    (parent_key COLLATE public.nocase ASC NULLS LAST, ref_dr_doc_no COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;