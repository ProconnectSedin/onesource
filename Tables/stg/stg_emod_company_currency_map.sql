CREATE TABLE stg.stg_emod_company_currency_map (
    serial_no integer NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    currency_code character varying(20) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    map_status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    map_by character varying(120) COLLATE public.nocase,
    map_date timestamp without time zone,
    unmap_by character varying(120) COLLATE public.nocase,
    unmap_date timestamp without time zone,
    currency_flag character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_emod_company_currency_map
    ADD CONSTRAINT emod_company_currency_map_pkey PRIMARY KEY (serial_no, company_code, currency_code);