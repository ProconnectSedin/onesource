CREATE TABLE ods.audit (
    id integer NOT NULL,
    sourcename character varying(100),
    sourcetype character varying(50),
    sourcedescription character varying(100),
    sourceobject character varying(50),
    sourceid character varying(100),
    dataflowflag character varying(50),
    srcrwcnt integer,
    srcdelcnt integer,
    tgtinscnt integer,
    tgtdelcnt integer,
    tgtupdcnt integer,
    flowstatus character varying(10),
    targetname character varying(50),
    targetschemaname character varying(10),
    targetobject character varying(150),
    targetprocedurename character varying(150),
    createddate timestamp without time zone,
    updateddate timestamp without time zone,
    loadstarttime timestamp without time zone,
    loadendtime timestamp without time zone,
    latestbatchid integer,
    loadtype character varying(50),
    etlbatchid character varying,
    useragent character varying,
    sourcegroupflag integer
);

ALTER TABLE ods.audit ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY ods.audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (id);