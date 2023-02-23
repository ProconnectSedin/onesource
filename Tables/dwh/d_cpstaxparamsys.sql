-- Table: dwh.d_cpstaxparamsys

-- DROP TABLE IF EXISTS dwh.d_cpstaxparamsys;

CREATE TABLE IF NOT EXISTS dwh.d_cpstaxparamsys
(
    cpstaxparamsys_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    ou_id integer,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    taxclosure_decl_ou integer,
    default_calculation character varying(24) COLLATE public.nocase,
    registration_no character varying(80) COLLATE public.nocase,
    default_taxtype character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    effective_from timestamp without time zone,
    ret1_applicability_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_cpstaxparamsys_pkey PRIMARY KEY (cpstaxparamsys_key),
    CONSTRAINT d_cpstaxparamsys_ukey UNIQUE (company_code, ou_id, tax_type, tax_community)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_cpstaxparamsys
    OWNER to proconnect;