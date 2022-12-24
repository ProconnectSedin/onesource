CREATE TABLE stg.stg_co_module_mst (
    tranou integer,
    moduleid integer,
    modulename character varying(200) COLLATE public.nocase,
    moduleurl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);