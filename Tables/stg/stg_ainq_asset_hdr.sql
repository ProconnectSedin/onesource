-- Table: stg.stg_ainq_asset_hdr

-- DROP TABLE IF EXISTS stg.stg_ainq_asset_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_ainq_asset_hdr
(
    ou_id integer NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    cap_date timestamp without time zone,
    cap_status character varying(100) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    asset_group character varying(100) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_desc character varying(160) COLLATE public.nocase,
    asset_cost numeric,
    asset_location character varying(80) COLLATE public.nocase,
    seq_no integer,
    as_on_date timestamp without time zone,
    asset_type character varying(40) COLLATE public.nocase,
    asset_status character varying(8) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_code character varying(128) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    depr_book character varying(80) COLLATE public.nocase NOT NULL,
    asset_classification character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ainq_asset_hdr_pkey PRIMARY KEY (ou_id, cap_number, asset_number, depr_book)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainq_asset_hdr
    OWNER to proconnect;
-- Index: stg_ainq_asset_hdr_key_idx

-- DROP INDEX IF EXISTS stg.stg_ainq_asset_hdr_key_idx;

CREATE INDEX IF NOT EXISTS stg_ainq_asset_hdr_key_idx
    ON stg.stg_ainq_asset_hdr USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;