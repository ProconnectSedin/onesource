CREATE TABLE ods.controlheader (
    id integer NOT NULL,
    sourcename character varying(100),
    sourcetype character varying(50),
    sourcedescription character varying(100),
    sourceid character varying(100),
    connectionstr character varying(1000),
    adlscontainername character varying(50),
    dwobjectname character varying(50),
    objecttype character varying(10),
    dldirstructure character varying(50),
    dlpurgeflag character(1),
    dwpurgeflag character(1),
    ftpcheck integer NOT NULL,
    status character varying(10),
    createddate timestamp without time zone,
    lastupdateddate timestamp without time zone,
    createduser character varying(100),
    isapplicable integer,
    profilename character varying(100),
    emailto character varying(500),
    archcondition character varying,
    depsource character varying(100),
    archintvlcond character varying,
    sourcecallingseq integer,
    apiurl character varying(500),
    apimethod character varying(20),
    apiauthorizationtype character varying(50),
    apiaccesstoken character varying(500),
    apipymodulename character varying(500),
    apiqueryparameters character varying(2000),
    apirequestbody character varying(2000),
    envsourcecode character varying(100),
    datasourcecode character varying(100),
    sourcedelimiter character(10),
    rawstorageflag integer DEFAULT 1,
    sourcegroup character varying(40)
);

ALTER TABLE ods.controlheader ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.controlheader_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY ods.controlheader
    ADD CONSTRAINT controlheader_pkey PRIMARY KEY (id);