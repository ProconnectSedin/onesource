CREATE TABLE raw.raw_co_useracess (
    raw_id bigint NOT NULL,
    username character varying(100) COLLATE public.nocase,
    reportname character varying(100) COLLATE public.nocase,
    reportdatetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_co_useracess ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_co_useracess_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_co_useracess
    ADD CONSTRAINT raw_co_useracess_pkey PRIMARY KEY (raw_id);