-- Table: stg.stg_cbadj_adjv_crdoc_ref

-- DROP TABLE IF EXISTS stg.stg_cbadj_adjv_crdoc_ref;

CREATE TABLE IF NOT EXISTS stg.stg_cbadj_adjv_crdoc_ref
(
    parent_key character varying(512) COLLATE public.nocase NOT NULL,
    ref_cr_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    cr_doc_ou integer NOT NULL,
    cr_doc_type character varying(160) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    cr_doc_adj_amt numeric,
    cr_doc_unadj_amt numeric,
    tran_type character varying(160) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT cbadj_adjv_crdoc_ref_pkey PRIMARY KEY (parent_key, ref_cr_doc_no, cr_doc_ou, cr_doc_type, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cbadj_adjv_crdoc_ref
    OWNER to proconnect;
-- Index: stg_cbadj_adjv_crdoc_ref_idx

-- DROP INDEX IF EXISTS stg.stg_cbadj_adjv_crdoc_ref_idx;

CREATE INDEX IF NOT EXISTS stg_cbadj_adjv_crdoc_ref_idx
    ON stg.stg_cbadj_adjv_crdoc_ref USING btree
    (ref_cr_doc_no COLLATE public.nocase ASC NULLS LAST, cr_doc_ou ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST, guid COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS stg_cbadj_adjv_crdoc_ref_idx1
    ON stg.stg_cbadj_adjv_crdoc_ref USING btree
	(ref_cr_doc_no, cr_doc_ou, cr_doc_type, guid)