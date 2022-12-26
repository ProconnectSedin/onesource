CREATE TABLE raw.raw_co_userscreen_mapping (
    raw_id bigint NOT NULL,
    tranou integer,
    moduleid integer,
    parentid integer,
    childid integer,
    username character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);