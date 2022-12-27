CREATE TABLE raw.raw_pcsit_int_mw_tbl (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    trip_id character varying(1000) COLLATE public.nocase,
    status character varying(1000) COLLATE public.nocase,
    res_mes text,
    sent_mes text,
    create_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_int_mw_tbl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_int_mw_tbl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_int_mw_tbl ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_int_mw_tbl_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_int_mw_tbl
    ADD CONSTRAINT raw_pcsit_int_mw_tbl_pkey PRIMARY KEY (raw_id);