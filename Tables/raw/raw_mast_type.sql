CREATE TABLE raw.raw_mast_type (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    ordertype character varying(1000) COLLATE public.nocase,
    pri_ordertype character varying(1000) COLLATE public.nocase,
    description character varying(1000) COLLATE public.nocase,
    sec_ordertype character varying(1000) COLLATE public.nocase,
    pri_reqtype character varying(1000) COLLATE public.nocase,
    sec_reqtype character varying(1000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_mast_type ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_mast_type_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_mast_type ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_mast_type_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_mast_type
    ADD CONSTRAINT raw_mast_type_pkey PRIMARY KEY (raw_id);