CREATE TABLE raw.raw_pcsit_dwh_metatable (
    raw_id bigint NOT NULL,
    tranou integer,
    actiontype character varying(30) COLLATE public.nocase,
    actionpoint character varying(30) COLLATE public.nocase,
    last_updated_datetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_dwh_metatable ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_dwh_metatable_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_dwh_metatable
    ADD CONSTRAINT raw_pcsit_dwh_metatable_pkey PRIMARY KEY (raw_id);