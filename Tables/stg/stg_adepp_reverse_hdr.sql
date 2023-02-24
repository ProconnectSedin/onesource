-- Table: stg.stg_adepp_reverse_hdr

-- DROP TABLE IF EXISTS stg.stg_adepp_reverse_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_adepp_reverse_hdr
(
    ou_id integer NOT NULL,
    rev_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    revr_option character varying(80) COLLATE public.nocase,
    depr_proc_runno character varying(80) COLLATE public.nocase NOT NULL,
    depr_total numeric,
    susp_total numeric,
    reversal_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    rev_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adepp_reverse_hdr_pkey PRIMARY KEY (ou_id, rev_doc_no, depr_proc_runno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adepp_reverse_hdr
    OWNER to proconnect;
-- Index: stg_adepp_reverse_hdr_idx

-- DROP INDEX IF EXISTS stg.stg_adepp_reverse_hdr_idx;

CREATE INDEX IF NOT EXISTS stg_adepp_reverse_hdr_idx
    ON stg.stg_adepp_reverse_hdr USING btree
    (ou_id ASC NULLS LAST, rev_doc_no COLLATE public.nocase ASC NULLS LAST, depr_proc_runno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;