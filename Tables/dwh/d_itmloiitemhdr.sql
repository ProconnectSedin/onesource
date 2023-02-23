-- Table: dwh.d_itmloiitemhdr

-- DROP TABLE IF EXISTS dwh.d_itmloiitemhdr;

CREATE TABLE IF NOT EXISTS dwh.d_itmloiitemhdr
(
    itm_loi_item_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loi_itemcode character varying(64) COLLATE public.nocase,
    loi_lo character varying(40) COLLATE public.nocase,
    loi_accountgroup character varying(40) COLLATE public.nocase,
    loi_itemdesc character varying(1500) COLLATE public.nocase,
    loi_itemshortdesc character varying(1000) COLLATE public.nocase,
    loi_variantallowd integer,
    loi_nextvariantno integer,
    loi_templateflg character(1) COLLATE pg_catalog."default",
    loi_ac_created_by character varying(60) COLLATE public.nocase,
    loi_ac_created_date timestamp without time zone,
    loi_ac_modified_by character varying(60) COLLATE public.nocase,
    loi_ac_modified_date timestamp without time zone,
    loi_created_langid integer,
    loi_modelvariant character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_itmloiitemhdr_pkey PRIMARY KEY (itm_loi_item_hdr_key),
    CONSTRAINT d_itmloiitemhdr_ukey UNIQUE (loi_itemcode, loi_lo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_itmloiitemhdr
    OWNER to proconnect;