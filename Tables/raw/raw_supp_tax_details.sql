-- Table: raw.raw_supp_tax_details

-- DROP TABLE IF EXISTS "raw".raw_supp_tax_details;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_tax_details
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_tax_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_tax_companycode character varying(40) COLLATE public.nocase NOT NULL,
    supp_tax_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_tax_type character varying(100) COLLATE public.nocase NOT NULL,
    supp_tax_community character varying(100) COLLATE public.nocase NOT NULL,
    supp_tax_serialno integer NOT NULL,
    supp_tax_option character varying(160) COLLATE public.nocase,
    supp_tax_assesseetype character varying(160) COLLATE public.nocase,
    supp_tax_regiontype character varying(32) COLLATE public.nocase,
    supp_tax_region character varying(40) COLLATE public.nocase,
    supp_tax_regdno character varying(160) COLLATE public.nocase,
    supp_tax_category character varying(160) COLLATE public.nocase NOT NULL,
    supp_tax_class character varying(160) COLLATE public.nocase NOT NULL,
    supp_tax_taxrateappl character varying(160) COLLATE public.nocase NOT NULL,
    supp_tax_code character varying(40) COLLATE public.nocase,
    supp_tax_splrate numeric,
    supp_tax_certno character varying(80) COLLATE public.nocase,
    supp_tax_placeissue character varying(100) COLLATE public.nocase,
    supp_tax_dateissue timestamp without time zone,
    supp_tax_validupto timestamp without time zone,
    supp_tax_remarks character varying(1024) COLLATE public.nocase,
    supp_tax_default character varying(32) COLLATE public.nocase NOT NULL,
    supp_tax_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_tax_createddate timestamp without time zone NOT NULL,
    supp_tax_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_tax_modifieddate timestamp without time zone NOT NULL,
    supp_tax_value numeric,
    supp_tax_gstverdate timestamp without time zone,
    supp_cumm_val numeric,
    pan_no character varying(160) COLLATE public.nocase,
    aadhaar_no character varying(160) COLLATE public.nocase,
    tax_status character varying(100) COLLATE public.nocase,
    return_frequency character varying(160) COLLATE public.nocase,
    tax_regno_status character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_supp_tax_details_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_tax_details
    OWNER to proconnect;