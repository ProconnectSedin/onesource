CREATE TABLE raw.raw_co_parent_mst (
    raw_id bigint NOT NULL,
    tranou integer,
    moduleid integer,
    parentid integer,
    parentname character varying(200) COLLATE public.nocase,
    parenturl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);