-- Table: raw.raw_itm_loi_itemhdr

-- DROP TABLE IF EXISTS "raw".raw_itm_loi_itemhdr;

CREATE TABLE IF NOT EXISTS "raw".raw_itm_loi_itemhdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loi_itemcode character varying(128) COLLATE public.nocase NOT NULL,
    loi_lo character varying(80) COLLATE public.nocase NOT NULL,
    loi_accountgroup character varying(80) COLLATE public.nocase,
    loi_itemdesc character varying(3000) COLLATE public.nocase,
    loi_itemshortdesc character varying(2000) COLLATE public.nocase,
    loi_variantallowd integer NOT NULL,
    loi_nextvariantno integer NOT NULL,
    loi_templateflg character(4) COLLATE public.nocase NOT NULL,
    loi_ac_created_by character varying(120) COLLATE public.nocase,
    loi_ac_created_date timestamp without time zone,
    loi_ac_modified_by character varying(120) COLLATE public.nocase,
    loi_ac_modified_date timestamp without time zone,
    loi_created_langid integer NOT NULL,
    loi_modelvariant character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_itm_loi_itemhdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_itm_loi_itemhdr
    OWNER to proconnect;