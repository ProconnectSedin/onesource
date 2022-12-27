CREATE TABLE stg.stg_mast_type (
    row_id integer NOT NULL,
    ordertype character varying(1000) COLLATE public.nocase,
    pri_ordertype character varying(1000) COLLATE public.nocase,
    description character varying(1000) COLLATE public.nocase,
    sec_ordertype character varying(1000) COLLATE public.nocase,
    pri_reqtype character varying(1000) COLLATE public.nocase,
    sec_reqtype character varying(1000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_mast_type ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_mast_type_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);