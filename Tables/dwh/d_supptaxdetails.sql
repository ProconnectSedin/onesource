-- Table: dwh.d_supptaxdetails

-- DROP TABLE IF EXISTS dwh.d_supptaxdetails;

CREATE TABLE IF NOT EXISTS dwh.d_supptaxdetails
(
    supptaxdetails_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_tax_loid character varying(40) COLLATE public.nocase,
    supp_tax_companycode character varying(20) COLLATE public.nocase,
    supp_tax_supcode character varying(32) COLLATE public.nocase,
    supp_tax_type character varying(50) COLLATE public.nocase,
    supp_tax_community character varying(50) COLLATE public.nocase,
    supp_tax_serialno integer,
    supp_tax_option character varying(80) COLLATE public.nocase,
    supp_tax_assesseetype character varying(80) COLLATE public.nocase,
    supp_tax_regiontype character varying(16) COLLATE public.nocase,
    supp_tax_region character varying(20) COLLATE public.nocase,
    supp_tax_regdno character varying(80) COLLATE public.nocase,
    supp_tax_category character varying(80) COLLATE public.nocase,
    supp_tax_class character varying(80) COLLATE public.nocase,
    supp_tax_taxrateappl character varying(80) COLLATE public.nocase,
    supp_tax_code character varying(20) COLLATE public.nocase,
    supp_tax_splrate numeric(20,2),
    supp_tax_certno character varying(40) COLLATE public.nocase,
    supp_tax_placeissue character varying(50) COLLATE public.nocase,
    supp_tax_dateissue timestamp without time zone,
    supp_tax_validupto timestamp without time zone,
    supp_tax_remarks character varying(512) COLLATE public.nocase,
    supp_tax_default character varying(16) COLLATE public.nocase,
    supp_tax_createdby character varying(60) COLLATE public.nocase,
    supp_tax_createddate timestamp without time zone,
    supp_tax_modifiedby character varying(60) COLLATE public.nocase,
    supp_tax_modifieddate timestamp without time zone,
    supp_tax_value numeric(20,2),
    supp_cumm_val numeric(20,2),
    pan_no character varying(80) COLLATE public.nocase,
    return_frequency character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_supptaxdetails_pkey PRIMARY KEY (supptaxdetails_key),
    CONSTRAINT d_supptaxdetails_ukey UNIQUE (supp_tax_loid, supp_tax_companycode, supp_tax_supcode, supp_tax_type, supp_tax_community, supp_tax_serialno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_supptaxdetails
    OWNER to proconnect;
-- Index: d_supptaxdetails_key_idx1

-- DROP INDEX IF EXISTS dwh.d_supptaxdetails_key_idx1;

CREATE INDEX IF NOT EXISTS d_supptaxdetails_key_idx1
    ON dwh.d_supptaxdetails USING btree
    (supp_tax_loid COLLATE public.nocase ASC NULLS LAST, supp_tax_companycode COLLATE public.nocase ASC NULLS LAST, supp_tax_supcode COLLATE public.nocase ASC NULLS LAST, supp_tax_type COLLATE public.nocase ASC NULLS LAST, supp_tax_community COLLATE public.nocase ASC NULLS LAST, supp_tax_serialno ASC NULLS LAST)
    TABLESPACE pg_default;