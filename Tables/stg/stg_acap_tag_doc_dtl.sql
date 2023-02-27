-- Table: stg.stg_acap_tag_doc_dtl

-- DROP TABLE IF EXISTS stg.stg_acap_tag_doc_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_acap_tag_doc_dtl
(
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    doc_number character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    doc_amount numeric,
    doc_type character varying(160) COLLATE public.nocase NOT NULL,
    cap_amount numeric,
    proposal_number character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tran_ou integer,
    tran_type character varying(40) COLLATE public.nocase,
    tag_cost numeric,
    project_code character varying(280) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT acap_tag_doc_dtl_pkey UNIQUE (ou_id, fb_id, cap_number, asset_number, tag_number, doc_number, line_no, account_code, doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_acap_tag_doc_dtl
    OWNER to proconnect;
-- Index: stg_acap_tag_doc_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_acap_tag_doc_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_acap_tag_doc_dtl_key_idx2
    ON stg.stg_acap_tag_doc_dtl USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;