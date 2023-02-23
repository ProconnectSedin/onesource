-- Table: raw.raw_cps_taxparam_sys

-- DROP TABLE IF EXISTS "raw".raw_cps_taxparam_sys;

CREATE TABLE IF NOT EXISTS "raw".raw_cps_taxparam_sys
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE pg_catalog."default",
    ou_id integer,
    tax_type character varying(100) COLLATE pg_catalog."default",
    tax_community character varying(100) COLLATE pg_catalog."default",
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
    CONSTRAINT raw_cps_taxparam_sys_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cps_taxparam_sys
    OWNER to proconnect;