CREATE TABLE stg.stg_pcsit_int_mw_tbl (
    row_id integer NOT NULL,
    trip_id character varying(1000) COLLATE public.nocase,
    status character varying(1000) COLLATE public.nocase,
    res_mes text,
    sent_mes text,
    create_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);