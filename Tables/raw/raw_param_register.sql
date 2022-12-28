CREATE TABLE raw.raw_param_register (
    raw_id bigint NOT NULL,
    param_id integer NOT NULL,
    reg_id integer,
    header_name character varying(250) COLLATE public.nocase,
    param_name character varying(250) COLLATE public.nocase,
    data_type text,
    json_type character varying(20) COLLATE public.nocase,
    is_mandatory integer,
    param_datatype character varying(10) COLLATE public.nocase,
    param_operator character varying(10) COLLATE public.nocase,
    param_condition character varying(250) NOT NULL COLLATE public.nocase,
    created_date timestamp without time zone,
    created_by character varying(50) COLLATE public.nocase,
    updated_date timestamp without time zone,
    updated_by character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_param_register ALTER COLUMN param_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_param_register_param_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_param_register ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_param_register_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_param_register
    ADD CONSTRAINT raw_param_register_pkey PRIMARY KEY (raw_id);