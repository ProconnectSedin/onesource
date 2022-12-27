CREATE TABLE raw.raw_co_module_mst (
    raw_id bigint NOT NULL,
    tranou integer,
    moduleid integer,
    modulename character varying(200) COLLATE public.nocase,
    moduleurl character varying(200) COLLATE public.nocase,
    classname character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_co_module_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_co_module_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_co_module_mst
    ADD CONSTRAINT raw_co_module_mst_pkey PRIMARY KEY (raw_id);