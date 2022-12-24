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