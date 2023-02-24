-- Table: stg.stg_acap_asset_doc_dtl

-- DROP TABLE IF EXISTS stg.stg_acap_asset_doc_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_acap_asset_doc_dtl
(
    ou_id integer NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    doc_type character varying(160) COLLATE public.nocase NOT NULL,
    doc_number character varying(72) COLLATE public.nocase NOT NULL,
    supplier_name character varying(240) COLLATE public.nocase,
    "timestamp" integer,
    doc_date timestamp without time zone,
    doc_amount numeric,
    pending_cap_amt numeric,
    proposal_number character varying(72) COLLATE public.nocase,
    gr_date timestamp without time zone,
    currency character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    cap_amount numeric,
    finance_bookid character varying(80) COLLATE public.nocase,
    doc_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tran_ou integer,
    tran_type character varying(40) COLLATE public.nocase,
    cap_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT acap_asset_doc_dtl_pkey UNIQUE (ou_id, cap_number, asset_number, doc_type, doc_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_acap_asset_doc_dtl
    OWNER to proconnect;
-- Index: stg_acap_asset_doc_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_acap_asset_doc_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_acap_asset_doc_dtl_key_idx2
    ON stg.stg_acap_asset_doc_dtl USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;