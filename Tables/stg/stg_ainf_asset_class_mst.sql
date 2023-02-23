-- Table: stg.stg_ainf_asset_class_mst

-- DROP TABLE IF EXISTS stg.stg_ainf_asset_class_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ainf_asset_class_mst
(
    asset_class_code character varying(80) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    "timestamp" integer,
    asset_class_desc character varying(160) COLLATE public.nocase,
    depreciable character varying(12) COLLATE public.nocase,
    inv_cycle character varying(60) COLLATE public.nocase,
    asset_class_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    asset_prefix character varying(40) COLLATE public.nocase,
    lastgenno character varying(160) COLLATE public.nocase,
    lease_asset character varying(160) COLLATE public.nocase,
    land_info character varying(160) COLLATE public.nocase,
    residual_val numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ainf_asset_class_mst_pkey PRIMARY KEY (asset_class_code, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainf_asset_class_mst
    OWNER to proconnect;
-- Index: stg_ainf_asset_class_mst_key_idx

-- DROP INDEX IF EXISTS stg.stg_ainf_asset_class_mst_key_idx;

CREATE INDEX IF NOT EXISTS stg_ainf_asset_class_mst_key_idx
    ON stg.stg_ainf_asset_class_mst USING btree
    (asset_class_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;