-- Table: raw.raw_supp_sgs_suplgroupmap

-- DROP TABLE IF EXISTS "raw".raw_supp_sgs_suplgroupmap;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_sgs_suplgroupmap
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_sgs_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_sgs_supgrpcode character varying(80) COLLATE public.nocase NOT NULL,
    supp_sgs_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_sgs_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_sgs_createddate timestamp without time zone NOT NULL,
    supp_sgs_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_sgs_modifieddate timestamp without time zone NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_supp_sgs_suplgroupmap_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_sgs_suplgroupmap
    OWNER to proconnect;