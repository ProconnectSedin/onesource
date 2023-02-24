-- Table: stg.stg_adepp_adjustments_hdr

-- DROP TABLE IF EXISTS stg.stg_adepp_adjustments_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_adepp_adjustments_hdr
(
    ou_id integer NOT NULL,
    document_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    depr_book character varying(80) COLLATE public.nocase,
    doc_status character varying(100) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    depr_total numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    wf_guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adepp_adjustments_hdr_pkey PRIMARY KEY (ou_id, document_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adepp_adjustments_hdr
    OWNER to proconnect;
-- Index: stg_adepp_adjustments_hdr_idx

-- DROP INDEX IF EXISTS stg.stg_adepp_adjustments_hdr_idx;

CREATE INDEX IF NOT EXISTS stg_adepp_adjustments_hdr_idx
    ON stg.stg_adepp_adjustments_hdr USING btree
    (ou_id ASC NULLS LAST, document_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;