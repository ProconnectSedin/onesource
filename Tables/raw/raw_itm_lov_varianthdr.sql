-- Table: raw.raw_itm_lov_varianthdr

-- DROP TABLE IF EXISTS "raw".raw_itm_lov_varianthdr;

CREATE TABLE IF NOT EXISTS "raw".raw_itm_lov_varianthdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    lov_itemcode character varying(128) COLLATE public.nocase NOT NULL,
    lov_variantcode character varying(32) COLLATE public.nocase NOT NULL,
    lov_lo character varying(80) COLLATE public.nocase NOT NULL,
    lov_variantshortdesc character varying(1000) COLLATE public.nocase,
    lov_drgrevisionno character(12) COLLATE public.nocase,
    lov_revisionno character(12) COLLATE public.nocase,
    lov_drgref character varying(400) COLLATE public.nocase,
    lov_engchangectrl character(4) COLLATE public.nocase NOT NULL,
    lov_stockuom character varying(40) COLLATE public.nocase NOT NULL,
    lov_matlspecification character varying COLLATE public.nocase,
    lov_segment character(8) COLLATE public.nocase,
    lov_family character(8) COLLATE public.nocase,
    lov_class character(8) COLLATE public.nocase,
    lov_commodity character(8) COLLATE public.nocase,
    lov_businessfunc character(8) COLLATE public.nocase,
    lov_created_ou integer NOT NULL,
    lov_created_by character varying(120) COLLATE public.nocase NOT NULL,
    lov_created_date timestamp without time zone NOT NULL,
    lov_modified_by character varying(120) COLLATE public.nocase NOT NULL,
    lov_modified_date timestamp without time zone NOT NULL,
    lov_created_langid integer NOT NULL,
    lov_itmvardesc character varying(4000) COLLATE public.nocase,
    lov_processflag character varying(48) COLLATE public.nocase,
    lov_alternateuom character varying(40) COLLATE public.nocase,
    lov_multiuom_track character varying(32) COLLATE public.nocase NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_itm_lov_varianthdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_itm_lov_varianthdr
    OWNER to proconnect;