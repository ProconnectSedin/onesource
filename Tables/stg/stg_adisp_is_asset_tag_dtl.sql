-- Table: stg.stg_adisp_is_asset_tag_dtl

-- DROP TABLE IF EXISTS stg.stg_adisp_is_asset_tag_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_adisp_is_asset_tag_dtl
(
    guid character varying(512) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    cap_number character varying(72) COLLATE public.nocase,
    proposal_number character varying(72) COLLATE public.nocase,
    tag_status character varying(8) COLLATE public.nocase,
    dest_fbid character varying(80) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    asset_location character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adisp_is_asset_tag_dtl_pkey PRIMARY KEY (guid, ou_id, asset_number, tag_number, fb_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adisp_is_asset_tag_dtl
    OWNER to proconnect;
-- Index: stg_adisp_is_asset_tag_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_adisp_is_asset_tag_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_adisp_is_asset_tag_dtl_idx
    ON stg.stg_adisp_is_asset_tag_dtl USING btree
    (guid COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;