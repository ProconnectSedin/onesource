CREATE TABLE raw.raw_menu_master (
    raw_id bigint NOT NULL,
    menuid integer NOT NULL,
    menuname character varying(150) NOT NULL COLLATE public.nocase,
    isactive integer NOT NULL,
    menustate character varying(50) COLLATE public.nocase,
    createdby character varying(50) COLLATE public.nocase,
    createddatetime timestamp without time zone,
    modifiedby character varying(50) COLLATE public.nocase,
    modifieddatetime character varying(50) COLLATE public.nocase,
    imagename character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_menu_master ALTER COLUMN menuid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_menu_master_menuid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_menu_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_menu_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_menu_master
    ADD CONSTRAINT raw_menu_master_pkey PRIMARY KEY (raw_id);