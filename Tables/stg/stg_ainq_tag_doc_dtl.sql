-- Table: stg.stg_ainq_tag_doc_dtl

-- DROP TABLE IF EXISTS stg.stg_ainq_tag_doc_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ainq_tag_doc_dtl
(
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    doc_number character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer,
    doc_amount numeric,
    doc_type character varying(160) COLLATE public.nocase NOT NULL,
    cap_amount numeric,
    proposal_number character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ainq_tag_doc_dtl_pkey PRIMARY KEY (ou_id, fb_id, cap_number, asset_number, tag_number, doc_number, line_no, doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainq_tag_doc_dtl
    OWNER to proconnect;
-- Index: stg_ainq_tag_doc_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_ainq_tag_doc_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_ainq_tag_doc_dtl_key_idx
    ON stg.stg_ainq_tag_doc_dtl USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;