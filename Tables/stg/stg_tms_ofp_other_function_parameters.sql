CREATE TABLE stg.stg_tms_ofp_other_function_parameters (
    ofp_ou integer NOT NULL,
    ofp_parameter_code character varying(160) NOT NULL COLLATE public.nocase,
    ofp_parameter_desc character varying(1020) COLLATE public.nocase,
    ofp_value character(4) COLLATE public.nocase,
    ofp_timestamp integer,
    ofp_created_by character varying(120) COLLATE public.nocase,
    ofp_created_date timestamp without time zone,
    ofp_last_modified_by character varying(120) COLLATE public.nocase,
    ofp_last_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_ofp_other_function_parameters
    ADD CONSTRAINT tms_ofp_other_function_parameters_pk PRIMARY KEY (ofp_ou, ofp_parameter_code);