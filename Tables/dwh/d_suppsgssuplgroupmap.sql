-- Table: dwh.d_suppsgssuplgroupmap

-- DROP TABLE IF EXISTS dwh.d_suppsgssuplgroupmap;

CREATE TABLE IF NOT EXISTS dwh.d_suppsgssuplgroupmap
(
    suppsgssuplgroupmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_sgs_loid character varying(40) COLLATE public.nocase,
    supp_sgs_supgrpcode character varying(40) COLLATE public.nocase,
    supp_sgs_supcode character varying(32) COLLATE public.nocase,
    supp_sgs_createdby character varying(60) COLLATE public.nocase,
    supp_sgs_createddate timestamp without time zone,
    supp_sgs_modifiedby character varying(60) COLLATE public.nocase,
    supp_sgs_modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_suppsgssuplgroupmap_pkey PRIMARY KEY (suppsgssuplgroupmap_key),
    CONSTRAINT d_suppsgssuplgroupmap_ukey UNIQUE (supp_sgs_loid, supp_sgs_supgrpcode, supp_sgs_supcode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_suppsgssuplgroupmap
    OWNER to proconnect;