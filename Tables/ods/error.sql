CREATE TABLE ods.error (
    id integer NOT NULL,
    sourcename character varying(100),
    sourcetype character varying(50),
    sourcedescription character varying(100),
    sourceid character varying(50),
    sourceobject character varying(500),
    dataflowflag character varying(50),
    targetname character varying(50),
    targetschemaname character varying(10),
    targetobject character varying(150),
    targetprocedurename character varying(150),
    taskname character varying(200),
    packagename character varying(200),
    jobname character varying(100),
    errorid integer,
    errordesc character varying,
    errorline integer,
    errordate timestamp without time zone,
    latestbatchid integer,
    sourcegroupflag integer
);

ALTER TABLE ods.error ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.error_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY ods.error
    ADD CONSTRAINT error_pkey PRIMARY KEY (id);