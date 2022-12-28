CREATE TABLE stg.stg_con_child_master (
    tranou integer NOT NULL,
    appid integer NOT NULL,
    moduleid integer NOT NULL,
    parentid integer NOT NULL,
    childid integer NOT NULL,
    childname character varying(200) COLLATE public.nocase,
    childurl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    orderby integer,
    enabled integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_con_child_master ALTER COLUMN childid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_con_child_master_childid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_con_child_master
    ADD CONSTRAINT pk_con_child_master_1 PRIMARY KEY (childid);