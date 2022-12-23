-- Table: ods.controldetailaudit

-- DROP TABLE IF EXISTS ods.controldetailaudit;

CREATE TABLE IF NOT EXISTS ods.controldetailaudit
(
    id integer,
    sourcename character varying(100) COLLATE public.nocase,
    sourcetype character varying(50) COLLATE public.nocase,
    sourcedescription character varying(100) COLLATE public.nocase,
    sourceid character varying(100) COLLATE public.nocase,
    sourceobject character varying(500) COLLATE public.nocase,
    dataflowflag character varying(50) COLLATE public.nocase,
    isreadyforexecution integer,
    loadtype character varying(15) COLLATE public.nocase,
    loadfrequency character varying(10) COLLATE public.nocase,
    flowstatus character varying(10) COLLATE public.nocase,
    targetname character varying(50) COLLATE public.nocase,
    targetschemaname character varying(10) COLLATE public.nocase,
    targetobject character varying(150) COLLATE public.nocase,
    targetprocedurename character varying(150) COLLATE public.nocase,
    jobname character varying(100) COLLATE public.nocase,
    createddate timestamp without time zone,
    lastupdateddate timestamp without time zone,
    createduser character varying(100) COLLATE public.nocase,
    isapplicable integer,
    profilename character varying(100) COLLATE public.nocase,
    emailto character varying(500) COLLATE public.nocase,
    archcondition character varying COLLATE public.nocase,
    isdecomreq integer,
    archintvlcond character varying COLLATE public.nocase,
    sourcequery character varying(10000) COLLATE public.nocase,
    sourcecallingseq integer,
    etllastrundate timestamp without time zone,
    latestbatchid integer,
    executiontype character varying(40) COLLATE public.nocase,
    intervaldays integer,
	eventname character varying(40) COLLATE public.nocase,
    auditcreateddate timestamp default now()::timestamp
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.controldetailaudit
    OWNER to proconnect;