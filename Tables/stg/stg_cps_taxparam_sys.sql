-- Table: stg.stg_cps_taxparam_sys

-- DROP TABLE IF EXISTS stg.stg_cps_taxparam_sys;

CREATE TABLE IF NOT EXISTS stg.stg_cps_taxparam_sys
(
    company_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    ou_id integer NOT NULL,
    tax_type character varying(100) COLLATE pg_catalog."default" NOT NULL,
    tax_community character varying(100) COLLATE pg_catalog."default" NOT NULL,
    taxclosure_decl_ou integer,
    default_calculation character varying(48) COLLATE pg_catalog."default",
    registration_no character varying(160) COLLATE pg_catalog."default",
    default_taxtype character varying(100) COLLATE pg_catalog."default",
    createdby character varying(120) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    ret1_applicability_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT cps_taxparam_sys_pk PRIMARY KEY (company_code, ou_id, tax_type, tax_community)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cps_taxparam_sys
    OWNER to proconnect;