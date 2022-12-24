CREATE TABLE stg.stg_cps_processparam_sys (
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    ou_id integer NOT NULL,
    parameter_type character varying(24) NOT NULL COLLATE public.nocase,
    parameter_category character varying(64) NOT NULL COLLATE public.nocase,
    parameter_code character varying(120) NOT NULL COLLATE public.nocase,
    language_id integer NOT NULL,
    "timestamp" integer,
    parameter_text character varying(400) COLLATE public.nocase,
    extension_flag character varying(4) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    parameter_value numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);