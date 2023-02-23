-- Table: stg.stg_supp_sgs_suplgroupmap

-- DROP TABLE IF EXISTS stg.stg_supp_sgs_suplgroupmap;

CREATE TABLE IF NOT EXISTS stg.stg_supp_sgs_suplgroupmap
(
    supp_sgs_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_sgs_supgrpcode character varying(80) COLLATE public.nocase NOT NULL,
    supp_sgs_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_sgs_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_sgs_createddate timestamp without time zone NOT NULL,
    supp_sgs_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_sgs_modifieddate timestamp without time zone NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_supgroupmap PRIMARY KEY (supp_sgs_loid, supp_sgs_supgrpcode, supp_sgs_supcode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_supp_sgs_suplgroupmap
    OWNER to proconnect;