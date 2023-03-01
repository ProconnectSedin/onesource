-- Table: raw.raw_adisp_is_asset_tag_dtl

-- DROP TABLE IF EXISTS "raw".raw_adisp_is_asset_tag_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_adisp_is_asset_tag_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_adisp_is_asset_tag_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adisp_is_asset_tag_dtl
    OWNER to proconnect;