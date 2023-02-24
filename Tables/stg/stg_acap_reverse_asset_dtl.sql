-- Table: stg.stg_acap_reverse_asset_dtl

-- DROP TABLE IF EXISTS stg.stg_acap_reverse_asset_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_acap_reverse_asset_dtl
(
    ou_id integer NOT NULL,
    document_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    "timestamp" integer,
    tag_desc character varying(160) COLLATE public.nocase,
    depr_category character varying(160) COLLATE public.nocase,
    business_use numeric,
    inservice_date timestamp without time zone,
    asset_location character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    tag_cost numeric,
    tag_status character varying(8) COLLATE public.nocase,
    inv_cycle character varying(60) COLLATE public.nocase,
    salvage_value numeric,
    manufacturer character varying(240) COLLATE public.nocase,
    bar_code character varying(72) COLLATE public.nocase,
    serial_no character varying(72) COLLATE public.nocase,
    warranty_no character varying(72) COLLATE public.nocase,
    model character varying(160) COLLATE public.nocase,
    custodian character varying(308) COLLATE public.nocase,
    book_value numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT acap_reverse_asset_dtl_pkey PRIMARY KEY (ou_id, document_number, tag_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_acap_reverse_asset_dtl
    OWNER to proconnect;
-- Index: stg_acap_reverse_asset_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_acap_reverse_asset_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_acap_reverse_asset_dtl_idx
    ON stg.stg_acap_reverse_asset_dtl USING btree
    (ou_id ASC NULLS LAST, document_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST)
    TABLESPACE pg_default;