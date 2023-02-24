-- Table: dwh.d_ainfassetclassmst

-- DROP TABLE IF EXISTS dwh.d_ainfassetclassmst;

CREATE TABLE IF NOT EXISTS dwh.d_ainfassetclassmst
(
    ainfassetclassmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    asset_class_code character varying(40) COLLATE public.nocase,
    ou_id integer,
    "timestamp" integer,
    asset_class_desc character varying(80) COLLATE public.nocase,
    depreciable character varying(10) COLLATE public.nocase,
    inv_cycle character varying(30) COLLATE public.nocase,
    asset_class_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    asset_prefix character varying(20) COLLATE public.nocase,
    lastgenno character varying(80) COLLATE public.nocase,
    lease_asset character varying(80) COLLATE public.nocase,
    land_info character varying(80) COLLATE public.nocase,
    residual_val numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ainfassetclassmst_pkey PRIMARY KEY (ainfassetclassmst_key),
    CONSTRAINT d_ainfassetclassmst_ukey UNIQUE (asset_class_code, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ainfassetclassmst
    OWNER to proconnect;
-- Index: d_ainfassetclassmst_key_idx

-- DROP INDEX IF EXISTS dwh.d_ainfassetclassmst_key_idx;

CREATE INDEX IF NOT EXISTS d_ainfassetclassmst_key_idx
    ON dwh.d_ainfassetclassmst USING btree
    (asset_class_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;