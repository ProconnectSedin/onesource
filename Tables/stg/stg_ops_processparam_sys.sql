CREATE TABLE stg.stg_ops_processparam_sys (
    ou_id integer NOT NULL,
    parameter_type character varying(24) NOT NULL COLLATE public.nocase,
    parameter_category character varying(64) NOT NULL COLLATE public.nocase,
    parameter_code character varying(512) NOT NULL COLLATE public.nocase,
    language_id integer NOT NULL,
    "timestamp" integer NOT NULL,
    parameter_text character varying(400) COLLATE public.nocase,
    extension_flag character varying(4) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_ops_processparam_sys
    ADD CONSTRAINT ops_processparam_sys_pkey PRIMARY KEY (ou_id, parameter_type, parameter_category, parameter_code, language_id);