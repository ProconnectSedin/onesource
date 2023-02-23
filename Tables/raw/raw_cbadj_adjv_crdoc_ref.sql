-- Table: raw.raw_cbadj_adjv_crdoc_ref

-- DROP TABLE IF EXISTS "raw".raw_cbadj_adjv_crdoc_ref;

CREATE TABLE IF NOT EXISTS "raw".raw_cbadj_adjv_crdoc_ref
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_cbadj_adjv_crdoc_ref_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cbadj_adjv_crdoc_ref
    OWNER to proconnect;