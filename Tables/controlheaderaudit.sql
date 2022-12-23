-- Table: ods.controlheaderaudit

-- DROP TABLE IF EXISTS ods.controlheaderaudit;

CREATE TABLE IF NOT EXISTS ods.controlheaderaudit
(
    id integer,
    sourcename character varying(100) COLLATE public.nocase,
    sourcetype character varying(50) COLLATE public.nocase,
    sourcedescription character varying(100) COLLATE public.nocase,
    sourceid character varying(100) COLLATE public.nocase,
    connectionstr character varying(1000) COLLATE public.nocase,
    adlscontainername character varying(50) COLLATE public.nocase,
    dwobjectname character varying(50) COLLATE public.nocase,
    objecttype character varying(10) COLLATE public.nocase,
    dldirstructure character varying(50) COLLATE public.nocase,
    dlpurgeflag character(1) COLLATE public.nocase,
    dwpurgeflag character(1) COLLATE public.nocase,
    ftpcheck integer NOT NULL,
    status character varying(10) COLLATE public.nocase,
    createddate timestamp without time zone,
    lastupdateddate timestamp without time zone,
    createduser character varying(100) COLLATE public.nocase,
    isapplicable integer,
    profilename character varying(100) COLLATE public.nocase,
    emailto character varying(500) COLLATE public.nocase,
    archcondition character varying COLLATE public.nocase,
    depsource character varying(100) COLLATE public.nocase,
    archintvlcond character varying COLLATE public.nocase,
    sourcecallingseq integer,
    apiurl character varying(500) COLLATE public.nocase,
    apimethod character varying(20) COLLATE public.nocase,
    apiauthorizationtype character varying(50) COLLATE public.nocase,
    apiaccesstoken character varying(500) COLLATE public.nocase,
    apipymodulename character varying(500) COLLATE public.nocase,
    apiqueryparameters character varying(2000) COLLATE public.nocase,
    apirequestbody character varying(2000) COLLATE public.nocase,
    envsourcecode character varying(100) COLLATE public.nocase,
    datasourcecode character varying(100) COLLATE public.nocase,
    sourcedelimiter character(10) COLLATE public.nocase,
    rawstorageflag integer DEFAULT 1,
    sourcegroup character varying(40) COLLATE public.nocase,
	eventname character varying(40) COLLATE public.nocase,
    auditcreateddate timestamp default now()::timestamp
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.controlheaderaudit
    OWNER to proconnect;