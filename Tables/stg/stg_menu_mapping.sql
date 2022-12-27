CREATE TABLE stg.stg_menu_mapping (
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

ALTER TABLE ONLY stg.stg_menu_mapping
    ADD CONSTRAINT screen_user_mapping PRIMARY KEY (mappingid);