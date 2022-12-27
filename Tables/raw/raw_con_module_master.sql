CREATE TABLE raw.raw_con_module_master (
    raw_id bigint NOT NULL,
    tranou integer NOT NULL,
    appid integer NOT NULL,
    moduleid integer NOT NULL,
    modulename character varying(200) COLLATE public.nocase,
    moduleurl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    orderby integer,
    enabled integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_con_module_master ALTER COLUMN moduleid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_con_module_master_moduleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_con_module_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_con_module_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_con_module_master
    ADD CONSTRAINT raw_con_module_master_pkey PRIMARY KEY (raw_id);