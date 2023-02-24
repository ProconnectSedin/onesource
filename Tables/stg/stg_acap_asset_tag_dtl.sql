-- Table: stg.stg_acap_asset_tag_dtl

-- DROP TABLE IF EXISTS stg.stg_acap_asset_tag_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_acap_asset_tag_dtl
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
    proposal_number character varying(72) COLLATE public.nocase,
    tag_status character varying(100) COLLATE public.nocase,
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
    tag_cost_orig numeric,
    tag_cost_diff numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    amend_status character varying(100) COLLATE public.nocase,
    residualvalue numeric,
    usefullifeinmonths integer,
    remaining_loy integer,
    remaining_lom integer,
    remaining_lod integer,
    cumdep numeric,
    assign_date timestamp without time zone,
    loan_mapped character varying(4) COLLATE public.nocase,
    laccount_code character varying(128) COLLATE public.nocase,
    laccount_desc character varying(240) COLLATE public.nocase,
    lcost_center character varying(40) COLLATE public.nocase,
    lanalysis_code character varying(20) COLLATE public.nocase,
    lsubanalysis_code character varying(20) COLLATE public.nocase,
    asset_category character varying(1020) COLLATE public.nocase,
    asset_cluster character varying(1020) COLLATE public.nocase,
    asset_capacity numeric,
    asset_capacity_uom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT acap_asset_tag_dtl_pkey UNIQUE (ou_id, asset_number, tag_number, cap_number, fb_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_acap_asset_tag_dtl
    OWNER to proconnect;
-- Index: stg_acap_asset_tag_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_acap_asset_tag_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_acap_asset_tag_dtl_key_idx2
    ON stg.stg_acap_asset_tag_dtl USING btree
    (ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;