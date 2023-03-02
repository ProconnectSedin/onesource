-- Table: dwh.d_ainfassetgroupmst

-- DROP TABLE IF EXISTS dwh.d_ainfassetgroupmst;

CREATE TABLE IF NOT EXISTS dwh.d_ainfassetgroupmst
(
    ainfassetgroupmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    asset_group_code character varying(50) COLLATE public.nocase,
    "timestamp" integer,
    asset_group_desc character varying(80) COLLATE public.nocase,
    parent_group character varying(50) COLLATE public.nocase,
    asset_group_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ainfassetgroupmst_pkey PRIMARY KEY (ainfassetgroupmst_key),
    CONSTRAINT d_ainfassetgroupmst_ukey UNIQUE (asset_group_code, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ainfassetgroupmst
    OWNER to proconnect;