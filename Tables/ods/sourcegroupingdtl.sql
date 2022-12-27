CREATE TABLE ods.sourcegroupingdtl (
    id integer NOT NULL,
    sourcegroup character varying(100),
    sourceid character varying(100),
    schemaname character varying(40),
    frequency character varying(40),
    isapplicable integer,
    lastrundatetime timestamp without time zone,
    status character varying(40),
    loadstartdatetime timestamp without time zone,
    loadenddatetime timestamp without time zone
);

ALTER TABLE ods.sourcegroupingdtl ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.sourcegroupingdtl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);