CREATE TABLE stg.stg_con_module_master (
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