-- Table: raw.raw_ainf_asset_class_mst

-- DROP TABLE IF EXISTS "raw".raw_ainf_asset_class_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_ainf_asset_class_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT ainf_asset_class_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ainf_asset_class_mst
    OWNER to proconnect;