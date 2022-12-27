CREATE TABLE ods.dwhtoclickcontroldtl (
    id bigint NOT NULL,
    objecttype character varying(40) COLLATE public.nocase,
    objectname character varying(100) COLLATE public.nocase,
    executionflag integer,
    seqexecution integer,
    status character varying(40) COLLATE public.nocase,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    loadtype character varying(40),
    loadstartdatetime timestamp without time zone,
    loadenddatetime timestamp without time zone,
    loadfrequency character varying(20),
    depsource character varying(100)
);

ALTER TABLE ods.dwhtoclickcontroldtl ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.dwhtoclickcontroldtl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);