CREATE TABLE raw.raw_con_userscreen_mapping (
    raw_id bigint NOT NULL,
    tranou integer NOT NULL,
    appid integer NOT NULL,
    moduleid integer NOT NULL,
    parentid integer NOT NULL,
    childid integer NOT NULL,
    username character varying(50) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_con_userscreen_mapping ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_con_userscreen_mapping_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_con_userscreen_mapping
    ADD CONSTRAINT raw_con_userscreen_mapping_pkey PRIMARY KEY (raw_id);