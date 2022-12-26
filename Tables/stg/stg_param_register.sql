CREATE TABLE stg.stg_param_register (
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