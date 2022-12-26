CREATE TABLE raw.raw_con_parent_master (
    raw_id bigint NOT NULL,
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