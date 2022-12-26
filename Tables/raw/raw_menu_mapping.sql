CREATE TABLE raw.raw_menu_mapping (
    raw_id bigint NOT NULL,
    mappingid character varying(30) NOT NULL COLLATE public.nocase,
    userid integer NOT NULL,
    menuid integer NOT NULL,
    isactive integer NOT NULL,
    createdby integer NOT NULL,
    createddatetime timestamp without time zone NOT NULL,
    modifiedby integer,
    modifieddatetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);