CREATE TABLE raw.raw_co_module_mst (
    raw_id bigint NOT NULL,
    tranou integer,
    moduleid integer,
    modulename character varying(200) COLLATE public.nocase,
    moduleurl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);