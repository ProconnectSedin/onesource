CREATE TABLE raw.raw_del_note_tbl (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    orderno character varying(1000) COLLATE public.nocase,
    outboundno character varying(1000) COLLATE public.nocase,
    packconfrim character varying(1000) COLLATE public.nocase,
    del_note character varying(1000) COLLATE public.nocase,
    create_date timestamp without time zone,
    update_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_del_note_tbl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_del_note_tbl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_del_note_tbl ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_del_note_tbl_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_del_note_tbl
    ADD CONSTRAINT raw_del_note_tbl_pkey PRIMARY KEY (raw_id);