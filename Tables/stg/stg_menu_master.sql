CREATE TABLE stg.stg_menu_master (
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

ALTER TABLE stg.stg_menu_master ALTER COLUMN menuid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_menu_master_menuid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_menu_master
    ADD CONSTRAINT pcs_mobility_menu_master_tbl_pk PRIMARY KEY (menuid);