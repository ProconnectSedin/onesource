CREATE TABLE raw.raw_fin_quick_code_met (
    raw_id bigint NOT NULL,
    component_id character varying(80) NOT NULL COLLATE public.nocase,
    parameter_type character varying(24) NOT NULL COLLATE public.nocase,
    parameter_category character varying(80) COLLATE public.nocase,
    parameter_code character varying(72) NOT NULL COLLATE public.nocase,
    parameter_text character varying(1020) COLLATE public.nocase,
    "timestamp" integer,
    language_id integer,
    extension_flag character varying(4) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    sequence_no integer,
    cml_len integer,
    cml_translate character varying(8) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);