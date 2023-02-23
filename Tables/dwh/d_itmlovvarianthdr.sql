-- Table: dwh.d_itmlovvarianthdr

-- DROP TABLE IF EXISTS dwh.d_itmlovvarianthdr;

CREATE TABLE IF NOT EXISTS dwh.d_itmlovvarianthdr
(
    itm_lov_variant_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    lov_itemcode character varying(64) COLLATE public.nocase,
    lov_variantcode character varying(16) COLLATE public.nocase,
    lov_lo character varying(40) COLLATE public.nocase,
    lov_variantshortdesc character varying(500) COLLATE public.nocase,
    lov_engchangectrl character(1) COLLATE pg_catalog."default",
    lov_stockuom character varying(20) COLLATE public.nocase,
    lov_matlspecification character varying(5000) COLLATE public.nocase,
    lov_created_ou integer,
    lov_created_by character varying(60) COLLATE public.nocase,
    lov_created_date timestamp without time zone,
    lov_modified_by character varying(60) COLLATE public.nocase,
    lov_modified_date timestamp without time zone,
    lov_created_langid integer,
    lov_itmvardesc character varying(2000) COLLATE public.nocase,
    lov_multiuom_track character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_itmlovvarianthdr_pkey PRIMARY KEY (itm_lov_variant_hdr_key),
    CONSTRAINT d_itmlovvarianthdr_ukey UNIQUE (lov_itemcode, lov_variantcode, lov_lo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_itmlovvarianthdr
    OWNER to proconnect;