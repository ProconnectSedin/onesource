CREATE TABLE stg.stg_pcsit_int_mw_tbl (
    row_id integer NOT NULL,
    trip_id character varying(1000) COLLATE public.nocase,
    status character varying(1000) COLLATE public.nocase,
    res_mes text,
    sent_mes text,
    create_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_int_mw_tbl ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_int_mw_tbl_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);