-- Table: raw.raw_acap_reverse_asset_hdr

-- DROP TABLE IF EXISTS "raw".raw_acap_reverse_asset_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_acap_reverse_asset_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    document_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    tran_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    asset_number character varying(72) COLLATE public.nocase,
    asset_desc character varying(160) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_group character varying(100) COLLATE public.nocase,
    remarks character varying(400) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_acap_reverse_asset_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_acap_reverse_asset_hdr
    OWNER to proconnect;