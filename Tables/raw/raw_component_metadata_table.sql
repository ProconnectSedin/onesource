CREATE TABLE raw.raw_component_metadata_table (
    raw_id bigint NOT NULL,
    componentname character varying(100) NOT NULL COLLATE public.nocase,
    paramcategory character varying(40) NOT NULL COLLATE public.nocase,
    paramtype character varying(60) NOT NULL COLLATE public.nocase,
    paramcode character varying(32) NOT NULL COLLATE public.nocase,
    optionvalue character varying(32) COLLATE public.nocase,
    sequenceno integer,
    paramdesc character varying(1020) NOT NULL COLLATE public.nocase,
    paramdesc_shd character varying(1020) COLLATE public.nocase,
    langid integer NOT NULL,
    cml_len integer,
    cml_translate character(8) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_component_metadata_table ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_component_metadata_table_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_component_metadata_table
    ADD CONSTRAINT raw_component_metadata_table_pkey PRIMARY KEY (raw_id);