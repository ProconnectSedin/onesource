-- Table: raw.raw_ainf_asset_group_mst

-- DROP TABLE IF EXISTS "raw".raw_ainf_asset_group_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_ainf_asset_group_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    asset_group_code character varying(100) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    asset_group_desc character varying(160) COLLATE public.nocase,
    parent_group character varying(100) COLLATE public.nocase,
    asset_group_status character varying(100) COLLATE public.nocase,
    ou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_ainf_asset_group_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ainf_asset_group_mst
    OWNER to proconnect;