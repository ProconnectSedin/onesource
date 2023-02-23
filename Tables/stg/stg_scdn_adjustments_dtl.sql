-- Table: stg.stg_scdn_adjustments_dtl

-- DROP TABLE IF EXISTS stg.stg_scdn_adjustments_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_scdn_adjustments_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    ref_doc_type character varying(40) COLLATE public.nocase NOT NULL,
    ref_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    ref_doc_date timestamp without time zone,
    ref_doc_fb_id character varying(80) COLLATE public.nocase,
    ref_doc_amount numeric,
    ref_doc_current_os numeric,
    ref_doc_supp_ou integer,
    guid character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ref_doc_adjamt numeric,
    ref_term_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT scdn_adjustments_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, ref_doc_type, ref_doc_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_scdn_adjustments_dtl
    OWNER to proconnect;
-- Index: stg_scdn_adjustments_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_scdn_adjustments_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_scdn_adjustments_dtl_idx
    ON stg.stg_scdn_adjustments_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, ref_doc_type COLLATE public.nocase ASC NULLS LAST, ref_doc_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;