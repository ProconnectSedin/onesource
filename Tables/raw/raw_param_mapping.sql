CREATE TABLE raw.raw_param_mapping (
    raw_id bigint NOT NULL,
    param_map_id integer NOT NULL,
    service_map_id integer,
    reference_id integer,
    header_name character varying(250) COLLATE public.nocase,
    param_name character varying(250) COLLATE public.nocase,
    is_mandatory integer,
    param_datatype character varying(10) COLLATE public.nocase,
    param_operator character varying(10) COLLATE public.nocase,
    param_condition character varying(250) COLLATE public.nocase,
    iw_header_name character varying(250) COLLATE public.nocase,
    iw_map_param_name character varying(250) COLLATE public.nocase,
    iw_param_value character varying(250) COLLATE public.nocase,
    ow_header_name character varying(250) COLLATE public.nocase,
    ow_map_param_name character varying(250) COLLATE public.nocase,
    ow_param_value character varying(250) COLLATE public.nocase,
    created_date timestamp without time zone,
    created_by character varying(50) COLLATE public.nocase,
    updated_date timestamp without time zone,
    updated_by character varying(50) COLLATE public.nocase,
    param_type character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_param_mapping ALTER COLUMN param_map_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_param_mapping_param_map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_param_mapping ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_param_mapping_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_param_mapping
    ADD CONSTRAINT raw_param_mapping_pkey PRIMARY KEY (raw_id);