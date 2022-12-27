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

ALTER TABLE raw.raw_menu_mapping ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_menu_mapping_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_menu_mapping
    ADD CONSTRAINT raw_menu_mapping_pkey PRIMARY KEY (raw_id);