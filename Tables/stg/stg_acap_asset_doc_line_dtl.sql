-- Table: stg.stg_acap_asset_doc_line_dtl

-- DROP TABLE IF EXISTS stg.stg_acap_asset_doc_line_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_acap_asset_doc_line_dtl
(
    ou_id integer NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    doc_type character varying(160) COLLATE public.nocase NOT NULL,
    doc_number character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer,
    proposal_number character varying(72) COLLATE public.nocase,
    doc_amount numeric,
    pending_cap_amt numeric,
    cap_amount numeric,
    tag_group character varying(24) COLLATE public.nocase,
    doc_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT acap_asset_doc_line_dtl_pkey UNIQUE (ou_id, cap_number, asset_number, doc_type, doc_number, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_acap_asset_doc_line_dtl
    OWNER to proconnect;
-- Index: stg_acap_asset_doc_line_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_acap_asset_doc_line_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_acap_asset_doc_line_dtl_key_idx2
    ON stg.stg_acap_asset_doc_line_dtl USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;