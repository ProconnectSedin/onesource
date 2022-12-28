CREATE TABLE stg.stg_con_parent_master (
    tranou integer NOT NULL,
    appid integer NOT NULL,
    moduleid integer NOT NULL,
    parentid integer NOT NULL,
    parentname character varying(200) COLLATE public.nocase,
    parenturl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    orderby integer,
    enabled integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_con_parent_master ALTER COLUMN parentid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_con_parent_master_parentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_con_parent_master
    ADD CONSTRAINT pk_con_parent_master_1 PRIMARY KEY (parentid);