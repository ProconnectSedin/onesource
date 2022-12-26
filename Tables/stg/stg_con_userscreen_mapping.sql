CREATE TABLE stg.stg_con_userscreen_mapping (
    tranou integer NOT NULL,
    appid integer NOT NULL,
    moduleid integer NOT NULL,
    parentid integer NOT NULL,
    childid integer NOT NULL,
    username character varying(50) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);