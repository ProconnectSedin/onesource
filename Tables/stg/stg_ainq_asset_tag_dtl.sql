-- Table: stg.stg_ainq_asset_tag_dtl

-- DROP TABLE IF EXISTS stg.stg_ainq_asset_tag_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ainq_asset_tag_dtl
(
    ou_id integer NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    cap_number character varying(72) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    asset_desc character varying(160) COLLATE public.nocase,
    tag_desc character varying(160) COLLATE public.nocase,
    asset_location character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    inservice_date timestamp without time zone,
    tag_cost numeric,
    tag_status character varying(8) COLLATE public.nocase,
    depr_category character varying(160) COLLATE public.nocase,
    inv_cycle character varying(60) COLLATE public.nocase,
    salvage_value numeric,
    manufacturer character varying(240) COLLATE public.nocase,
    bar_code character varying(72) COLLATE public.nocase,
    serial_no character varying(72) COLLATE public.nocase,
    warranty_no character varying(72) COLLATE public.nocase,
    model character varying(160) COLLATE public.nocase,
    custodian character varying(308) COLLATE public.nocase,
    business_use numeric,
    reverse_remarks character varying(400) COLLATE public.nocase,
    book_value numeric,
    revalued_cost numeric,
    inv_date timestamp without time zone,
    inv_due_date timestamp without time zone,
    inv_status character varying(100) COLLATE public.nocase,
    softrev_run_no character varying(80) COLLATE public.nocase,
    insurable_value numeric,
    policy_count character varying(16) COLLATE public.nocase,
    dest_fbid character varying(80) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    legacy_asset_no character varying(72) COLLATE public.nocase,
    migration_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    proposal_number character varying(72) COLLATE public.nocase,
    cum_down_rev_cost numeric,
    cum_up_rev_cost numeric,
    split_date timestamp without time zone,
    depr_book character varying(80) COLLATE public.nocase NOT NULL,
    residualvalue numeric,
    usefullifeinmonths integer,
    cum_imp_loss numeric,
    ari_flag character varying(48) COLLATE public.nocase DEFAULT 'N'::character varying,
    asset_category character varying(1020) COLLATE public.nocase,
    asset_cluster character varying(1020) COLLATE public.nocase,
    asset_capacity numeric,
    asset_capacity_uom character varying(40) COLLATE public.nocase,
    asset_appr_capacity numeric,
    asset_cumdep_capacity numeric,
    asset_usage_uptp timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ainq_asset_tag_dtl_pkey PRIMARY KEY (ou_id, asset_number, tag_number, cap_number, fb_id, depr_book)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainq_asset_tag_dtl
    OWNER to proconnect;
-- Index: stg_ainq_asset_tag_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_ainq_asset_tag_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_ainq_asset_tag_dtl_key_idx
    ON stg.stg_ainq_asset_tag_dtl USING btree
    (ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;