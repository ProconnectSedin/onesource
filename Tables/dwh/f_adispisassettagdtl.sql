-- Table: dwh.f_adispisassettagdtl

-- DROP TABLE IF EXISTS dwh.f_adispisassettagdtl;

CREATE TABLE IF NOT EXISTS dwh.f_adispisassettagdtl
(
    adispis_asset_tag_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    guid character varying(260) COLLATE public.nocase,
    ou_id integer,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    fb_id character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    cap_number character varying(40) COLLATE public.nocase,
    tag_status character varying(10) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adispisassettagdtl_pkey PRIMARY KEY (adispis_asset_tag_dtl_key),
    CONSTRAINT f_adispisassettagdtl_ukey UNIQUE (guid, ou_id, asset_number, tag_number, fb_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adispisassettagdtl
    OWNER to proconnect;
-- Index: f_adispisassettagdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_adispisassettagdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_adispisassettagdtl_key_idx
    ON dwh.f_adispisassettagdtl USING btree
    (guid COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;