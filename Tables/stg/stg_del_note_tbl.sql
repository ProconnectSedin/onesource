CREATE TABLE stg.stg_del_note_tbl (
    row_id integer NOT NULL,
    orderno character varying(1000) COLLATE public.nocase,
    outboundno character varying(1000) COLLATE public.nocase,
    packconfrim character varying(1000) COLLATE public.nocase,
    del_note character varying(1000) COLLATE public.nocase,
    create_date timestamp without time zone,
    update_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_del_note_tbl ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_del_note_tbl_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);