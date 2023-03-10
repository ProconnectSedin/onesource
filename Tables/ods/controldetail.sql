CREATE TABLE ods.controldetail (
    id integer NOT NULL,
    sourcename character varying(100),
    sourcetype character varying(50),
    sourcedescription character varying(100),
    sourceid character varying(100),
    sourceobject character varying(500),
    dataflowflag character varying(50),
    isreadyforexecution integer,
    loadtype character varying(15),
    loadfrequency character varying(10),
    flowstatus character varying(10),
    targetname character varying(50),
    targetschemaname character varying(10),
    targetobject character varying(150),
    targetprocedurename character varying(150),
    jobname character varying(100),
    createddate timestamp without time zone,
    lastupdateddate timestamp without time zone,
    createduser character varying(100),
    isapplicable integer,
    profilename character varying(100),
    emailto character varying(500),
    archcondition character varying,
    isdecomreq integer,
    archintvlcond character varying,
    sourcequery character varying(10000),
    sourcecallingseq integer,
    etllastrundate timestamp without time zone,
    latestbatchid integer,
    executiontype character varying(40),
    intervaldays integer
);

ALTER TABLE ods.controldetail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.controldetail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY ods.controldetail
    ADD CONSTRAINT controldetail_pkey PRIMARY KEY (id);